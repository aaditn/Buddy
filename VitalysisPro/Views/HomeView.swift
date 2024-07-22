import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var user: userStore
    
    @State var currentIndex: Int = -1
    
    @State var isDelay: Bool = false
    @State var isRunning: Bool = false

    @State var goEmergencyCall: Bool = false
    @State var emergeColor: Color = Color("gray")
    @State var showPopup: Bool = false
    
    @State var showPressureMap: Bool = false

    @State private var offsetYRect: CGFloat = 0
    @State private var opacityAnimation: Double = 0.0
    
    @State private var pressureMapTextSize: CGFloat = 25
    @State private var offsetYPressureMapText: CGFloat = 0
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image("header")
                        .resizable()
                        .frame(height: 153)
                    VStack {
                        HStack {
                            if (showPressureMap) {
                                Button(action: {
                                    showPressureMap = false
                                    currentIndex = -1
                                }) {
                                   Image("back")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 50)
                                        .padding(.leading, 20)
                                    
                                        .colorInvert()
                                        .offset(y: -20)
                                }
                            } else {
                                Text("Summary")
                                    .font(.system(size: 40, weight: .semibold))
                                    .padding(.leading, 20)
                            }
                          
                            Spacer()
                        }
                        HStack {
                            Text("Pressure Map")
                                .font(.system(size: pressureMapTextSize, weight: .medium))
                            
                                .padding(.leading, 20)
                                .offset(y: offsetYPressureMapText)
                                  .onChange(of: showPressureMap) {
                                      withAnimation(.linear(duration: 0.5)) { // Adjust animation type and duration
                                      offsetYPressureMapText = showPressureMap ? -30 : 0
                                    }
                                      withAnimation(.linear(duration: 0.5)) { // Adjust animation type and duration
                                      pressureMapTextSize = showPressureMap ? 40 : 25
                                    }
                                  }
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 40)
                } 
                Button(action: {
                    currentIndex = 4
                }) {
                    ZStack {
                        Hands(currentIndex: $currentIndex, opacity: $opacityAnimation)
                    }
                   
                }.offset(y: offsetYRect)
                    .onChange(of: showPressureMap) {
                        withAnimation(.linear(duration: 0.5)) { // Adjust animation type and duration
                        offsetYRect = showPressureMap ? -25 : 0
                      }
                        withAnimation(.linear(duration: 0.5)) { // Adjust animation type and duration
                            opacityAnimation = showPressureMap ? 0.15 : 0
                      }
                    }
                if (showPressureMap) {
                    
                    PressureMapView(currentIndex: $currentIndex)
                       
                } else {
                    NormalView(currentIndex: $currentIndex, emergeColor: $emergeColor, showPopup: $showPopup)
                       
                }
                
               
                
               
                Spacer()
            }
          
            .foregroundColor(Color.white)
            .background(Color("bg"))
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    if showPopup {
                        SlideDownPopup(showPopup: $showPopup, goEmergencyCall: $goEmergencyCall, emergeColor: $emergeColor)
                            .transition(.move(edge: .top))
                            .animation(.spring())
                        Spacer()
                    }
                   
                }
            )
            .onChange(of: currentIndex) {
                if (currentIndex >= 0 && currentIndex <= 3) {
                    showPressureMap = true

                }
            }
            
        }
    }
}



struct NormalView: View {
    @EnvironmentObject var user: userStore
    @Binding var currentIndex: Int
    @Binding var emergeColor: Color
    @Binding var showPopup: Bool
    @State var editMode: Bool = false
    
    
    
