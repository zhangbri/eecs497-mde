// ProfileView.swift
// ScreenTime
//
// Created by Brian Zhang on 10/2/25.
//
import SwiftUI

struct Friend: Identifiable, Codable {
    let id: UUID
    var name: String
    var username: String
    
    init(id: UUID = UUID(), name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}

struct ProfileView: View {
    @EnvironmentObject private var router: TabRouter
    private let gridCols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @AppStorage("coins") private var coins: Int = 0
    private let barHeight: CGFloat = 78
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var pronouns: String = ""
    
    // Friend list management
    @State private var friends: [Friend] = []
    @State private var showingAddFriend = false
    @State private var newFriendName = ""
    @State private var newFriendUsername = ""
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color(hex: "EBE3D7").ignoresSafeArea()
                
                ScrollView(.vertical) {
                    ZStack {
                        VStack {
                            HStack {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 49)
                                
                                Text("pawse")
                                    .font(.custom("VictorMono-Regular", size: 30))
                                    .foregroundColor(.black)
                                
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
                                            .multilineTextAlignment(.center)
                                            .offset(x: -8)
                                    }
                                }
                                .offset(x: -15, y: 0)
                            }
                            .padding(.leading, 15)
                            
                            Text("Profile")
                                .font(.custom("Moulpali-Regular", size: 48))
                                .offset(y: -70)
                            
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 205, height: 205)
                                .foregroundColor(Color(hex: "FFFFFF"))
                                .padding(.top, -170)
                            
                            Text("edit profile picture")
                                .font(.custom("Sarabun-Light", size: 16))
                                .padding(.top, 4)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            
                            VStack() {
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                                
                                HStack {
                                    Text("Name").font(.custom("Sarabun-Bold", size: 20))
                                    TextField("Name", text: $name)
                                        .font(.custom("Sarabun-Regular", size: 20))
                                        .padding(.leading, 48)
                                }
                                .padding(.horizontal, 25)
                                .frame(height: 40)
                                
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                                
                                HStack {
                                    Text("Username")
                                        .font(.custom("Sarabun-Bold", size: 20))
                                    TextField("Username", text: $username)
                                        .font(.custom("Sarabun-Regular", size: 20))
                                        .padding(.leading, 9.5)
                                }
                                .padding(.horizontal, 25)
                                .frame(height: 40)
                                
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                                
                                HStack {
                                    Text("Pronouns")
                                        .font(.custom("Sarabun-Bold", size: 20))
                                    TextField("Pronouns", text: $pronouns)
                                        .font(.custom("Sarabun-Regular", size: 20))
                                        .padding(.leading, 15.5)
                                }
                                .padding(.horizontal, 25)
                                .frame(height: 40)
                                
                                Rectangle()
                                    .fill(Color(hex: "C9BEAE"))
                                    .frame(height: 1.5)
                            }
                            .padding(.top, 7.5)
                            
                            // Friends Section
                            HStack {
                                Text("Friends")
                                    .font(.custom("Moulpali-Regular", size: 48))
                                
                                Button(action: {
                                    showingAddFriend = true
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(Color(hex: "C9BEAE"))
                                }
                            }
                            .padding(.top, 25)
                            
                            if friends.isEmpty {
                                Text("No friends yet. Add some!")
                                    .font(.custom("Sarabun-Light", size: 18))
                                    .foregroundColor(.black.opacity(0.6))
                                    .padding(.top, 2)
                            } else {
                                VStack(spacing: 12) {
                                    ForEach(friends) { friend in
                                        friendCard(friend: friend)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 15)
                            }
                            
                            Text("Achievements")
                                .font(.custom("Moulpali-Regular", size: 48))
                                .padding(.top, 10)
                            
                            VStack {
                                LazyVGrid(columns: gridCols, spacing: 30) {
                                    ForEach(0..<6, id: \.self) { i in
                                        achievementCard {
                                            Image(systemName: "trophy.fill")
                                                .font(.system(size: 45))
                                                .foregroundColor(.black.opacity(0.5))
                                        }
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                            .padding(.top, 5)
                            
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                }
                
                BottomNavBar(selection: $router.tab) { _ in }
                    .frame(height: barHeight)
                    .background(Color(hex: "EBE3D7"))
                    .ignoresSafeArea(edges: .bottom)
                    .offset(y: 34)
            }
        }
        .sheet(isPresented: $showingAddFriend) {
            addFriendSheet
        }
    }
    
    @ViewBuilder
    private func friendCard(friend: Friend) -> some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(Color(hex: "C9BEAE"))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(friend.name)
                    .font(.custom("Sarabun-Bold", size: 18))
                
                Text("@\(friend.username)")
                    .font(.custom("Sarabun-Regular", size: 14))
                    .foregroundColor(.black.opacity(0.6))
            }
            
            Spacer()
            
            Button(action: {
                removeFriend(friend)
            }) {
                Image(systemName: "trash")
                    .font(.system(size: 20))
                    .foregroundColor(.red.opacity(0.7))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(hex: "F2EDE7"))
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
        )
    }
    
    private var addFriendSheet: some View {
        NavigationView {
            ZStack {
                Color(hex: "EBE3D7").ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Add Friend")
                        .font(.custom("Moulpali-Regular", size: 36))
                        .padding(.top, 20)
                    
                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name")
                                .font(.custom("Sarabun-Bold", size: 18))
                            
                            TextField("Enter name", text: $newFriendName)
                                .font(.custom("Sarabun-Regular", size: 16))
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Username")
                                .font(.custom("Sarabun-Bold", size: 18))
                            
                            TextField("Enter username", text: $newFriendUsername)
                                .font(.custom("Sarabun-Regular", size: 16))
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                )
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Button(action: addFriend) {
                        Text("Add Friend")
                            .font(.custom("Sarabun-Bold", size: 20))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(hex: "C9BEAE"))
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            )
                    }
                    .disabled(newFriendName.isEmpty || newFriendUsername.isEmpty)
                    .opacity(newFriendName.isEmpty || newFriendUsername.isEmpty ? 0.5 : 1)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    Spacer()
                }
            }
            .navigationBarItems(trailing: Button("Cancel") {
                showingAddFriend = false
                newFriendName = ""
                newFriendUsername = ""
            })
        }
    }
    
    private func addFriend() {
        let friend = Friend(name: newFriendName, username: newFriendUsername)
        friends.append(friend)
        
        newFriendName = ""
        newFriendUsername = ""
        showingAddFriend = false
    }
    
    private func removeFriend(_ friend: Friend) {
        friends.removeAll { $0.id == friend.id }
    }
    
    @ViewBuilder
    private func achievementCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(hex: "F2EDE7"))
            .frame(width: 90, height: 90)
            .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 3)
            .overlay(content())
    }
}

#Preview {
    ProfileView().environmentObject(TabRouter())
}
