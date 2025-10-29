//
//  HomeView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI
import Combine
import FamilyControls
//import ManagedSettings
//import DeviceActivity

struct HomeView: View {
    @State private var showingBlocking = false
    @State private var isPickerPresented = false
    @StateObject private var screenTimeManager = ScreenTimeManager.shared
    @State private var isSessionRunning = false
    @State private var elapsedSeconds = 0
    private let ticker = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
    private var hours: Int   { elapsedSeconds / 3600 }
    private var minutes: Int { (elapsedSeconds % 3600) / 60 }
    
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            Image("graycat")
                .resizable()
                .scaledToFit()
                .frame(width: 318, height: 318)
                .offset(y: -160)
            
            Text("\(hours)h \(minutes)m")
                .font(.custom("Moulpali-Regular", size: 65))
                .foregroundColor(.black)
                .offset(y: 25)
            
            Text("hours saved")
                .font(.custom("Sarabun-Thin", size: 30))
                .foregroundColor(.black)
                .offset(y: 70)
            
            // Timer Setup UI
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "F2EDE7"))
                .frame(width: 380, height: 225)
                .overlay(
                    VStack (spacing: 12){
                        Text("set timer")
                            .font(.custom("Sarabun-Regular", size: 20))
                        
                        HStack (spacing: 48){
                            // Hours
                            HStack (spacing: 15){
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 80, height: 87)
                                    .overlay(
                                        Text("\(hours)")
                                            .font(.custom("VictorMono-Regular", size: 40))
                                            .foregroundColor(.black)
                                    )
                                
                                Text("hr")
                                    .font(.custom("VictorMono-Regular", size: 40))
                                    .foregroundColor(.black)
                            }
                            
                            // Minutes
                            HStack (spacing: 15){
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 80, height: 87)
                                    .overlay(
                                        Text("\(minutes)")
                                            .font(.custom("VictorMono-Regular", size: 40))
                                            .foregroundColor(.black)
                                    )
                                
                                Text("min")
                                    .font(.custom("VictorMono-Regular", size: 40))
                                    .foregroundColor(.black)
                            }
                        }

                        
                        Button(action: {
                            elapsedSeconds = 0
                            isSessionRunning = true
                        }) {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(hex: "646E61"))
                                .frame(width: 235, height: 45)
                                .overlay(
                                    Text("begin session")
                                        .font(.custom("Sarabun-Regular", size: 20))
                                        .foregroundColor(.white)
                                )
                        }
                        .offset(y: 10)
                    }
                    .offset(y: -10)
                )
                .offset(y: 225)
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)


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
        }
    }
}
#Preview { HomeView() }