    var body: some View {
       
        
        Divider()
        
        HStack {
            Text("Adjustments")
                .font(.system(size: 25, weight: .semibold))
                .padding(.leading, 20)
            Spacer()
            Button(action: {
                editMode = true
                print("button clicked")
            }) {
                Text("Edit")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.blue)
                    .padding(.trailing, 40)
            }
        }
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("gray"))
            VStack {
                Button(action: {}) {
                    HStack {
                        Image("Camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .padding(.leading, 12)
                        Text("Hand Topography")
                        Spacer()
                        Text("Scan >")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color("primary"))
                            .padding(.trailing, 10)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .background(Color("white"))
                
                Button(action: {}) {
                    HStack {
                        Image("Compression")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .padding(.leading, 12)
                        Text("Compression")
                        Spacer()
                        Text("Resize >")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color("primary"))
                            .padding(.trailing, 10)
                    }
                }
            }
            .font(.system(size: 20, weight: .semibold))
        }
        .frame(height: 138)
        .padding(.horizontal, 10)
        
       
        Button(action: {
            showPopup = true
            emergeColor = Color("emergency")
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(emergeColor)
                    .padding(.horizontal, 10)
                Text("Emergency Call")
                    .font(.system(size: 20, weight: .semibold))
            }
            .frame(height: 59)
            .padding(.top, 40)
        }
        
    }
}
struct PressureMapView: View {
    
    @EnvironmentObject var user: userStore
    @Binding var currentIndex: Int
    @State var tempSlider: Double = 0.0
 
    var body: some View {
        VStack {
           
            VStack {
                HStack {
                    Text("Choose the level of pressure")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.leading, 15)
                    Spacer()
                }
                HStack {
                    Slider(
                        value: $tempSlider,
                            in: 0...10,
                        step: 1
                        ) {
                            Text("Speed")
                        } minimumValueLabel: {
                            Image("weak")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 30)
                                .padding(.trailing, 10)
                                
                        } maximumValueLabel: {
                            Image("strong")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 40)
                                .padding(.leading, 10)
                        } /*onEditingChanged: { editing in
                            isEditing = editing
                        }*/
                    
                }.frame(maxWidth: 350, maxHeight: 40)
                    .foregroundStyle(Color("green"))
                    /*.onChange(of: tempSlider, {
                        user.servos[currentIndex].power = tempSlider
                    })*/
            
            }
            HStack {
                Text("Explore Curated Routines:")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.leading, 20)
                    .padding(.vertical, 10)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("gray"))
                   
                
                ScrollView {
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            HStack {
                   
                                Text("My Standard")
                                   .foregroundColor(Color("white"))
                                   .padding(.horizontal, 15)
                                
                                 
                                newCircle(text: "I")
                                newCircle(text: "H")
                                newCircle(text: "U")
                            
                            
                               
                                Spacer()
                                 
                                Text("Run >")
                                 
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(Color("primary"))
                                    .padding(.trailing, 20)
                            }.frame(maxHeight: 22)
                        }.frame(height: 50)
                           
                        
                   
                            
                    }
                    .frame(maxWidth: .infinity)
               
                       

                       
                    
                    
                 
                
                    
                    Divider()
                        .background(Color("white"))
                        .padding(.vertical, 0)
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            HStack {
                                
                                Text("Anxiety Relief")
                                    .foregroundColor(Color("white"))
                                    .padding(.horizontal, 15)
                                
                                newCircle(text: "H")
                                newCircle(text: "U")
                                
                                
                                
                                Spacer()
                                
                                Text("Run >")
                                
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(Color("primary"))
                                    .padding(.trailing, 20)
                            }.frame(maxHeight: 22)
                        }.frame(height: 50)
                           
                    }
                    
                    Divider()
                        .background(Color("white"))
                        .padding(.vertical, 0)
 
                }
                .font(.system(size: 20, weight: .semibold))
            
                
            }.frame(height: 138)
                .padding(.horizontal, 10)
           
           
            
           
            
           
            
            Spacer()
           
            
        }.foregroundStyle(Color("white"))
            .background(Color("bg"))
            .ignoresSafeArea(edges: .all)
           
        
    }
    
}

struct newCircle: View {
  var text: String
  
  var body: some View {
    Circle()
      .fill(Color("white"))
      .overlay(
        Text(text)
          .foregroundStyle(Color.black)
          .font(.system(size: 15, weight: .bold))
      )
      .frame(maxHeight: 22)
  }
}




#Preview {
    HomeView()
}
