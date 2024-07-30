import SwiftUI


@available(iOS 18.0, *)
struct TabsView: View {
    @State private var selectedIndex = 0
    private let tabs = [
        ("Home", "house.fill"),
        ("Log", "list.bullet.rectangle"),
        ("Discover", "books.vertical.fill")]
    
    var body: some View {
        ZStack {
           
            
            ZStack {
                if selectedIndex == 0 {
                    HomeView()
                } else if selectedIndex == 1 {
                    LogView()
                } else if selectedIndex == 2 {
                    BrowseView()
                }
            }
            
            CustomTabBar(tabs: tabs, selectedIndex: $selectedIndex)
                .background(Color("white"))
                .offset(y: 370)
           
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
                .onTapGesture {
                    selectedIndex = index
                }
                Spacer()
            }
        }
        
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background(Color("white"))
    }
}

@available(iOS 18.0, *)
struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .environmentObject(UserStore.example())
    }
}
