//
//  HomeView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI
import Combine

struct HomeView: View {
    @AppStorage("coins") private var coins: Int = 0
    @State private var elapsedSeconds = 0
    private var hours: Int   { elapsedSeconds / 3600 }
    private var minutes: Int { (elapsedSeconds % 3600) / 60 }

    @State private var hourText: String = "0"
    @State private var minuteText: String = "0"
    @State private var clearedHourOnce = false
    @State private var clearedMinuteOnce = false

    enum Field { case hours, minutes }
    @FocusState private var focusedField: Field?

    private var selectedHours: Int { Int(hourText) ?? 0 }
    private var selectedMinutes: Int { Int(minuteText) ?? 0 }
    private var canStartSession: Bool { (selectedHours > 0 || selectedMinutes > 0) }

    @State private var showSession = false
    @State private var sessionLengthSeconds = 0

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

            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "F2EDE7"))
                .frame(width: 380, height: 225)
                .overlay(
                    VStack (spacing: 12) {
                        Text("set timer")
                            .font(.custom("Sarabun-Regular", size: 20))
                            .foregroundColor(.black)

                        HStack (spacing: 45) {
                            HStack (spacing: 15) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 80, height: 87)
                                    .overlay(
                                        TextField("", text: $hourText)
                                            .keyboardType(.numberPad)
                                            .focused($focusedField, equals: .hours)
                                            .font(.custom("VictorMono-Regular", size: 40))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .onTapGesture {
                                                if !clearedHourOnce {
                                                    hourText = ""
                                                    clearedHourOnce = true
                                                }
                                            }
                                            .onChange(of: hourText) { _ in
                                                sanitize(&hourText, maxDigits: 2)
                                            }
                                            .onSubmit {
                                                clampHours()
                                            }
                                    )

                                Text("hr")
                                    .font(.custom("VictorMono-Regular", size: 40))
                                    .foregroundColor(.black)
                            }

                            HStack (spacing: 15) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 80, height: 87)
                                    .overlay(
                                        TextField("", text: $minuteText)
                                            .keyboardType(.numberPad)
                                            .focused($focusedField, equals: .minutes)
                                            .font(.custom("VictorMono-Regular", size: 40))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .onTapGesture {
                                                if !clearedMinuteOnce {
                                                    minuteText = ""
                                                    clearedMinuteOnce = true
                                                }
                                            }
                                            .onChange(of: minuteText) { _ in
                                                sanitize(&minuteText, maxDigits: 2)
                                            }
                                            .onSubmit {
                                                clampMinutes()
                                            }
                                    )

                                Text("min")
                                    .font(.custom("VictorMono-Regular", size: 40))
                                    .foregroundColor(.black)
                            }
                        }
                        .onChange(of: focusedField) { newFocus in
                            if newFocus != .hours { clampHours() }
                            if newFocus != .minutes { clampMinutes() }
                        }

                        Button(action: {
                            clampHours()
                            clampMinutes()
                            focusedField = nil
                            let total = (selectedHours * 3600) + (selectedMinutes * 60)
                            sessionLengthSeconds = total
                            showSession = true
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
                        .disabled(!canStartSession)
                        .opacity(canStartSession ? 1.0 : 0.5)
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
                                .offset(x: -8, y: 0)
                        }
                        
                    }
                    .offset(x: -15, y: 0)
                }
                .padding(.leading, 15)

                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showSession) {
            SessionView(totalSeconds: sessionLengthSeconds) { didComplete, secondsEarned in
                showSession = false
                if didComplete {
                    elapsedSeconds += secondsEarned
                }
            }
        }

    }

    private func sanitize(_ text: inout String, maxDigits: Int) {
        text = text.filter { $0.isNumber }
        if text.count > maxDigits {
            text = String(text.prefix(maxDigits))
        }
    }

    private func clampHours() {
        if hourText.isEmpty { hourText = "0" }
        var v = Int(hourText) ?? 0
        if v < 0 { v = 0 }
        if v > 24 { v = 24 }
        hourText = String(v)
    }

    private func clampMinutes() {
        if minuteText.isEmpty { minuteText = "0" }
        var v = Int(minuteText) ?? 0
        if v < 0 { v = 0 }
        if v > 59 { v = 59 }
        minuteText = String(v)
    }
}

