//
//  ScanView.swift
//  sussy
//
//  Created by Aadit Noronha on 7/22/24.
//

import SwiftUI


@available(iOS 18.0, *)
struct PeopleView: View {
    
    @EnvironmentObject var user: UserStore
    
    @State var showScan: Bool = false
    @State var showStart: Bool = false
    
    @State var index: Int = -1
    
    var body: some View {
        
        if (showScan) {
            HomeView()
        } else if (index != -1) {
            PeopleSettingsView(log: user.people[index], goTabAfter: false)
        } else {
            VStack {
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    showScan = true
                                }){
                                    Image("back")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(Color.blue)
                                        .scaledToFit()
                                        .frame(maxHeight: 30)
                                        .padding(.leading, 10)
                                    
                                    
                                    Text("Home")
                                        .font(.system(size: 17, weight: .semibold))
                                        .offset(x: -10)
                                        .foregroundStyle(.blue)
                                    
                                }
                                Spacer()
                            }
                            Text("People")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(Color("fg"))
                                .padding(.top, 10)
                           
                        }.padding(.top, 30)
                        
                        
                        
                    }.frame(height: 130)
                        .background(Color("headerSecondary"))
                      
                  
                   
                    
                }
               
                HStack {
                    Text("Friends & Loved Ones")
                        .padding(.leading, 20)
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.top, 5)
                    
                    Spacer()
                }
                
              
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("white"))
                        .frame(width: 350, height: 550)
                        .overlay(
                            VStack {
                                HStack {
                                    Image(systemName: "person.fill")
                                        
                                    Text("People")
                                        .font(.system(size: 15, weight: .medium))
                                        .padding(.leading, 10)
                                    Spacer()
                                }.padding(.leading, 10)
                                    .foregroundStyle(Color("primary"))
                                Text("Click on a person to adjust their feedback type and face settings.")
                                    .font(.system(size: 17, weight: .semibold))
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 5)
                                   
                                ScrollView {
                                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                                        ForEach(Array(user.people.enumerated()), id: \.element.id) { index, log in
                                            ZStack {
                                                Button(action: {
                                                    self.index = index
                                                }) {
                                                    log.circleImg(size: 80, x: log.isFavorite)
                                                }
                                            }
                                        }

                                        
                                    }
                                    .padding()
                                }
                            }.padding(20)
                        )
                    
                   
                }
                
                

                Spacer()
            }
            
            .foregroundColor(Color("fg"))
            .background(Color("bg"))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}


#Preview {
    if #available(iOS 18.0, *) {
        PeopleView()
            .environmentObject(UserStore.example())
    } else {
        // Fallback on earlier versions
    }
}
