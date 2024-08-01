import SwiftUI

@available(iOS 18.0, *)
struct HomeView: View {
    
    @EnvironmentObject var user: UserStore
    
    @State var currentIndex: Bool = false
    @State var isDelay: Bool = false
    @State var isRunning: Bool = false
    @State var goEmergencyCall: Bool = false
    @State var emergeColor: Color = Color("gray")
    @State var showPopup: Bool = false
    @State var showPressureMap: Bool = false
    @State var offsetYRect: CGFloat = 0
    @State var opacityAnimation: Double = 0.9
    @State var pressureMapTextSize: CGFloat = 25
    @State var offsetYPressureMapText: CGFloat = 0
    
    
    @State var showScan: Bool = false
    @State var showPeople: Bool = false
    @State var showSettings: Bool = false
    @State var showUserSettings: Bool = false
    
    @State var person: Person = UserStore.example().people.first!
    

    
    var body: some View {
        
        if (showScan) {
            ScanView()
                .transition(.move(edge: .trailing))
                .animation(.spring(), value: showScan)
        } else if (showPeople) {
            PeopleView()
                .transition(.move(edge: .leading))
                .animation(.snappy, value: showPeople)
        } else if (showSettings) {
            PeopleSettingsView(log: person, goTabAfter: false)
        } else if (showUserSettings) {
            SettingsView()
        } else {
            VStack {
                ZStack {
                    Image("header")
                        .resizable()
                        .frame(height: 170)
                    VStack {
                        HStack {
                            if (showPressureMap) {
                                Button(action: {
                                    showPressureMap = false
                                    currentIndex = false
                                }) {
                                    Image("back")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 50)
                                        .padding(.leading, 20)
                                }
                            } else {
                                Text("Summary")
                                    .font(.system(size: 40, weight: .semibold))
                                    .padding(.leading, 20)
                                    .offset(y: 5)
                                    .foregroundStyle(Color.black)
                            }
                            
                            Spacer()
                        }
                        HStack {
                            Text("Recent Scan")
                                .font(.system(size: pressureMapTextSize, weight: .semibold))
                                .foregroundStyle(Color.black)
                                .padding(.leading, 20)
                                .offset(y: offsetYPressureMapText)
                                .onChange(of: showPressureMap) { _ in
                                    withAnimation(.linear(duration: 0.5)) {
                                        offsetYPressureMapText = showPressureMap ? -30 : 0
                                    }
                                    withAnimation(.linear(duration: 0.5)) {
                                        pressureMapTextSize = showPressureMap ? 40 : 25
                                    }
                                }
                            
                            Spacer()
                            
                        }
                        .offset(y: 15)
                    }
                    Button(action:{
                        showUserSettings = true
                        print("hehehe")
                    }){
                        GetProfile(size: 60)
                            .padding(.trailing, 15)
                    } .offset(x: 130, y: 20)
                }
                Button(action: {
                    currentIndex = true
                }) {
                    ZStack {
                        FacePopup()
                    }
                }
                .offset(y: offsetYRect)
                .onChange(of: showPressureMap) { _ in
                    withAnimation(.linear(duration: 0.5)) {
                        offsetYRect = currentIndex ? -45 : 0
                    }
                    withAnimation(.linear(duration: 0.5)) {
                        opacityAnimation = currentIndex ? 0.8 : 0.9
                    }
                }
                
                
                NormalView(showScan: $showScan, showPeople: $showPeople,  person: $person, isPerson: $showSettings)
                    .onChange(of: showPeople) {
                        print (showPeople)
                    }
                Spacer() // Ensure Spacer is placed correctly to push content to the bottom
            }
            .onChange(of: showPeople) {
                print (showPeople)
            }
            .foregroundColor(Color("fg"))
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
            .onChange(of: currentIndex) { newValue in
                showPressureMap = newValue
            }
        }
    }
}

struct NormalView: View {
    @EnvironmentObject var user: UserStore
    @State var editMode: Bool = false
    @Binding var showScan: Bool
    @Binding var showPeople: Bool
    
    @Binding var person: Person
    @Binding var isPerson: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Favorites")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.leading, 30)
                Spacer()
                Button(action: {
                    print("hehe")
                }) {
                    Text("About")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.blue)
                        .padding(.trailing, 40)
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("white"))
                    .frame(width: 350, height: 190)
                
                VStack {
                    HStack {
                        Button(action: {
                            showPeople = true
                        }){
                            VStack(alignment: .leading) {
                                ImageGridHome(size: 60, selectPerson: $person, isPerson: $isPerson)
                                
                                Text("Friends & Loved Ones")
                                Text("\(user.people.count)")
                                    .foregroundColor(Color.gray)
                            }
                            .font(.system(size: 14, weight: .medium))
                            .padding(.leading, 30)
                        }
                       
                        
                        ZStack {
                            Button(action: {}) {
                                VStack {
                                    Image("FindMy")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 136)
                                    VStack(alignment: .leading) {
                                        Text("Find My")
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                }
                                .padding(.trailing, 30)
                                .padding(.bottom, 20)
                            }
                        }
                    }
                }
            }
            
            Button(action: {
                showScan = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("secondary"))
                        .frame(width: 350, height: 70)
                    HStack {
                        Text("New Scan")
                            .padding(.leading, 40)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color.white)
                        Spacer()
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .colorInvert()
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .frame(height: 30)
                            .padding(.trailing, 40)
                    }
                }
            }
            .padding(.top, 10)
        }.onChange(of: showPeople) {
            print ("hehe \(showPeople)")
        }
    }
}

struct userView: View {
    var log: Person
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 60)
        }
    }
}


struct newCircle: View {
    var text: String
    
    var body: some View {
        Circle()
            .fill(Color("white"))
            .overlay(
                Text(text)
                    .foregroundColor(Color.black)
                    .font(.system(size: 15, weight: .bold))
            )
            .frame(maxHeight: 22)
    }
}

@available(iOS 18.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserStore.example())
    }
}
struct ImageGridHome: View {
    @EnvironmentObject var user: UserStore
    let size: Int
    @Binding var selectPerson: Person
    @Binding var isPerson: Bool

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                ForEach(user.people) { log in
                    Button(action: {
                        selectPerson = log
                        isPerson = true
                    }){
                        log.circleImg(size: size, showHeart: log.isFavorite)
                    }
                    
                }
                
            }
            
        }.frame(maxHeight: 130)
    }
}

