//
//  SettingsView.swift
//  sussy
//
//  Created by Aadit Noronha on 7/24/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct SettingsView: View {
    
    @EnvironmentObject var user: UserStore
    
    @State var back: Bool = false
    @State var searchText: String = ""
    @State var mode: Int = -1
    
    var body: some View {
        
        if (mode == 0) {
            BluetoothView(isIntro: false, mode: $mode)
        } else if (back) {
            HomeView()
        
            
      /*  } else if (mode == 2) {
            
        } else if (mode == 3) {
            
        } else if (mode == 4) {*/
            
        } else  {
            VStack {
                VStack {
                    ZStack {
                        VStack {
                            ZStack {
                                HStack {
                                    Button(action: {
                                        back = true
                                    }){
                                        Image("back")
                                            .renderingMode(.template)
                                            .resizable()
                                            .foregroundStyle(Color.blue)
                                            .scaledToFit()
                                            .frame(maxHeight: 30)
                                            .padding(.leading, 10)
                                        
                                        
                                        Text("Settings")
                                            .font(.system(size: 17, weight: .semibold))
                                            .offset(x: -10)
                                            .foregroundStyle(.blue)
                                        
                                    }
                                    Spacer()
                                }
                                Text("Settings")
                                    .font(.system(size: 20, weight: .medium))
                                    .padding(.top, 10)
                                    .foregroundStyle(Color("bg"))
                                
                            }.padding(.top, 45)
                            
                            
                            
                        }.frame(height: 130)
                            .background(Color("headerSecondary"))
                        
                        
                        
                        
                    }
                    HStack {
                        Text("Account Preferences")
                            .font(.system(size: 25, weight: .semibold))
                            .padding(.leading, 20)
                            .padding(.top, 1)
                        Spacer()
                    }
                    
                   
                    SearchBar(searchText: $searchText)
                
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("white"))
                        
                        VStack {
                            HStack {
                                GetProfile(size: 90)
                                    .padding(.leading, 50)
                               
                                Text("\(user.name)")
                                    .font(.system(size: 20, weight: .medium))
                                    .padding(.leading, 20)
                                    .offset(y: -10)
                                Spacer()
                            }
                            .padding(.top, 20)
                            Text("Customize your experience according \n to your needs.")
                                .font(.system(size: 14, weight: .medium))
                                .frame(width: 300)
                            
                                .multilineTextAlignment(.leading)
                                .padding(5)
                              
                            Spacer()
                        }
                       
                       
                        
                    }.frame(width: 350, height: 180)
                }
                VStack {
                    Button (action: {
                        mode = 0
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("white"))
                            HStack {
                                Image("BluetoothIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32)
                                    .padding(.leading, 20)
                               
                                
                                text(t: "Bluetooth")
                                Spacer()
                                
                            }
                            
                        }.frame(width: 350, height: 50)
                            .padding(.top, 5)
                    }
                   
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("white"))
                        VStack {
                            Button(action: {
                                mode = 1
                            }){
                                HStack {
                                    Image("Accessibility")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 38)
                                        .padding(.leading, 14)
                                    
                                    text(t: "Accessibility")
                                   
                                    Spacer()
                                    
                                }.frame(height: 50)
                            }
                            
                            Divider()
                            Button(action: {
                                mode = 2
                            }){
                                
                                HStack {
                                    Image("TextSize")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40)
                                        .padding(.leading, 11)
                                    text(t: "Font Size")
                                    Spacer()
                                }.frame(height: 50)
                            }
                            
                            
                            Divider()
                            Button(action: {
                                mode = 3
                            }){
                                
                                HStack {
                                    Image("Contrast")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32)
                                        .padding(.leading, 19)
                                    text(t: "Contrast")
                                    Spacer()
                                }.frame(height: 50)
                            }
                        }
                       
                        
                        
                    }.frame(width: 350, height: 150)
                        .padding(.vertical, 20)
                    
                    Button(action :{
                        mode = 4
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("white"))
                            HStack {
                                Image("FindMy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .padding(.leading, 15)
                                text(t: "Sync FindMy")
                                Spacer()
                            }
                            
                        }.frame(width: 350, height: 50)
                    }
                  
                }.foregroundStyle(Color("fg"))
                
                
                Spacer()
            }.background(Color("bg"))
                .edgesIgnoringSafeArea(.all)
        }
      
    }
}
struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("white"))

            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(.gray)
                    .brightness(-0.3)
                    
                TextField("Quick Search", text: $searchText)
                    .foregroundColor(Color("fg"))
            }
            .padding(.horizontal)
        }
        .frame(width: 350, height: 50)
        .padding(.bottom, 20)
        
      
    }
}

struct text: View {
    var t: String
    var body: some View {
        HStack {
           
            Text(t)
                .font(.system(size: 17, weight: .medium))
                .padding(.leading, 10)
            Spacer()
            Image("back")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                .padding(.trailing, 5)
                .opacity(0.7)
        }
       
    }
}
#Preview {
    if #available(iOS 18.0, *) {
        SettingsView()
            .environmentObject(UserStore.example())
    } else {
        // Fallback on earlier versions
    }
}
