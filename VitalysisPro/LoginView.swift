//
//  SignUpView.swift
//  FoodPod
//
//  Created by Aadit Noronha on 7/3/24.
//

import SwiftUI

struct LoginView: View {
    
   @State private var email: String = ""
   @State private var password: String = ""
   @State private var activeIndex: Int = -1
    @State private var submit: Bool = false

    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text("Welcome Back.")
                                .font(.system(size: 36, weight: .semibold))
                            
                                .padding(.top, 20)
                                .padding(.horizontal, 24)
                            Spacer()
                            
                        }
                       
                       
                    }

                }
                VStack {
                
                    TextBox(
                        text: $email,
                        placeholder: "Email",
                        activeIndex: $activeIndex,
                        currentIndex: 2,
                        fieldType: .email
                    )
                    TextBox(
                        text: $password,
                        placeholder: "Password",
                        activeIndex: $activeIndex,
                        currentIndex: 3,
                        fieldType: .password
                    )
                    // Add other views here
                    Spacer()
                    
                    Button(action: {
                        submit = true
                        print("button clicked")
                    }) {
                        Text("Log In")
                            .frame(width: 320, height: 59)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 39)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .background(Color("primary")) // If you have this
                    .cornerRadius(39)
                    .padding(40)
                    .navigationDestination(isPresented: $submit) {

                        
                        
                    }
                }.padding(.top, 20)
              
                Spacer()
            }
    
        }
       
        
        
        
    }
    
}



#Preview {
    LoginView()
}
