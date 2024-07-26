//
//  ScanView.swift
//  Buddy
//
//  Created by Aadit Noronha on 7/22/24.
//

import SwiftUI


@available(iOS 18.0, *)
struct PeopleSettingsView: View {
    
    @EnvironmentObject var user: UserStore
    
    var log: Person
    var goTabAfter: Bool
    
    @State var indexPerson: Int = 0
    
    
    @State var mode: String = "main"
    @State var toggleFavorites: Bool = false
  
    
    var body: some View {
        
        VStack {
            
            if (mode == "main") {
                mainView(log: log, mode: $mode, toggleFavorites: $toggleFavorites)
                    .onAppear {
                        if let i = user.people.firstIndex(where: { $0.fName == log.fName}) {
                            print (log.fName)
                            print(user.people[i].fName)
                            indexPerson = i
                            log.isFavorite = user.people[i].isFavorite
                           
                            print("hehehe")
                        }
                        toggleFavorites = log.isFavorite
                    }
                    .onChange(of: toggleFavorites) {
                        user.people[indexPerson].isFavorite = toggleFavorites
                        print (user.people[indexPerson].isFavorite)
                    }
                  
            } else if (mode == "haptics") {
                Haptics(log: log, mode: $mode, toggleFavorites: $toggleFavorites)
                   
            } else if (mode == "findMy") {
                
            } else if (mode == "edit") {
                Edit(log: log, mode: $mode, toggleFavorites: $toggleFavorites)
                
            } else if (mode == "scan") {
                
            } else if (mode == "home") {
                if (goTabAfter) {
                    TabsView()
                } else {
                    PeopleView()
                }
              
                    
            }
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.all)
       
    }
}

struct Haptics: View {
    
    var log: Person
    
    @Binding var mode: String
    @Binding var toggleFavorites: Bool
    @State var coverPattern: Bool = false
    
    var body: some View {
        
        VStack {
            VStack {
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    mode = "main"
                                }){
                                    Image("back")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(Color.blue)
                                        .scaledToFit()
                                        .frame(maxHeight: 30)
                                        .padding(.leading, 10)
                                    
                                    
                                    Text("Back")
                                        .font(.system(size: 17, weight: .semibold))
                                        .offset(x: -10)
                                        .foregroundStyle(.blue)
                                    
                                }
                                Spacer()
                            }
                            Text("People")
                                .font(.system(size: 20, weight: .medium))
                                .padding(.top, 1)
                            
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
                        .frame(width: 350, height: 180)
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
                                
                                Spacer()
                                HStack {
                                    log.circleImg(size: 110, x: toggleFavorites)
                                        .padding(.leading, 30)
                                    
                                    Spacer()
                                    VStack {
                                        Text("\(log.fName) \(log.lName)")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundStyle(Color.black)
                                            .offset(y: -5)
                                        Text("''\(log.fName)''")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundStyle(Color.gray)
                                        
                                        
                                        Button(action: {
                                            mode = "edit"
                                        }){
                                            Text("Edit")
                                                .font(.system(size: 15, weight: .medium))
                                                .foregroundStyle(.blue)
                                                .offset(y: 5)
                                        }
                                        
                                        
                                    }
                                }.padding(.bottom, 20)
                                    .padding(.trailing, 20)
                                
                                
                            }.padding(20)
                        )
                    
                    
                }.padding(.bottom, 20)
                
            }.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Haptics")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 1)
                
                Text("Set a vibration pattern to identify this individual.")
                    .font(.system(size: 15, weight: .medium))
                    .padding(.bottom, 10)
                Text("Standard")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.gray.opacity(0.9))
            }
           
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("white"))
                .frame(width: 350, height: 150)
                .overlay(
                    VStack {
                        Button(action: {
                           
                        }){
                            HStack {
                                Text("One Tap")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("back")
                                    .resizable()
                                    .scaledToFit()
                                
                                    .frame(maxHeight: 30)
                                    .opacity(0.35)
                                    .offset(x: 20)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                
                                
                            } .frame(height: 70)
                                .offset(y: 6)
                               
                        }
                        
                        Divider()
                        
                        Button(action: {
                           
                        }){
                            HStack {
                                Text("Two Tap")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("back")
                                    .resizable()
                                    .scaledToFit()
                                
                                    .frame(maxHeight: 30)
                                    .opacity(0.35)
                                    .offset(x: 20)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                
                                
                                
                            } .frame(height: 70)
                                .offset(y: -6)
                                
                        }
                        
                    }
                    
 
                )  .font(.system(size: 18, weight: .semibold))
            
            HStack {
                Text("Custom")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.gray.opacity(0.9))
                    .padding(.leading, 30)
                Spacer()
            }.padding(.top, 10)
    
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("white"))
                .frame(width: 350, height: 70)
                .overlay(
                    VStack {
                        Button(action: {
                           coverPattern = true
                        }){
                            HStack {
                                Text("Create Custom Pattern")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("back")
                                    .resizable()
                                    .scaledToFit()
                                
                                    .frame(maxHeight: 30)
                                    .opacity(0.35)
                                    .offset(x: 20)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                
                                
                            } .frame(height: 70)
                    
                               
                        }
                        
                    }
                    
 
                )  .font(.system(size: 18, weight: .semibold))

        } .edgesIgnoringSafeArea(.all)
            .foregroundColor(Color("fg"))
            .background(Color("bg"))
            .fullScreenCover(isPresented: $coverPattern) {
                PatternView(log: log, cover: $coverPattern)
                    
            }
    
      
    
       
    }
}

