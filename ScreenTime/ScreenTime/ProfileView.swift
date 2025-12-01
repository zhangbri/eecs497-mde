//
//  ProfileView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject private var router: TabRouter
    private let gridCols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @AppStorage("coins") private var coins: Int = 0
    private let barHeight: CGFloat = 78

    @AppStorage("profile_name") private var name: String = ""
    @AppStorage("profile_username") private var username: String = ""
    @AppStorage("profile_pronouns") private var pronouns: String = ""
    @AppStorage("profile_image_data") private var profileImageData: Data = Data()
    @State private var profileImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var totalCompletedSessions: Int = 0
    @State private var Averagesessiontime: Int = 0
    @State private var Longestsession: Int = 0
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color(hex: "EBE3D7").ignoresSafeArea()
                ScrollViewReader { scrollProxy in
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
                                Group {
                                    if let profileImage {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 205, height: 205)
                                            .clipShape(Circle())
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 205, height: 205)
                                            .foregroundColor(Color(hex: "FFFFFF"))
                                    }
                                }
                                .padding(.top, -170)
                                
                                PhotosPicker(selection: $selectedItem, matching: .images) {
                                    Text("edit profile picture")
                                        .font(.custom("Sarabun-Light", size: 16))
                                        .foregroundColor(.black)
                                        .padding(.top, 4)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                }
                                .buttonStyle(.plain)
                                
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
                                            .textInputAutocapitalization(.never)
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
                                .padding(.top,7.5)
                                Text("Achievement")
                                    .font(.custom("Moulpali-Regular", size: 48))
                                    .offset(y: -65)
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
                                .offset(y: -155)
                                
                                Text("Statistics")
                                    .font(.custom("Moulpali-Regular", size: 48))
                                    .offset(y: -215)
                                VStack() {
                                    Rectangle()
                                        .fill(Color(hex: "C9BEAE"))
                                        .frame(height: 1.5)
                                    HStack {
                                        Text("Total completed sessions").font(.custom("Sarabun-Bold", size: 20))
                                            .padding(.leading, -65)
                                        
                                        Text("\(totalCompletedSessions) sessions")
                                            .font(.custom("Sarabun-Regular", size: 20))
                                            .offset(x: 40)
                                        
                                    }
                                    .frame(height: 30)
                                    
                                    
                                    Rectangle()
                                        .fill(Color(hex: "C9BEAE"))
                                        .frame(height: 1.5)
                                    HStack {
                                        Text("Average session time").font(.custom("Sarabun-Bold", size: 20))
                                            .padding(.leading, -102.5)
                                        Text("\(Averagesessiontime) minutes")
                                            .font(.custom("Sarabun-Regular", size: 20))
                                            .offset(x: 77)
                                        
                                    }
                                    .frame(height: 30)
                                    
                                    Rectangle()
                                        .fill(Color(hex: "C9BEAE"))
                                        .frame(height: 1.5)
                                    HStack {
                                        Text("Longest Session").font(.custom("Sarabun-Bold", size: 20))
                                            .padding(.leading, -148)
                                        Text("\(Longestsession) sessions")
                                            .font(.custom("Sarabun-Regular", size: 20))
                                            .offset(x: 121)
                                    }
                                    .frame(height: 30)
                                    Rectangle()
                                        .fill(Color(hex: "C9BEAE"))
                                        .frame(height: 1.5)
                                }
                                .offset(y: -315)
                                
                                Color.clear
                                    .frame(height: 1)
                                    .id("profileBottom")
                            }
                        }
                        .frame(
                                maxWidth: .infinity,
                                minHeight: proxy.size.height,
                                alignment: .top
                            )
                            .padding(.bottom, -240)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: .scrollToBottomProfile)) { _ in
                            DispatchQueue.main.async {
                                withAnimation {
                                    scrollProxy.scrollTo("profileBottom", anchor: .bottom)
                                }
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
        .onAppear {
            if !profileImageData.isEmpty {
                profileImage = UIImage(data: profileImageData)
            }
        }

        .onChange(of: selectedItem) { newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        profileImageData = data
                        profileImage = uiImage
                    }
                }
            }
        }
    }
}
@ViewBuilder
private func achievementCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    RoundedRectangle(cornerRadius: 20)
        .fill(Color(hex: "F2EDE7"))
        .frame(width: 110, height: 110)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
        .overlay(content())
}

#Preview {
    ProfileView().environmentObject(TabRouter())
}
