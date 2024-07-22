//
//  SlideDownPopup.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/18/24.
//

import SwiftUI

struct SlideDownPopup: View {
    @Binding var showPopup: Bool
    @Binding var goEmergencyCall: Bool
    @Binding var emergeColor: Color
    
    
    var body: some View {
        VStack {
            if showPopup {
                VStack {
                 
                    Text("This will call 911")
                        .font(.system(size: 30, weight: .semibold))
                        .font(.subheadline)
                        .padding(.bottom, 20)
                        .padding(.top, 50)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            goEmergencyCall = true
                            showPopup = false
                            print("Calling 911")
                        }) {
                            Text("Call 911")
                                .font(.system(size: 20, weight: .semibold))
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        Spacer()
                        Button(action: {
                            showPopup = false
                            emergeColor = Color("gray")
                        }) {
                            Text("Cancel")
                                .font(.system(size: 20, weight: .semibold))
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(Color("bg"))
                .cornerRadius(10)
                .shadow(radius: 10)
                .frame(maxWidth: .infinity)
                .transition(.move(edge: .top))
                .animation(.spring(), value: showPopup)
            }
        }
        .background(Color.black.opacity(0.3))
        .edgesIgnoringSafeArea(.all)
        .padding(.top, showPopup ? 0 : UIScreen.main.bounds.height) // Position the popup
        
    }
}

/*#Preview {
    SlideDownPopup()
}
*/
