//
//  Hands.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/18/24.
//

import SwiftUI

struct Hands: View {
    
    @Binding var currentIndex: Int
    @Binding var opacity: Double
    let size = CGFloat(20)
    
    let opacities: [Double] = [1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
    @State private var opacity0 = 0.0
    @State private var opacity1 = 0.0
    @State private var opacity2 = 0.0
    @State private var opacity3 = 0.0
    @State private var timer: Timer? = nil
    @State private var opacityIndex = 0
    
    func startTimer(for index: Int) {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { _ in
            opacityIndex = (opacityIndex + 1) % opacities.count
            switch index {
            case 0:
                opacity0 = opacities[opacityIndex]
            case 1:
                opacity1 = opacities[opacityIndex]
            case 2:
                opacity2 = opacities[opacityIndex]
            case 3:
                opacity3 = opacities[opacityIndex]
            case 4:
                opacity0 = opacities[opacityIndex]
            default:
                break
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        opacity0 = 1.0
        opacity1 = 1.0
        opacity2 = 1.0
        opacity3 = 1.0
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .background(Color("bg"))
                    .opacity(opacity)
             
           HStack {
                Spacer()
                ZStack {
                    Image("hand")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Button(action: {
                        currentIndex = 3
                        startTimer(for: 3)
                    }) {
                        Image("Ring")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: size)
                            .opacity(currentIndex == 3 ? opacity3 : 1.0)
                    }.offset(x: -10, y: -20)
                    
                }.frame(height: 270)
                 .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                
                ZStack {
                    Image("hand")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Button(action: {
                        currentIndex = 0
                        startTimer(for: 0)
                    }) {
                        Image("Ring")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: size)
                            .opacity(currentIndex == 0 ? opacity0 : 1.0)
                    }.offset(x: -10, y: -20)
                    
                    Button(action: {
                        currentIndex = 1
                        startTimer(for: 1)
                    }) {
                        Image("Ring")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: size)
                            .opacity(currentIndex == 1 ? opacity1 : 1.0)
                    }.offset(x: 0, y: 65)
                    
                    Button(action: {
                        currentIndex = 2
                        startTimer(for: 2)
                    }) {
                        Image("Ring")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: size)
                            .opacity(currentIndex == 2 ? opacity2 : 1.0)
                    }.offset(x: 30, y: 60)
                    
                }
                
                Spacer()
            }
        
        }.frame(width: 350, height: 270)
       
        
    
       
    }
}

#Preview {
    @State var value: Int = -1
    @State var opacity: Double = 0.5
  
    return Hands(currentIndex: $value, opacity: $opacity)
}
