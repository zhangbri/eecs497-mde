//
//  GachaView.swift
//  ScreenTime
//
//  Created by Brian Zhang on 10/2/25.
//

import SwiftUI

struct GachaView: View {
    @EnvironmentObject private var router: TabRouter
    private let barHeight: CGFloat = 78
    
    @AppStorage("coins") private var coins: Int = 0

    @State private var showResult = false
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
                                                 .offset(x: -8)
                                        }
                                    }
                                    .offset(x: -15, y: 0)
                                }
                                .padding(.leading, 15)
                                Text("Shop")
                                    .font(.custom("Moulpali-Regular", size: 48))
                                    .offset(y:-80)
                                Group{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 370, height: 235)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            ZStack {
                                                Text("Accessory")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 61, y: -89)
                                                Text("Machine")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 60, y: -49)
                                                HStack {
                                                    Image("accessorymachine")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 224, height: 224)
                                                        .offset(x: -30)


                                                    VStack(alignment: .leading){
                                                        Button(action: {}) {
                                                            Text("View Items")
                                                                .font(.custom("Moulpali-Regular", size: 16))
                                                                .foregroundColor(.black)
                                                                .frame(width: 136, height: 29)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .fill(Color(hex: "B2E5AB"))
                                                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                )
                                                        }
                                                        .offset(x:-5,y:-3)

                                                        ZStack{
                                                            Button(action: { spendCoins(50) }) {
                                                                Text("1x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:74)
                                                                Text("50")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:65)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:4, y:-9)

                                                        ZStack{
                                                            Button(action: { spendCoins(500) })  {
                                                                Text("5x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:80)
                                                                Text("500")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:0, y:-62)
                                                    }
                                                    .offset(x:-45, y:80)
                                                }
                                            }
                                        )
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 370, height: 235)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            ZStack {
                                                Text("Egg")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 58, y: -89)
                                                Text("Machine")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 60, y: -49)
                                                HStack {
                                                    Image("eggmachine")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 224, height: 224)
                                                        .offset(x: -30)


                                                    VStack(alignment: .leading){
                                                        Button(action: {}) {
                                                            Text("View Items")
                                                                .font(.custom("Moulpali-Regular", size: 16))
                                                                .foregroundColor(.black)
                                                                .frame(width: 136, height: 29)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .fill(Color(hex: "B2E5AB"))
                                                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                )
                                                        }
                                                        .offset(x:-5, y: -3)

                                                        ZStack{
                                                            Button(action: { spendCoins(30) })  {
                                                                Text("1x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:79)
                                                                Text("30")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(y:-9)

                                                        ZStack{
                                                            Button(action: { spendCoins(300) })  {
                                                                Text("5x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:85)
                                                                Text("300")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:77)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:-6, y:-62)
                                                    }
                                                    .offset(x:-45, y:80)
                                                }
                                            }
                                        )
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: "F2EDE7"))
                                        .frame(width: 370, height: 235)
                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                                        .overlay(
                                            ZStack {
                                                Text("Sprite")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 58, y: -89)
                                                Text("Machine")
                                                    .font(.custom("Sarabun-Regular", size: 40))
                                                    .offset(x: 60, y: -49)
                                                HStack {
                                                    Image("spritemachine")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 224, height: 224)
                                                        .offset(x: -30)


                                                    VStack(alignment: .leading){
                                                        Button(action: {}) {
                                                            Text("View Items")
                                                                .font(.custom("Moulpali-Regular", size: 16))
                                                                .foregroundColor(.black)
                                                                .frame(width: 136, height: 29)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 8)
                                                                        .fill(Color(hex: "B2E5AB"))
                                                                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                )
                                                        }
                                                        .offset(x:-5, y: -3)

                                                        ZStack{
                                                            Button(action:{
                                                                spendCoins(60)
                                                                showResult = true
                                                            })
                                                            {
                                                                Text("1x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-5)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:80)
                                                                Text("60")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset( y:-9)

                                                        ZStack{
                                                            Button(action: { spendCoins(600) })  {
                                                                Text("5x Roll")
                                                                    .font(.custom("Moulpali-Regular", size: 16))
                                                                    .foregroundColor(.black)
                                                                    .frame(width: 82, height: 31)
                                                                    .background(
                                                                        RoundedRectangle(cornerRadius: 8)
                                                                            .fill(Color(hex: "F273E9"))
                                                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                                                    )
                                                            }
                                                            .offset(x:-11)
                                                            HStack {
                                                                Image("coin")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 47, height: 47)
                                                                    .offset(x:80)
                                                                Text("600")
                                                                    .font(.custom("Moulpali-Regular", size: 25))
                                                                    .offset(x:71)
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                        .offset(x:0, y:-62)
                                                    }
                                                    .offset(x:-45, y:80)
                                                }
                                            }
                                        )
                                }
                                .padding(.bottom, 10)
                                .offset(y:-180)
                            }
                            .padding(.bottom, -120)
                        }
                    }
                    BottomNavBar(selection: $router.tab) { _ in }
                        .frame(height: barHeight)
                        .background(Color(hex: "EBE3D7"))
                        .ignoresSafeArea(edges: .bottom)
                        .offset(y: 34)
                }
                .fullScreenCover(isPresented: $showResult) {
                    GachaResultView()
                }
            }
        }
        private func spendCoins(_ cost: Int) {
            guard coins >= cost else {
                return
            }
            coins -= cost
        }
}

struct GachaResultView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
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
                    
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 4)
                                .frame(width: 40, height: 40)
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size:25, weight: .bold))
                        }
                        .offset(y: 35)
                        .offset(x: -12.5)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                Image("orangetabby")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 318, height: 318)
                    .offset(y: -30)
                
                VStack {
                    Text("you unlocked")
                        .font(.custom("Sarabun-Regular", size: 30))
                        .foregroundColor(.black)
                        .offset(y: -45)
                    
                    Text("RARE")
                        .font(.custom("VictorMono-Regular", size: 40))
                        .foregroundColor(Color(hex: "E62222"))
                        .shadow(color: Color(hex: "E62222"), radius: 4, x: 0, y: 1)
                        .offset(y: -40)
                    
                    Text("Orange Tabby")
                        .font(.custom("Sarabun-Regular", size: 50))
                        .foregroundColor(.black)
                        .offset(y: -55)
                    }
                
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Equip Now")
                            .font(.custom("Moulpali-Regular", size: 30))
                            .foregroundColor(.black)
                            .frame(width: 245, height: 53)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "B2E5AB"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Roll again")
                            .font(.custom("Moulpali-Regular", size: 15))
                            .foregroundColor(.black)
                            .frame(width: 164, height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(hex: "F273E9"))
                                    .shadow(color: .black.opacity(0.25),
                                            radius: 4,
                                            x: 0,
                                            y: 2)
                            )
                    }
                    .offset(y: 10)
                }
                .offset(y: -55)
                
                Spacer()
            }
        }
    }
}

#Preview {
    GachaView().environmentObject(TabRouter())
}
