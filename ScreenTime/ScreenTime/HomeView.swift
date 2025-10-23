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
