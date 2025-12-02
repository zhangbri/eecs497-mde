//
//  LeaderboardView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI
import Supabase

struct LeaderboardUser: Identifiable, Decodable {
    let id: Int
    let email: String
    let total_hours: Int
}

struct LeaderboardView: View {
    @EnvironmentObject private var router: TabRouter
    @AppStorage("coins") private var coins: Int = 0
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
    
    @State private var showingShareSheet = false
    @State private var showingFriends = false
    @State private var users: [LeaderboardUser] = []
    @State private var errorMessage: String?
    
    private let barHeight: CGFloat = 78
    
    private var currentWeekRange: String {
        let calendar = Calendar.current
        let now = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeek))"
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color(hex: "EBE3D7").ignoresSafeArea()
                ScrollView(.vertical) {
                    ZStack {
                        VStack {
                            header
                            if let errorMessage = errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .offset(y: -60)
                            }
                            podium
                            rows45
                            inviteButton
                            Spacer().frame(height: 90)
                        }
                    }
                }
                BottomNavBar(selection: $router.tab) { _ in }
                    .frame(height: barHeight)
                    .background(Color(hex: "EBE3D7"))
                    .ignoresSafeArea(edges: .bottom)
                    .offset(y: 34)
            }
            .fullScreenCover(isPresented: $showingFriends) {
                FriendsView()
                    .environmentObject(router)
            }
            .onAppear {
                Task { await loadLeaderboard() }
            }
        }
    }
    
    // MARK: - UI helpers
    
    private var header: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 49)
                Text("pawse")
                    .font(.custom("VictorMono-Regular", size: 30))
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "F2EDE7"))
                        .frame(width: 110, height: 49)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    HStack {
                        Image("coin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 51, height: 51)
                            .offset(x: 5, y: 1)
                        Text("\(coins)")
                            .font(.custom("Moulpali-Regular", size: 25))
                            .frame(width: 60, alignment: .center)
                            .offset(x: -8)
                    }
                }
                .offset(x: -15)
            }
            .padding(.leading, 15)
            
            ZStack {
                Text("Leaderboard")
                    .font(.custom("Moulpali-Regular", size: 48))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .overlay(
                HStack {
                    Button(action: { showingFriends = true }) {
                        Image("leftarrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                    }
                    .padding(.leading, -5)
                    
                    Image("friends")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .offset(x: -20)
                },
                alignment: .leading
            )
            .offset(y: -35)
            
            Text("Week of: \(currentWeekRange)")
                .font(.custom("Moulpali-Regular", size: 24))
                .offset(y: -60)
        }
    }
    
    private func formattedHours(_ h: Int) -> String {
        "\(h) hrs"
    }
    
    private var podium: some View {
        HStack(alignment: .bottom, spacing: 15) {
            podiumCard(
                rankImage: "2nd",
                width: 120,
                height: 150,
                user: users.count > 1 ? users[1] : nil
            )
            
            podiumCard(
                rankImage: "1st",
                width: 155,
                height: 200,
                user: users.first
            )
            
            podiumCard(
                rankImage: "3rd",
                width: 110,
                height: 150,
                user: users.count > 2 ? users[2] : nil
            )
        }
        .offset(y: -85)
    }
    
    private func podiumCard(rankImage: String, width: CGFloat, height: CGFloat, user: LeaderboardUser?) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hex: "F2EDE7"))
            .frame(width: width, height: height)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .overlay(
                VStack {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: rankImage == "1st" ? 100 : 63,
                                   height: rankImage == "1st" ? 100 : 63)
                            .foregroundColor(Color(hex: "FFFFFF"))
                        Image(rankImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: rankImage == "1st" ? 62 : 54,
                                   height: rankImage == "1st" ? 62 : 54)
                            .offset(x: rankImage == "1st" ? 30 : 24, y: -8)
                    }
                    .offset(y: rankImage == "1st" ? 35 : 40)
                    
                    Text(user != nil ? usernameFromEmail(user!.email) : "User")
                        .font(.custom("Moulpali-Regular", size: 30))
                    Text(user != nil ? formattedHours(user!.total_hours) : "0 hrs")
                        .font(.custom("Moulpali-Regular", size: 16))
                        .offset(y: -25)
                }
            )
    }
    
    private var rows45: some View {
        VStack {
            if users.count > 3 {
                leaderboardRow(rank: 4, user: users[3])
                    .offset(y: -35)
            }
            if users.count > 4 {
                leaderboardRow(rank: 5, user: users[4])
                    .offset(y: -10)
            }
        }
    }
    
    private func leaderboardRow(rank: Int, user: LeaderboardUser) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hex: "F2EDE7"))
            .frame(width: 368, height: 73)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .overlay(
                HStack {
                    Text("\(rank).")
                        .font(.custom("Moulpali-Regular", size: 30))
                        .padding(.leading, -58)
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                        .foregroundColor(Color(hex: "FFFFFF"))
                        .offset(x: -20)
                    Text(usernameFromEmail(user.email))
                        .font(.custom("Moulpali-Regular", size: 30))
                    Text(formattedHours(user.total_hours))
                        .font(.custom("Moulpali-Regular", size: 16))
                        .offset(x: 58)
                }
            )
    }
    
    private var inviteButton: some View {
        Button(action: {
            showingShareSheet = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "80CCDD"))
                    .frame(width: 147, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)
                    )
                Text("Invite your friends!")
                    .font(.custom("Moulpali-Regular", size: 16))
                    .foregroundColor(.white)
            }
            .offset(y: 20)
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(items: [
                "Join me on Pawse and compete on the leaderboard!"
            ])
        }
    }
    
    // MARK: - DB models
    
    private struct DBUser: Decodable {
        let email: String
        let friends: [String]?
    }
    
    // MARK: - DB logic
    
    private func loadLeaderboard() async {
        let client = SupabaseManager.shared.client
        
        do {
            // If we know who the current user is, try to build a
            // leaderboard of [me + my friends].
            if !currentUserEmail.isEmpty {
                let meRows: [DBUser] = try await client
                    .from("users")
                    .select("email,friends")
                    .eq("email", value: currentUserEmail)
                    .limit(1)
                    .execute()
                    .value
                
                if let me = meRows.first {
                    var emailSet = Set<String>()
                    emailSet.insert(me.email)
                    if let fs = me.friends {
                        for e in fs {
                            emailSet.insert(e)
                        }
                    }
                    
                    let emailArray = Array(emailSet)
                    if !emailArray.isEmpty {
                        let group: [LeaderboardUser] = try await client
                            .from("users")
                            .select("id,email,total_hours")
                            .in("email", value: emailArray)
                            .order("total_hours", ascending: false)
                            .limit(5)
                            .execute()
                            .value
                        
                        users = group
                        return
                    }
                }
            }
            
            // Fallback: global top 5 by total_hours (good for dummy demo accounts)
            users = try await client
                .from("users")
                .select("id,email,total_hours")
                .order("total_hours", ascending: false)
                .limit(5)
                .execute()
                .value
        } catch {
            print("Leaderboard error:", error)
            errorMessage = "Failed to load leaderboard."
        }
    }
}


private func usernameFromEmail(_ email: String) -> String {
    email.components(separatedBy: "@").first ?? email
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        controller.excludedActivityTypes = []
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    LeaderboardView().environmentObject(TabRouter())
}
