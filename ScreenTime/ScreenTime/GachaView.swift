//
//  GachaView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct GachaView: View {

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(hex: "EBE3D7").ignoresSafeArea()

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
            }
        }
    }
}


#Preview {
    GachaView()
}
