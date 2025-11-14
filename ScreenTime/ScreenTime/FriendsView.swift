//
//  FriendsView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 11/14/25.
//

import SwiftUI

struct Friend: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let handle: String
}

struct FriendsView: View {
    @EnvironmentObject private var router: TabRouter
    @Environment(\.dismiss) private var dismiss
    @AppStorage("coins") private var coins: Int = 0
    @State private var showingAddFriends = false
    @State private var friends: [Friend] = (0..<10).map { _ in Friend(name: "User", handle: "@User") }
    private let barHeight: CGFloat = 78
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color(hex: "EBE3D7").ignoresSafeArea()
                
                ScrollView(.vertical) {
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
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image("rightarrow")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48, height: 48)
                                }
                            }
                        )
                        .offset(y: -43)
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(spacing: 25) {
                                ForEach(friends) { friend in
                                    FriendRowView(
                                        name: friend.name,
                                        handle: friend.handle,
                                        onRemove: {
                                            friends.removeAll { $0.id == friend.id }
                                        }
                                    )
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 375)
                        .offset(y: -135)
                        
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
                }
                
                BottomNavBar(selection: $router.tab) { _ in }
                    .frame(height: barHeight)
                    .background(Color(hex: "EBE3D7"))
                    .ignoresSafeArea(edges: .bottom)
                    .offset(y: 34)
                
                if showingAddFriends {
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                    AddFriendsPopup(isPresented: $showingAddFriends)
                }
            }
        }
    }
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

struct FriendRequestRow: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(hex: "F2EDE7"))
            .frame(width: 340, height: 80)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            .overlay(
                HStack {
                    Image("user")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    Image("addfriend")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .padding(.trailing, 18)
                }
            )
    }
}

struct AddFriendsPopup: View {
    @Binding var isPresented: Bool
    @State private var searchText: String = ""
    @State private var isAdded = false

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
                                    .frame(width: 28, height: 28)
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .offset(x: -48, y: -315)
                
                VStack {
                    Text("Add Friends")
                        .font(.custom("Moulpali-Regular", size: 35))
                        .foregroundColor(.black)
                        .offset(y: 85)
                    
                    TextField("Username, phone number, or email", text: $searchText)
                        .padding(.horizontal, 16)
                        .frame(width: 280, height: 40)
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
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "F2EDE7"))
                        .frame(width: 300, height: 70)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        .overlay(
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 46, height: 46)
                                    .foregroundColor(Color(hex: "FFFFFF"))
                                    .padding(.leading, 16)
                                
                                VStack (alignment: .leading){
                                    Text("User")
                                        .font(.custom("Moulpali-Regular", size: 26))
                                        .foregroundColor(.black)
                                    
                                    Text("@User")
                                        .font(.custom("Sarabun-Light", size: 15))
                                        .foregroundColor(.black)
                                        .offset(y: -12)
                                }
                                .offset(y: -2)
                                Spacer()
                                
                                Button {
                                    isAdded.toggle()
                                } label: {
                                    Image(isAdded ? "addedfriend" : "addfriend")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        .padding(.trailing, 17.5)
                                }
                            }
                        )
                        .padding(.top, -245)
                }
            }
        }
    }
}

#Preview {
    FriendsView()
        .environmentObject(TabRouter())
}