struct SessionView: View {
    @Environment(\.scenePhase) private var scenePhase
    let totalSeconds: Int
    var onEnd: (_ didComplete: Bool, _ secondsEarned: Int) -> Void

    @Environment(\.dismiss) private var dismiss
    @AppStorage("coins") private var coins: Int = 0
    @State private var endDate: Date = .now
    @State private var now: Date = .now
    @State private var lastAwardedMinute = 0
    @State private var sessionCoins: Int = 0
    @State private var showConfirmEnd = false
    @State private var endedBecauseLeftApp = false


    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var remaining: Int {
        max(Int(endDate.timeIntervalSince(now)), 0)
    }
    
    private var elapsed: Int {
        max(totalSeconds - remaining, 0)
    }
    
    private var endTimeString: String {
        let df = DateFormatter()
        df.locale = .current
        df.timeZone = .current
        df.dateFormat = "h:mma"
        return df.string(from: endDate).lowercased()
    }
    private var hmsString: String {
        let h = remaining / 3600
        let m = (remaining % 3600) / 60
        let s = remaining % 60
        return String(format: "%02dh %02dm %02ds", h, m, s)
    }


    var body: some View {
        ZStack {
            Color(hex: "CFC7BC").ignoresSafeArea()

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
                }
                .padding(.leading, 15)
                Spacer()
                
                ZStack(alignment: .topTrailing) {
                    Image("graycat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Image("collecting")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .offset(x: 70, y: -170)
                    Text("\(sessionCoins)")
                        .font(.custom("Moulpali-Regular", size: 40))
                        .frame(width: 60)
                        .offset(x: 20, y: -75)
                        .animation(.easeOut(duration: 0.3), value: coins)
                }
                .offset(y: -40)
                
                Group {
                    (
                        Text("blocking until ")
                            .font(.custom("Sarabun-Thin", size: 30))
                            .foregroundColor(.black)
                      +
                        Text(endTimeString)
                            .font(.custom("Sarabun-Regular", size: 30))
                    )
                    .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 5)

                    Text(hmsString)
                        .font(.custom("Moulpali-Regular", size: 65))
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        .offset(y: -30)

                    Text("current session")
                        .font(.custom("Sarabun-Thin", size: 30))
                        .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 5)
                        .offset(y: -75)

                    Button {
                        if sessionCoins > 0 && remaining > 0 {
                            showConfirmEnd = true
                        } else {
                            endNow()
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(hex: "B14B39"))
                            .frame(width: 235, height: 49)
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            .overlay(
                                Text("end session")
                                    .font(.custom("Sarabun-Regular", size: 20))
                                    .foregroundColor(.white)
                            )
                    }
                    .offset(y: -85)
                }
                .offset(y: -70)
                .alert("End your session early?", isPresented: $showConfirmEnd) {
                    Button("End now", role: .destructive) {
                        endNow()
                    }
                    Button("Keep going", role: .cancel) {}
                } message: {
                    Text("You will lose your coins and current progress if you end early. Are you sure?")
                }

                Text("if you end session now, you will lose all\negg hatching progress and rewards")
                    .multilineTextAlignment(.center)
                    .font(.custom("Sarabun-Thin", size: 15))
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    .offset(y: -150)
            }
        }
        .onAppear {
            endDate = Date().addingTimeInterval(TimeInterval(max(totalSeconds, 0)))
            now = Date()
            lastAwardedMinute = 0
            sessionCoins = 0
        }
        .onReceive(timer) { date in
            now = date
            let minutesSoFar = elapsed / 60
            if minutesSoFar > lastAwardedMinute {
                let delta = minutesSoFar - lastAwardedMinute
                sessionCoins += delta
                lastAwardedMinute = minutesSoFar
            }
            if remaining == 0 {
                coins += sessionCoins
                completeSession()
            }
        }
        
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                endNow()
                endedBecauseLeftApp = true
            }
        }
        .alert("Session ended", isPresented: $endedBecauseLeftApp) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("You left the app, so the session ended early.")
        }
    }

    private func endNow() {
        onEnd(false, 0)
        dismiss()
    }

    private func completeSession() {
        onEnd(true, totalSeconds)
        dismiss()
    }
}

#Preview {
    HomeView()
}