struct Edit: View {
    
    @State var opacitySave: Double = 0
    
    var log: Person
    
    @State var fName: String = ""
    @State var lName: String = ""
    
    @Binding var mode: String
    @Binding var toggleFavorites: Bool
    
    var body: some View {
        
        VStack {
            VStack {
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    mode = "main"
                                }){
                                    Image("back")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(Color.blue)
                                        .scaledToFit()
                                        .frame(maxHeight: 30)
                                        .padding(.leading, 10)
                                    
                                    
                                    Text("Back")
                                        .font(.system(size: 17, weight: .semibold))
                                        .offset(x: -10)
                                        .foregroundStyle(.blue)
                                    
                                }
                                Spacer()
                            }
                            Text("People")
                                .font(.system(size: 20, weight: .medium))
                                .padding(.top, 1)
                            
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
                        .frame(width: 350, height: 221)
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
                                
                                  
                                
                                Spacer()
                                VStack {
                                    
                                    log.circleImg(size: 110, x: toggleFavorites)
                                     
                                    
                                    
                                    Text("Log the individual's full name and \npreferred name")
                                        .font(.system(size: 15, weight: .medium))
                                        .multilineTextAlignment(.center)
                                    
                                }
                                    .padding(.trailing, 20)
                                
                                
                            }.padding(20)
                        )
                    
                    
                }.padding(.bottom, 10)
                
            }.edgesIgnoringSafeArea(.all)
           
            HStack {
                Text("Input Name")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.leading, 30)
            
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("white"))
                .frame(width: 350, height: 220)
                .overlay(
                    VStack {
                        // TextField for First Name
                        TextField("First Name", text: $fName)
                        
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 18, weight: .medium))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)

                        // TextField for Last Name
                        TextField("Last Name", text: $lName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 18, weight: .medium))
                            .padding(.horizontal, 20)
                            .padding(.top, 10)

                        // Save Button
                        Button(action: {
                            log.fName = fName
                            log.lName = lName
                            withAnimation(.easeIn(duration: 0.3)) {
                                opacitySave = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    opacitySave = 0.0
                                }
                            }
                        }) {
                            ZStack {
                                Text("Save")
                                    .frame(maxHeight: 50)
                                    .foregroundColor(.blue)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundStyle(.green)
                                    .opacity(opacitySave)
                                    .offset(x: 60, y: 8)
                                 
                                    
                            }
                           
                            
                        }
                    }
                    .padding(.bottom, 20)
 
                )  .font(.system(size: 18, weight: .semibold))
            
            
    
              
           

        } .edgesIgnoringSafeArea(.all)
            .foregroundColor(Color("fg"))
            .background(Color("bg"))
    
            .onAppear {
                fName = log.fName
                lName = log.lName
            }
      
    
       
    }
}

