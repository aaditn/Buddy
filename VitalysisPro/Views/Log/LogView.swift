import SwiftUI

@available(iOS 18.0, *)
struct LogView: View {
    @EnvironmentObject var user: UserStore
    
    @State private var showDates: Int = 0
    @State var showSettings: Bool = false
    
    var body: some View {
        if (showSettings) {
            SettingsView()
        } else {
            VStack {
                
                ZStack {
                    Image("header")
                        .resizable()
                        .frame(height: 170)
                    VStack {
                        HStack {
                            Text("Activity")
                                .font(.system(size: 37, weight: .bold))
                                .padding(.leading, 30)
                              
                            Spacer()
                        }
                        HStack {
                            Text("Motion Log")
                                .font(.system(size: 27, weight: .semibold))
                                .padding(.leading, 30)
                            Spacer()
                            
                        }
                    }.padding(.top, 15)
                    
                    Button(action:{
                        showSettings = true
                        print("hehehe")
                    }){
                        GetProfile(size: 60)
                            .padding(.trailing, 15)
                    } .offset(x: 130, y: 20)
                    
                } .foregroundStyle(Color.black)
                
                Picker("Show Dates", selection: $showDates) {
                    Text("Day").tag(0)
                    Text("Month").tag(1)
                    Text("Year").tag(2)
                }
                .font(.system(size: 15, weight: .semibold))
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("white"))
                        .shadow(radius: 5) // Optional: adds a shadow for better visual separation
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(user.encounters) { encounter in
                                // Define the time intervals
                                let oneDayInSeconds: TimeInterval = 24 * 60 * 60
                                let oneWeekInSeconds: TimeInterval = 30 * 24 * 60 * 60
                                let oneMonthInSeconds: TimeInterval = 365 * 24 * 60 * 60
                                let currentDate = Date.now
                                let isWithinLastDay = encounter.date.timeIntervalSince(currentDate) >= -oneDayInSeconds
                                let isWithinLastWeek = encounter.date.timeIntervalSince(currentDate) >= -oneWeekInSeconds
                                let isWithinLastMonth = encounter.date.timeIntervalSince(currentDate) >= -oneMonthInSeconds
                                
                                if (showDates == 0 && isWithinLastDay) ||
                                   (showDates == 1 && isWithinLastWeek) ||
                                   (showDates == 2 && isWithinLastMonth) {
                                    Button(action: {
                                        // Action for button tap
                                    }) {
                                        HStack(alignment: .center) { // Align items in the center
                                            Text(encounter.person.name())
                                                .font(.system(size: 18, weight: .medium))
                                                .alignmentGuide(.firstTextBaseline) { d in d[.firstTextBaseline] }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "person")
                                                .foregroundStyle(Color("primary"))
                                                .padding(.trailing, 40)
                                                .alignmentGuide(.firstTextBaseline) { d in d[.firstTextBaseline] }
                                            
                                            Text(formatDate(date: encounter.date))
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundStyle(Color.gray.opacity(0.7))
                                                .padding(.trailing, 10)
                                                .alignmentGuide(.firstTextBaseline) { d in d[.firstTextBaseline] }
                                        }
                                        .foregroundStyle(Color("fg"))
                                        .padding(.vertical, 10)
                                    }
                                    Divider()
                                }
                            }
                        }
                        .padding()
                    
                    }
                    
                }.frame(width: 350, height: 190)
                   
                
                HStack {
                    Text("Motion Trends")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.leading, 30)
                    Spacer()
                    Button(action: {
                        // Action for "About" button
                    }) {
                        Text("About")
                            .foregroundStyle(Color.blue)
                            .font(.system(size: 15, weight: .medium))
                            .padding(.trailing, 30)
                    }
                }.padding(.top, 10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("white"))
                    Image("MotionGraph")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 330)
                        .padding(.leading, 10)
                    
                }.frame(width: 350, height: 230)
                
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
struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
            .environmentObject(UserStore.example())
    }
}
