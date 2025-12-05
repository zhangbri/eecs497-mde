//
//  FriendsView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 11/14/25.
//

import SwiftUI
import Supabase

struct Friend: Identifiable, Equatable {
    let id = UUID()
    let name: String     // derived from email
    let handle: String   // the email itself
}

struct FriendsView: View {
    @EnvironmentObject private var router: TabRouter
    @Environment(\.dismiss) private var dismiss
    @AppStorage("coins") private var coins: Int = 0
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
    
    @State private var showingAddFriends = false
    @State private var friends: [Friend] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    private let barHeight: CGFloat = 78
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color(hex: "EBE3D7").ignoresSafeArea()
                
                ScrollView(.vertical) {
                    VStack {
                        header
                        friendsList
                        addFriendsButton
                    }
                }
                
                BottomNavBar(selection: $router.tab) { _ in }
                    .frame(height: barHeight)
                    .background(Color(hex: "EBE3D7"))
                    .ignoresSafeArea(edges: .bottom)
                    .offset(y: 34)
                
                if showingAddFriends {
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                    AddFriendsPopup(
                        isPresented: $showingAddFriends,
                        onAddFriend: { emailOrHandle in
                            Task { await addFriend(email: emailOrHandle) }
                        }
                    )
                }
            }
            .onAppear {
                Task { await loadFriends() }
            }
        }
    }
    
    // MARK: - UI pieces
    
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
            .padding(.top, 8)
            
            ZStack {
                Text("Friends")
                    .font(.custom("Moulpali-Regular", size: 48))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .overlay(
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image("rightarrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                    }
                }
            )
            .offset(y: -43)
        }
    }
    
    private var friendsList: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.bottom, 4)
            }
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 25) {
                    if friends.isEmpty && !isLoading {
                        Text("No friends yet. Add some!")
                            .font(.custom("Moulpali-Regular", size: 20))
                    } else {
                        ForEach(friends) { friend in
                            FriendRowView(
                                name: friend.name,
                                handle: friend.handle,
                                onRemove: {
                                    Task { await removeFriend(friend: friend) }
                                }
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 375)
            .offset(y: -150)
        }
    }
    
    private var addFriendsButton: some View {
        VStack {
            Button {
                showingAddFriends = true
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "B2E5AB"))
                    .frame(width: 220, height: 50)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .overlay(
                        Text("Add Friends")
                            .font(.custom("Moulpali-Regular", size: 30))
                            .foregroundColor(.black)
                    )
            }
        }
        .offset(y: -130)
    }
    
    // MARK: - DB models
    
    private struct DBUser: Decodable {
        let id: Int?
        let email: String
        let friends: [String]?
    }
    
    // MARK: - DB logic
    
    private func loadFriends() async {
        guard !currentUserEmail.isEmpty else {
            errorMessage = "No logged-in user."
            return
        }
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        let client = SupabaseManager.shared.client
        
        do {
            // 1) Get current user to read friends array
            let rows: [DBUser] = try await client
                .from("users")
                .select("email,friends")
                .eq("email", value: currentUserEmail)
                .limit(1)
                .execute()
                .value
            
            guard let me = rows.first else {
                errorMessage = "Current user not found in DB."
                return
            }
            
            let friendEmails = me.friends ?? []
            if friendEmails.isEmpty {
                friends = []
                return
            }
            
            // 2) Load friend users by email
            let friendRows: [DBUser] = try await client
                .from("users")
                .select("email")
                .in("email", value: friendEmails)
                .execute()
                .value
            
            friends = friendRows.map { row in
                Friend(
                    name: usernameFromEmail(row.email),
                    handle: row.email
                )
            }
        } catch {
            print("Load friends error:", error)
            errorMessage = "Failed to load friends."
        }
    }
    
    private func addFriend(email: String) async {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !currentUserEmail.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        let client = SupabaseManager.shared.client
        
        do {
            // 1) Get current user's existing friends
            let rows: [DBUser] = try await client
                .from("users")
                .select("email,friends")
                .eq("email", value: currentUserEmail)
                .limit(1)
                .execute()
                .value
            
            guard let me = rows.first else { return }
            var friendEmails = me.friends ?? []
            
            if friendEmails.contains(trimmed) {
                errorMessage = "Already friends with this user."
                return
            }
            
            // 2) Check that the target user exists
            let existing: [DBUser] = try await client
                .from("users")
                .select("email")
                .eq("email", value: trimmed)
                .limit(1)
                .execute()
                .value
            
            if existing.isEmpty {
                errorMessage = "No user exists with that email."
                return
            }
            
            friendEmails.append(trimmed)
            
            // 3) Update DB friends array
            try await client
                .from("users")
                .update(["friends": friendEmails])
                .eq("email", value: currentUserEmail)
                .execute()
            
            // 4) Append to local list
            if let row = existing.first {
                let newFriend = Friend(
                    name: usernameFromEmail(row.email),
                    handle: row.email
                )
                friends.append(newFriend)
            }
        } catch {
            print("Add friend error:", error)
            errorMessage = "Failed to add friend."
        }
    }
    
    private func removeFriend(friend: Friend) async {
        guard !currentUserEmail.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        let client = SupabaseManager.shared.client
        
        do {
            // 1) Get current user's friend list
            let rows: [DBUser] = try await client
                .from("users")
                .select("email,friends")
                .eq("email", value: currentUserEmail)
                .limit(1)
                .execute()
                .value
            
            guard let me = rows.first else { return }
            var friendEmails = me.friends ?? []
            
            friendEmails.removeAll { $0 == friend.handle }
            
            // 2) Update DB
            try await client
                .from("users")
                .update(["friends": friendEmails])
                .eq("email", value: currentUserEmail)
                .execute()
            
            // 3) Update local state
            friends.removeAll { $0.id == friend.id }
        } catch {
            print("Remove friend error:", error)
            errorMessage = "Failed to remove friend."
        }
    }
}