struct mainView: View {
    
    var log: Person
    @Binding var mode: String
    @Binding var toggleFavorites: Bool
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    mode = "home"
                                }){
                                    Image("back")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(Color.blue)
                                        .scaledToFit()
                                        .frame(maxHeight: 30)
                                        .padding(.leading, 10)
                                    
                                    
                                    Text("Back")
                                        .font(.system(size: 17, weight: .semibold))
                                        .offset(x: -10)
                                        .foregroundStyle(.blue)
                                    
                                }
                                Spacer()
                            }
                            Text("People")
                                .font(.system(size: 20, weight: .medium))
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
                        .frame(width: 350, height: 180)
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
                                
                                Spacer()
                                HStack {
                                    log.circleImg(size: 110, x: toggleFavorites)
                                        .padding(.leading, 30)
                                    
                                    Spacer()
                                    VStack {
                                        Text("\(log.fName) \(log.lName)")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundStyle(Color("fg"))
                                            .offset(y: -5)
                                        Text("''\(log.fName)''")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundStyle(Color.gray)
                                        
                                        
                                        Button(action: {
                                            mode = "edit"
                                        }){
                                            Text("Edit")
                                                .font(.system(size: 15, weight: .medium))
                                                .foregroundStyle(.blue)
                                                .offset(y: 5)
                                        }
                                        
                                        
                                    }
                                }.padding(.bottom, 20)
                                    .padding(.trailing, 20)
                                
                                
                            }.padding(20)
                        )
                    
                    
                }.padding(.bottom, 20)
                
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("white"))
                    .frame(width: 350, height: 140)
                    .overlay(
                        VStack {
                            HStack {
                                Text("Add to Favorites")
                                
                                    .padding(.leading, 20)
                                Spacer()
                                Toggle("", isOn: $toggleFavorites)
                                    .padding(.trailing, 20)
                                    . onChange(of: toggleFavorites) {
                                        log.isFavorite = !toggleFavorites
                                    }
                                
                            }.frame(height: 70)
                                .offset(y: 6)
                            
                            Divider()
                            Button(action: {
                                mode = "haptics"
                            }){
                                HStack {
                                    Text("Haptics")
                                        .padding(.leading, 20)
                                    Spacer()
                                    Image("back")
                                        .resizable()
                                        .scaledToFit()
                                    
                                        .frame(maxHeight: 30)
                                        .opacity(0.35)
                                        .offset(x: 20)
                                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                    
                                    
                                } .frame(height: 70)
                            }
                            .offset(y: -6)
                            
                            
                            
                        } .font(.system(size: 18, weight: .semibold))
                        
                        
                    )
                
                
                
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("white"))
                    .frame(width: 350, height: 70)
                    .overlay(
                        Button(action: {
                            mode = "scan"
                        }){
                            HStack {
                                Text("Edit FaceScan")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("back")
                                    .resizable()
                                    .scaledToFit()
                                
                                    .frame(maxHeight: 30)
                                    .opacity(0.35)
                                    .offset(x: 20)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                
                                
                            } .frame(height: 70)
                        }
                            .font(.system(size: 18, weight: .semibold))
                        
                    )
                
                
            }.padding(.top, 5)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("white"))
                    .frame(width: 350, height: 70)
                    .overlay(
                        Button(action: {
                            mode = "findMy"
                        }){
                            HStack {
                                Text("Add FindMy")
                                    .padding(.leading, 20)
                                Spacer()
                                Image("back")
                                    .resizable()
                                    .scaledToFit()
                                
                                    .frame(maxHeight: 30)
                                    .opacity(0.35)
                                    .offset(x: 20)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                
                                
                            } .frame(height: 70)
                        }
                            .font(.system(size: 18, weight: .semibold))
                        
                    )
                
                
            }.padding(.top, 5)
            Spacer()
        }
            .foregroundColor(Color("fg"))
            .background(Color("bg"))
    
    
    }
}

#Preview {
    if #available(iOS 18.0, *) {
        PeopleSettingsView(log: UserStore.example().people.first!, goTabAfter: false)
            .environmentObject(UserStore.example())
    } else {
        // Fallback on earlier versions
    }
}
