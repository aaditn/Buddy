//
//  Hands.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/18/24.
//

import SwiftUI

struct FacePopup: View {
    
    
    @EnvironmentObject var user: UserStore
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
    
    public func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let dateString = formatter.string(from: date)
        return dateString
        
    }
    
    var body: some View {
        ZStack {
           let person = user.encounters.last!.person
           RoundedRectangle(cornerRadius: 20)
                .fill(Color("white"))
                .frame(width: 350, height: 230)
           
                 
            VStack {
                
                ZStack {
                    person.img
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 10)
                    VStack {
                        HStack {
                            Text("Face Scan")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color("primary"))
                                .padding(.leading, 30)
                            
                            Spacer()
                            
                            Text(formatDate(date: Date.now))
                                .padding(.trailing, 50)
                            
                            
                        }.padding(.top, 20)
                        Spacer()
                    }
                  
                       
                }
                   
                Spacer()
                 
                HStack {
                    Text(person.fName)
                    if (Date.now.timeIntervalSinceNow < 86400) {
                        Text("| Seen Today")
                    } else {
                        Text("| Seen This Week")
                    }
                }.padding(.bottom, 10)
                
               
                
            }
         
        
        } .frame(width: 350, height: 230)
            
            
        
       
        
    
       
        
    }
    
       

}

#Preview {
    
    FacePopup()
        .environmentObject(UserStore.example())
}

