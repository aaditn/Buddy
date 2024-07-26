import SwiftUI

@available(iOS 18.0, *)
struct BrowseView: View {
    @EnvironmentObject var user: UserStore
    
    @State private var showDates: Int = 0
    @State var goSettings: Bool = false
    
    var body: some View {
        if (goSettings) {
            SettingsView()
        } else {
            VStack {
                ZStack {
                    GetProfile(size: 60)
                        .padding(.trailing, 15)
                    Image("header")
                        .resizable()
                        .frame(height: 170)
                    VStack {
                        HStack {
                            Text("Discover")
                                .font(.system(size: 37, weight: .bold))
                                .padding(.leading, 30)
                            
                              
                            Spacer()
                        }
                        HStack {
                            Text("Resources")
                                .font(.system(size: 27, weight: .semibold))
                                .padding(.leading, 30)
                            
                            Spacer()
                           
                            
                        }
                    }.padding(.top, 15)
                        .foregroundStyle(Color.black)
                    Button(action:{
                        goSettings = true
                        print("hehehe")
                    }){
                        GetProfile(size: 60)
                            .padding(.trailing, 15)
                    } .offset(x: 130, y: 20)
                   
                }
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("white"))
                            .frame(width: 350, height: 250)
                        
                        VStack {
                            Image("BlindWebsiteLink")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350, height: 160)
                                .clipShape(
                                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, topTrailing: 20))
                                )
                            
                            
                          
                            Link(destination: URL(string: "https://afb.org/blindness-and-low-vision/visionaware")!) {
                                HStack {
                                    VStack() {
                                        HStack {
                                            Text("Resources for adults new to \nvision loss.")
                                                .font(.system(size: 18, weight: .semibold))
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("American Foundation for the Blind")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundStyle(Color("fg").opacity(0.4))
                                            Spacer()
                                        }
                                    }
                                    .padding(.leading, 10)
                                    
                                    Image("back")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 30)
                                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                        .padding(.trailing, 20)
                                }.foregroundStyle(Color("fg"))
                                    .padding(.top, 10)
                            }
                                  
                                
                            Spacer()
                        }
                        
                    }.frame(width: 350, height: 250)
                    
                    
                 
                    HStack {
                        Text("Discover")
                            .font(.system(size: 25, weight: .semibold))
                  
                            .padding(.leading, 30)
                        Spacer()
                        
                    }
                    
                   
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("white"))

                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.purple.opacity(0.5))
                                    .frame(width: 80, height: 80)
                                Text("Testimonials")
                            }
                            .padding(.leading, 20)
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("primary"))
                                    .frame(width: 80, height: 80)
                                Text("Resources")
                            }
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("secondary"))
                                    .frame(width: 80, height: 80)
                                Text("Therapy")
                            }.padding(.trailing, 20)
                           
                            
                        } .font(.system(size: 16, weight: .medium))
                    }.frame(width: 350, height: 140)

                    HStack {
                        Text("More Articles")
                            .font(.system(size: 25, weight: .semibold))
                            .padding(.top, 1)
                            .padding(.leading, 30)
                        Spacer()
                        
                    }
                    ScrollView {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("fg").opacity(0.05))
                            VStack {
                                Link(destination: URL(string: "https://afb.org/blindness-and-low-vision/visionaware")!) {
                                    
                                    HStack {
                                        Image("eye")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 80)
                                        
                                            .padding(.leading, 20)
                                        Spacer()
                                        VStack(alignment: .leading ) {
                                            Text("Confidence Building for \nAdults with Vision Loss.")
                                                .font(.system(size: 18, weight: .semibold))
                                            Text("Reading Sight")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundStyle(Color("fg").opacity(0.5))
                                        }.font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(Color("fg"))
                                            .padding(.trailing, 30)
                                           
                                        
                                       
                                    }
                                    
                                }.frame(height: 100)
                                Divider()
                                Link(destination: URL(string: "https://afb.org/blindness-and-low-vision/visionaware")!) {
                                    
                                    HStack {
                                        Image("eye")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 80)
                                        
                                            .padding(.leading, 20)
                                        Spacer()
                                        VStack(alignment: .leading ) {
                                            Text("Confidence Building for \nAdults with Vision Loss.")
                                                .font(.system(size: 18, weight: .semibold))
                                            Text("Reading Sight")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundStyle(Color("fg").opacity(0.5))
                                        }.font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(Color("fg"))
                                            .padding(.trailing, 30)
                                           
                                        
                                       
                                    }
                                    
                                }.frame(height: 100)
                                Divider()
                                Link(destination: URL(string: "https://afb.org/blindness-and-low-vision/visionaware")!) {
                                    
                                    HStack {
                                        Image("eye")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 80)
                                        
                                            .padding(.leading, 20)
                                        Spacer()
                                        VStack(alignment: .leading ) {
                                            Text("Confidence Building for \nAdults with Vision Loss.")
                                                .font(.system(size: 18, weight: .semibold))
                                            Text("Reading Sight")
                                                .font(.system(size: 15, weight: .semibold))
                                                .foregroundStyle(Color("fg").opacity(0.5))
                                        }.font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(Color("fg"))
                                            .padding(.trailing, 30)
                                           
                                        
                                       
                                    }
                                    
                                }.frame(height: 100)
                                Divider()
                            }
                           
                        }
                        
                    }
                    .frame(width: 360, height: 140)
                }.offset(y: -30)
                 
               
                
                
                
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color("bg"))
        }
        
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter.string(from: date)
    }
}

@available(iOS 18.0, *)
struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
            .environmentObject(UserStore.example())
    }
}