// Helper: turn "user@example.com" into "user"
private func usernameFromEmail(_ email: String) -> String {
    email.components(separatedBy: "@").first ?? email
}

struct FriendRowView: View {
    let name: String
    let handle: String
    let onRemove: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hex: "F2EDE7"))
            .frame(width: 340, height: 70)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .overlay(
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                        .foregroundColor(Color(hex: "FFFFFF"))
                        .padding(.leading, 18)
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.custom("Moulpali-Regular", size: 30))
                        Text(handle)
                            .font(.custom("Sarabun-Light", size: 16))
                            .offset(y: -16)
                    }
                    .padding(.leading, 7)
                    .offset(y: -2)
                    
                    Spacer()
                    
                    Button {
                        onRemove()
                    } label: {
                        Image("removefriend")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 15)
                    }
                }
            )
    }
}

struct AddFriendsPopup: View {
    @Binding var isPresented: Bool
    @State private var searchText: String = ""
    @State private var isAdded = false
    
    let onAddFriend: (String) -> Void
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "EBE3D7"))
                    .frame(width: proxy.size.width * 0.85,
                           height: proxy.size.height * 0.80)
                
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isPresented = false
                        } label: {
                            ZStack {
                                Circle()
                                    .stroke(Color.black, lineWidth: 4)
                                    .frame(width: 33, height: 33)
                                Image(systemName: "xmark")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .offset(x: -48, y: -314)
                
                VStack {
                    Text("Add Friends")
                        .font(.custom("Moulpali-Regular", size: 35))
                        .foregroundColor(.black)
                        .offset(y: 85)
                    
                    TextField("Username, phone number, or email", text: $searchText)
                        .padding(.horizontal, 16)
                        .frame(width: 320, height: 40)
                        .foregroundColor(Color(hex: "2596be"))
                        .font(.custom("Moulpali-Regular", size: 16))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: "d9d9d9"), lineWidth: 1)
                                )
                        )
                        .offset(y: 20)
                    
                    Spacer()
                    
                    Text("Friend Requests")
                        .font(.custom("Moulpali-Regular", size: 30))
                        .foregroundColor(.black)
                        .padding(.bottom, 225)
                    
                    VStack(spacing: 5) {
                        Text("No friend requests at this time.")
                        Text("Add more friends!")
                    }
                    .font(.custom("Sarabun-Light", size: 15))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, -245)
                    
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color(hex: "F2EDE7"))
//                        .frame(width: 300, height: 70)
//                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
//                        .overlay(
//                            HStack {
//                                Image(systemName: "person.circle.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 46, height: 46)
//                                    .foregroundColor(Color(hex: "FFFFFF"))
//                                    .padding(.leading, 16)
//                                
//                                VStack (alignment: .leading){
//                                    Text(searchText.isEmpty ? "User" : usernameFromEmail(searchText))
//                                        .font(.custom("Moulpali-Regular", size: 26))
//                                        .foregroundColor(.black)
//                                    
//                                    Text(searchText.isEmpty ? "@User" : searchText)
//                                        .font(.custom("Sarabun-Light", size: 15))
//                                        .foregroundColor(.black)
//                                        .offset(y: -12)
//                                }
//                                .offset(y: -2)
//                                
//                                Spacer()
//                                
//                                Button {
//                                    isAdded.toggle()
//                                    onAddFriend(searchText)
//                                } label: {
//                                    Image(isAdded ? "addedfriend" : "addfriend")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 32, height: 32)
//                                        .padding(.trailing, 17.5)
//                                }
//                            }
//                        )
//                        .padding(.top, -245)
                }
            }
        }
    }
}

#Preview {
    FriendsView()
        .environmentObject(TabRouter())
}

