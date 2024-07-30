import SwiftUI
import Foundation


@available(iOS 18.0, *)
struct BluetoothView: View {
    @State private var continuePage = false
    @State private var bluetoothError: Error?
    let isIntro: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var mode: Int
    

   

  var body: some View {
      if false {
        //  PairedView(accessorySessionManager: accessorySessionManager)
      } else {
          VStack {
              ZStack {
                  Image("header")
                      
                      .resizable()
                      .frame(height: 130)
                      .opacity(0.4)
                  VStack {
                      ZStack {
                          if (!isIntro) {
                              HStack {
                                  Button(action: {
                                      mode = -1
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
                          }
                         
                          Text("Bluetooth")
                              .font(.system(size: 25, weight: .semibold))
                              .foregroundStyle(Color.white)
                         
                      }.padding(.top, 30)
                      
                      
                      
                  }.frame(height: 130)
                    
                
                 
                  
              }
              ZStack {
                  
                  Image("header")
                      .resizable()
                      .offset(y: -10)
                      .frame(height: 110)
                  HStack {
                      Text("Pairing...")
                          .padding(.leading, 30)
                          .padding(.top, 5)
                          .foregroundStyle(Color("fg"))
                          .font(.system(size: 35, weight: .semibold))
                      Spacer()
                  }
              }
              if (colorScheme == .dark) {
                  Image("bluetoothImage")
                      .resizable()
                      .scaledToFit()
                      .frame(height: 210)
                      .padding(.top, 20)
                      .colorInvert()
              } else {
                  Image("bluetoothImage")
                      .resizable()
                      .scaledToFit()
                      .frame(height: 210)
                      .padding(.top, 20)
                      
              }
             
             
              VStack {
                  Text("Bring device close to phone.")
                      .font(.system(size: 25, weight: .semibold))
                  Text("Press and hold the power button")
                      .font(.system(size: 20, weight: .semibold))
                      .opacity(0.7)
                    
                 
              }.padding(.top, 50)
             
              Button(action: {
                  continuePage = true
              }){
                  ZStack {
                      RoundedRectangle(cornerRadius: 16)
                          .fill(Color("primary").opacity(0.9))
                      HStack {
                          Image("bluetooth")
                              .resizable()
                              .scaledToFit()
                              .frame(height: 35)
                              .colorInvert()
                              .padding(.leading, 15)
                              
                          
                              
                              
                          Spacer()
                      }
                     
                      Text("Pair")
                          .foregroundStyle(Color.white)
                          .font(.system(size: 24, weight: .medium))
                          
                        
                  }.frame(width: 350, height: 65)
                      .padding(.top, 50)
                 
                  
                  
              }
              
              Button(action: {
                  continuePage = true
              }) {
                  Text("Skip")
                      .font(.system(size: 18, weight: .semibold))
                      .padding(.top, 10)
                      .foregroundStyle(Color.white)
              }
            
              
              Spacer()
                  
          }
          .background(Color("white"))
        
          .fullScreenCover(isPresented: $continuePage) {
              /*
              PairedView(accessorySessionManager: accessorySessionManager)
                  .transition(.opacity)
               */
              TabsView()
         }
          .edgesIgnoringSafeArea(.all)
      }
      
        
  }
}

/*@available(iOS 18.0, *)
class bluetoothConnect {
    
    var session = ASAccessorySession()
    
    let joint1UUID = CBUUID()
    let joint2UUID = UUID()
    let joint3UUID = UUID()
    let joint1Descriptor = ASDiscoveryDescriptor()
    let joint2Descriptor = ASDiscoveryDescriptor()
    let joint3Descriptor = ASDiscoveryDescriptor()
   
   
    
    func start() {
        joint1Descriptor.bluetoothServiceUUID = joint1UUID
        joint2Descriptor.bluetoothServiceUUID = joint2UUID
        joint3Descriptor.bluetoothServiceUUID = joint3UUID
        
        session.activate(on: DispatchQueue.main, eventHandler: handleSessionEvent(event:))
    }
    
    func handleSessionEvent(event: ASAccessoryEvent) {
      
        switch event.eventType {
        case .activated:
            <#code#>
        default:
            
            
    }
   
    
}
 */
#Preview {
    @Previewable @State var mode: Int = 0
    if #available(iOS 18.0, *) {
        BluetoothView(isIntro: true, mode: $mode)
            .environmentObject(UserStore.example())
    } else {
        // Fallback on earlier versions
    }
}
