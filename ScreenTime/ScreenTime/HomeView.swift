//
//  HomeView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showingBlocking = false
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            Image("graycat")
                .resizable()
                .scaledToFit()
                .frame(width: 318, height: 318)
                .offset(y: -160)
            
            Text("0h 0m")
                .font(.custom("Moulpali-Regular", size: 65))
                .foregroundColor(.black)
                .offset(y: 25)
            Text("hours saved")
                .font(.custom("Sarabun-Thin", size: 30))
                .foregroundColor(.black)
                .offset(y: 70)
            Button(action: {
                showingBlocking = true
            }) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(hex: "646E61"))
                    .frame(width: 235, height: 49)
                    .overlay(
                        Text("start session")
                            .font(.custom("Sarabun-Regular", size: 20))
                            .foregroundColor(.white)
                    )
            }
            .offset(y: 125)
            VStack {
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 49)
                    Text("pawse")
                        .font(.custom("VictorMono-Regular", size: 30))
                    Spacer()
                }
                .padding(.leading, 15)
                
                Spacer()
            }
            if showingBlocking {
                ZStack {
                    Color(hex: "EBE3D7")
                        .ignoresSafeArea()
                        .contentShape(Rectangle())
                        .onTapGesture { showingBlocking = false }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image("logo").resizable().scaledToFit().frame(height: 49)
                            Text("pawse").font(.custom("VictorMono-Regular", size: 30))
                            Spacer()
                        }
                        .padding(.leading, 15)
                        
                        // Card content
                        BlockingSetupContent {
                            // start blocking
                            showingBlocking = false
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
    }
}

private struct BlockingSetupContent: View {
    var onBegin: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: "F2EDE7"))
            .frame(width: 380, height: 244)
            .overlay(
                VStack() {
                    HStack() {
                        TimeCard(title: "from", timeText: "12:00am")
                        TimeCard(title: "to",   timeText: "6:07am")
                    }
                    
                    // Duration
                    Text("6h 7m of blocking")
                        .font(.custom("Sarabun-Light", size: 20))
                        .padding(.top, 2)
                    
                    Button(action: onBegin) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(hex: "646E61"))
                            .frame(width: 235, height: 49)
                            .overlay(
                                Text("begin blocking")
                                    .font(.custom("Sarabun-Regular", size: 20))
                                    .foregroundColor(.white)
                            )
                    }
                }
            )
            .onTapGesture { /* keep taps inside from dismissing */ }
    }
}


private struct TimeCard: View {
    let title: String
    let timeText: String
    
    var body: some View {
        VStack() {
            Text(title)
                .font(.custom("Sarabun-Regular", size: 20))

            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "F5F5F5"))
                .frame(width: 160, height: 86)
                .overlay(
                    Text(timeText)
                        .font(.custom("VictorMono-Regular", size: 40))
                        .foregroundColor(.black)
                )
        }
    }
}

#Preview { HomeView() }
