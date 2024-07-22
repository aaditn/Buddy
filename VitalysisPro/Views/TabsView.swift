import SwiftUI

struct TabsView: View {
    @State private var selectedIndex = 0
    private let tabs = [
        ("Home", "hand.raised.fill"),
        ("Data", "chart.xyaxis.line"),
        ("Contacts", "person.2.fill")
    ]
    
    var body: some View {
        ZStack {
            // The content for each tab
            ZStack {
                if selectedIndex == 0 {
                    HomeView()
                      
                } else if selectedIndex == 1 {
                    DataView()
                } else if selectedIndex == 2 {
                    BluetoothView()
                }
            }
            
            // Custom Tab Bar
            CustomTabBar(tabs: tabs, selectedIndex: $selectedIndex)
                .offset(y: 390)
        }
        .background(Color("bg"))
        .edgesIgnoringSafeArea(.all)
    }
}

import SwiftUI

struct CustomTabBar: View {
    let tabs: [(String, String)]
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Spacer()
                VStack {
                    
                    Image(systemName: tabs[index].1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(selectedIndex == index ? .blue : .gray)
                    Text(tabs[index].0)
                        .font(.footnote)
                        .foregroundColor(selectedIndex == index ? .blue : .gray)
                }
                .frame(width: 100)
                .onTapGesture {
                    selectedIndex = index
                }
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background(Color("gray"))
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
