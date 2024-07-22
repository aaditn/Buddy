import SwiftUI
import Foundation

struct BluetoothView: View {
  @State private var continuePage = false
  @State private var bluetoothError: Error?

   

  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          Text("Set Up a New Device")
            .font(.system(size: 27, weight: .medium))
            .foregroundStyle(Color("white"))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)

        VStack {
          if let error = bluetoothError {
            Text("Error: \(error.localizedDescription)")
              .foregroundColor(.red)
          } else {
            HStack {
              Text("Pairing...")
                .font(.system(size: 50, weight: .semibold))
                .foregroundStyle(Color("primary"))
                .padding(.leading, 50)
              Spacer()
            }
            .padding(.top, 40)

            Image("Pear Servos")
              .resizable()
              .frame(width: 275, height: 250)

            Text("Bring device close to phone")
              .font(.system(size: 25, weight: .semibold))
              .padding(.bottom, 1)
              .padding(.top, 10)
              .foregroundStyle(Color("white"))
            Text("Press and hold the power button")
              .font(.system(size: 20, weight: .semibold))
              .opacity(0.7)
              .padding(.bottom, 50)
              .foregroundStyle(Color("white"))
            Spacer()
          }

          Button(action: {
           /* let session = ASAccessorySession()
            session.activate { (error) in
              if let error = error {
                print("Error activating session: \(error)")
                self.bluetoothError = error
                return
              }
              session.showPicker(displayItems: [myAccessoryItem])
            
            }
            */
          }) {
            HStack {
              Image("bluetooth")
                .resizable()
                .scaledToFit()
                .colorInvert()
                .padding(.leading, 15)
                .padding(.vertical, 10)

              Text("Pair")
                .font(.system(size: 25, weight: .semibold))
                .foregroundStyle(.white)
              Spacer()
            }
            .frame(width: 128, height: 54)
          }
          .background(Color("primary"))
          .cornerRadius(39)
          .padding(.bottom, 10)

          // Consider handling successful pairing and enabling "Continue" here
          Button(action: {
            // Handle successful pairing (e.g., navigate to a connected device view)
            continuePage = true
          }) {
            Text("Continue")
              .font(.system(size: 20, weight: .semibold))
              .foregroundStyle(Color("white"))
          }
          .disabled(bluetoothError != nil) // Disable "Continue" if there's an error

        }
      }
      .background(Color("bg"))
    }
    .navigationBarHidden(true)
      
       .fullScreenCover(isPresented: $continuePage) {
           HomeView()
               .transition(.opacity)
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
  BluetoothView()
}
