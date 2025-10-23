//
//  HomeView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct HomeView: View {

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
                print("Start session tapped")
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
                        .font(.custom("Moulpali-Regular", size: 30))
                    Spacer()
                }
                .padding(.leading, 15)
                
                Spacer()
            }
        }
    }
}


#Preview {
    HomeView()
}
