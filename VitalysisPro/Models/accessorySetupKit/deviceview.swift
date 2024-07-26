import SwiftUI

@available(iOS 18.0, *)
struct DeviceView: View {
    @State var accessorySessionManager = AccessorySessionManager()
    @AppStorage("accessoryPaired") private var accessoryPaired = false
    
    var body: some View {
        if accessoryPaired {
            PairedView(accessorySessionManager: accessorySessionManager)
        } else {
            VStack {
                Spacer()
                
                VStack {
                    Text("Welcome to")
                        .font(.title2)
                    Text("Buddy")
                        .font(.system(size: 90, weight: .bold))
                        .foregroundStyle(Color.accentColor)
                    Text("Pair your Buddy to get started.")
                        .foregroundStyle(.secondary)
                }
                
                Spacer(minLength: 20)
                
                Image("render1")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                
                Button {
                    accessorySessionManager.presentPicker()
                } label: {
                    Text("Pair")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal, 28)
                .padding(.top, 20) // Add top padding to create some space between the image and the button
                
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    if #available(iOS 18.0, *) {
        DeviceView()
    } else {
        // Fallback on earlier versions
    }
}
