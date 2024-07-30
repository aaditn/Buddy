import SwiftUI

@available(iOS 18.0, *)
struct ContentView: View {
    @State private var textSize: CGFloat = 0.8
    @State private var textOpacity: Double = 0.0
    
    @State private var textSize2: CGFloat = 0
    @State private var textOpacity2: Double = 0
    
    @State private var textOpacity3: Double = 0
    
    @State private var navigateToBluetoothView = false
    
    var body: some View {
        Button(action: {
            withAnimation {
                navigateToBluetoothView = true
            }
          
        }){
            VStack {
                VStack {
                    Text("Buddy")
                        .font(.system(size: 45 * textSize, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white.opacity(0.7), Color("fg")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 300, height: 200)
                        .opacity(textOpacity)
                    
                    /*Group {
                        Text("Migraine is a **common** and **treatable** condition and patients **are not alone**, although they may feel that way,” says **Emily Rubenstein Engel, MD,** a **Scripps Clinic neurologist.**")
                            .underline(false)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 15, weight: .bold))
                            .lineSpacing(2.0)
                            .opacity(textOpacity2)
                    }
                    .foregroundStyle(Color("white"))
                    .frame(maxWidth: 270)
                     */
                }.offset(y: -200)
                
                HStack {
                
                    Text("Click Anywhere to Begin")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color("fg"))
                        .opacity(textOpacity3)
                     
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeIn(duration: 3.0)) {
                       
                            textOpacity3 = 1
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("bg"))
            .onAppear {
                withAnimation(.easeIn(duration: 2.0)) {
                    textSize = 1.0
                    textOpacity = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeIn(duration: 2.0)) {
                        textSize2 = 1
                        textOpacity2 = 1
                    }
                }
               
                DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
                    withAnimation {
                        navigateToBluetoothView = true
                    }
                }
                
            }
        }
       
        .fullScreenCover(isPresented: $navigateToBluetoothView) {
            SignUpView()
                .transition(.opacity)
        }
        
        

    }
}

#Preview {
    if #available(iOS 18.0, *) {
        ContentView()
            .environmentObject(UserStore.example())
    } else {
        // Fallback on earlier versions
    }
}
