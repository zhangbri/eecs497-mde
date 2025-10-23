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
    private var seconds: Int { elapsedSeconds % 60 }
    
    var body: some View {
        ZStack {
            Color(hex: "EBE3D7").ignoresSafeArea()
            Image("graycat")
                .resizable()
                .scaledToFit()
                .frame(width: 318, height: 318)
                .offset(y: -160)
            
            Text("\(hours)h \(minutes)m \(seconds)s")
                .font(.custom("Moulpali-Regular", size: 65))
                .foregroundColor(.black)
                .offset(y: 25)
            
            Text("hours saved")
                .font(.custom("Sarabun-Thin", size: 30))
                .foregroundColor(.black)
                .offset(y: 70)
            
            Button(action: {
                isPickerPresented = true
            }) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(hex: "646E61"))
                    .frame(width: 235, height: 49)
                    .overlay(
                        Text("choose apps to block")
                            .font(.custom("Sarabun-Regular", size: 18))
                            .foregroundColor(.white)
                    )
            }
            .familyActivityPicker(
                isPresented: $isPickerPresented,
                selection: $screenTimeManager.selection
            )
            .offset(y: 200)
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
            Button(action: toggleTimerSession) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(hex: "646E61"))
                    .frame(width: 235, height: 49)
                    .overlay(
                        Text(isSessionRunning ? "stop session" : "start session")
                            .font(.custom("Sarabun-Regular", size: 20))
                            .foregroundColor(.white)
                    )
            }
            .offset(y: 260)

            .opacity(isSessionRunning ? 0.7 : 1)
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
                        
                        BlockingSetupContent(onBegin: {
                            showingBlocking = false
                        })
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
        //.onAppear {
            //screenTimeManager.requestAuthorization()
        //}
        .onReceive(ticker) { _ in
            if isSessionRunning { elapsedSeconds += 1 }
        }

    }
    private func toggleTimerSession() {
        if isSessionRunning {
            // Stop timer
            isSessionRunning = false
        } else {
            // Start or restart timer
            elapsedSeconds = 0
            isSessionRunning = true
        }
    }
}

private struct BlockingSetupContent: View {
    var onBegin: () -> Void
    //@ObservedObject var screenTimeManager: ScreenTimeManager
    
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
                    
                    Button(action: {
                        //screenTimeManager.startBlocking()
                        onBegin()
                    }) {
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
