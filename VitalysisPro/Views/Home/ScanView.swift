//
//  ScanView.swift
//  sussy
//
//  Created by Aadit Noronha on 7/22/24.
//

import SwiftUI


@available(iOS 18.0, *)
struct ScanView: View {
    
    @State var showScan: Bool = false
    @State var showStart: Bool = false
    
    var body: some View {
        
        if (showScan) {
            HomeView()
                .transition(.move(edge: .leading))
                .animation(.spring())

        } else {
            VStack {
                ZStack {
                    Image("header")
                        .resizable()
                        .frame(height: 130)
                        .opacity(0.4)
                    VStack {
                        ZStack {
                            HStack {
                                Button(action: {
                                    showScan = true
                                }){
                                    Image("back")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundStyle(Color.blue)
                                        .scaledToFit()
                                        .frame(maxHeight: 30)
                                        .padding(.leading, 10)
                                    
                                    
                                    Text("Summary")
                                        .font(.system(size: 17, weight: .semibold))
                                        .offset(x: -10)
                                        .foregroundStyle(.blue)
                                    
                                }
                                Spacer()
                            }
                            Text("New Scan")
                                .font(.system(size: 25, weight: .semibold))
                           
                        }.padding(.top, 30)
                        
                        
                        
                    }.frame(height: 130)
                      
                  
                   
                    
                }
                Image("header")
                    .resizable()
                    .offset(y: -10)
                    .frame(height: 130)
               
                
                Image(systemName: "camera.viewfinder")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                
                VStack {
                    
                    Text("Add a new person to your")
                    
                    Text("inventory.")
                    Spacer()
                }.padding(.top, 5)
                    .frame(height: 300)
                
                Button(action: {
                    showStart = true
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("primary"))
                             .frame(width: 350, height: 55)
                             
                        HStack {
                            Text("Get Started")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color.white)
                        }
                    }
                    
                    
                }.padding(.top, 10)
                

                Spacer()
            }
            
            .foregroundColor(Color("fg"))
            .background(Color("bg"))
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $showStart) {
                CameraView(showStart: $showStart)
            }
        }
        
    }
}

@available(iOS 18.0, *)
struct CameraView: View {
    @ObservedObject var cameraManager = CameraManager()
    @Binding var showStart: Bool
    @State private var showAccessibility: Bool = false
    @State private var text: String = ""
    @State private var opacity: Double = 1
    @State private var showSettings: Bool = false
    @State private var log: Person = UserStore.example().people.first!
    @EnvironmentObject var user: UserStore
    @State private var playSuccess: Bool = false
    @State private var animateSuccessOpacity: Double = 0
    @State private var hide: Bool = false
    @State private var showNameInput: Bool = false
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var isUploading: Bool = false

    var body: some View {
        if showSettings {
            PeopleSettingsView(log: log, goTabAfter: true)
        } else {
            ZStack {
                if hide {
                    Circle()
                        .fill(Color("bg"))
                        .frame(width: 270, height: 270)
                } else {
                    CameraViewRepresentable(cameraManager: cameraManager)
                        .clipShape(Circle())
                        .frame(width: 270, height: 270)
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 5)
                                .foregroundStyle(Color.blue)
                                .frame(width: 270)
                        )
                }

                VStack {
                    HStack {
                        Button(action: {
                            showStart = false
                        }) {
                            Text("Cancel")
                                .font(.system(size: 18, weight: .medium))
                        }.padding(.leading, 10)
                        Spacer()
                    }
                    Spacer()
                }

                Text(text)
                    .font(.system(size: 50, weight: .thin))
                    .foregroundStyle(Color.gray)
                    .opacity(opacity)
                VStack {
                    Spacer()

                    Text("Bring your face within view.")
                        .font(.system(size: 23, weight: .semibold))
                        .padding(.top, 40)

                    Button(action: {
                        startBlinkingAnimation()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.gray)
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(Color("fg"))
                        }.frame(width: 80)
                    }

                    if playSuccess {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(Color.green)
                            .opacity(animateSuccessOpacity)
                            .padding(.top, 20)
                        Text("FaceScan is now complete.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(Color("fg"))
                    }

                    Button(action: {
                        showAccessibility = true
                    }) {
                        Text("Accessibility Options")
                            .font(.system(size: 18, weight: .medium))
                    }.padding(.top, 60)
                }.offset(y: playSuccess ? 100 : 0)
            }
            .offset(y: playSuccess ? -160 : -100)
            .onChange(of: text) { newValue in
                if newValue.isEmpty {
                    cameraManager.capturePhoto()
                }
            }
            .onReceive(cameraManager.$burstImages) { images in
                if let image = images.first {
                    let circularImage = circularImage(from: image)
                    showNameInput = true
                    playSuccess = true
                    withAnimation(.linear(duration: 1)) {
                        animateSuccessOpacity = 1
                    }
                }
            }
            .sheet(isPresented: $showNameInput) {
                VStack {
                    TextField("First Name", text: $fName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Last Name", text: $lName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Save") {
                        isUploading = true
                        Task {
                            do {
                                try await saveUserAndSendImage() {
                                    isUploading = false
                                    showNameInput = false
                                  
                                }
                            } catch {
                                print("error here")
                            }
                        }
                        showSettings = true
                    }
                    .padding()
                }
                .padding()
            }
        }
    }

    private func startBlinkingAnimation() {
        if text.isEmpty {
            print("Starting blinking animation...")
            text = "3"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    opacity = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    opacity = 1
                }
                text = "2"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    opacity = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    opacity = 1
                }
                text = "1"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    opacity = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                text = ""
                startBurstCapture()
            }
        }
    }

    private func startBurstCapture() {
        print("Starting burst capture...")
        cameraManager.startBurstCapture()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Stopping burst capture...")
            cameraManager.stopBurstCapture()
        }
    }

    private func circularImage(from image: UIImage) -> UIImage {
        let size = min(image.size.width, image.size.height)
        let squareRect = CGRect(x: (image.size.width - size) / 2, y: (image.size.height - size) / 2, width: size, height: size)

        guard let croppedCGImage = image.cgImage?.cropping(to: squareRect) else {
            return image
        }
        return image
    }

//    private func saveUserAndSendImage(completion: @escaping () -> Void) async {
//        print("Saving user and sending image...")
//
//        guard let image = cameraManager.burstImages.first else {
//            print("No image found in burst images")
//            return
//        }
//        let circularImage = circularImage(from: image)
//
//        // Save user in the environment store
//        let newUser = Person(
//            fName: fName,
//            lName: lName,
//            tag: "0001", // Use a fixed tag for the single user
//            isFavorite: false,
//            img: Image(uiImage: circularImage),
//            pattern: Pattern.oneTap()
//        )
//        user.people.append(newUser)
//        log = newUser
//
//        // Send image to server
//        do {
//            try await sendImageToServer(image: circularImage, personName: "\(fName)\(lName)", completion: completion)
//        } catch {
//            print("error in sending image")
//        }
//    }
    private func saveUserAndSendImage(completion: @escaping () -> Void) async {
        print("Saving user and sending image...")

        guard let image = cameraManager.burstImages.first else {
            print("No image found in burst images")
            return
        }
        let circularImage = circularImage(from: image)

        // Save user in the environment store
        let newUser = Person(
            fName: fName,
            lName: lName,
            tag: "0001", // Use a fixed tag for the single user
            isFavorite: false,
            img: Image(uiImage: circularImage),
            pattern: Pattern.oneTap()
        )

        await MainActor.run {
            user.people.append(newUser)
            log = newUser
        }

        // Send image to server
        do {
            try await sendImageToServer(image: circularImage, personName: "\(fName)\(lName)", completion: completion)
        } catch {
            print("Error in sending image")
        }
    }


    private func sendImageToServer(image: UIImage, personName: String, completion: @escaping () -> Void) async throws {
        guard let url = URL(string: "http://172.16.228.193:8000/upload") else {
            print("Invalid URL")
            completion()
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30 // Set a 30-second timeout

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to JPEG data")
            completion()
            return
        }

        var body = Data()

        // Add the person name to the request
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"person\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(personName)\r\n".data(using: .utf8)!)

        // Add the image file to the request
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        print("Sending request to \(url) with image data")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let interpretedResponse = response as? HTTPURLResponse {
                let statusCode = interpretedResponse.statusCode
                if statusCode != 200 {
                    print("Non 200 error code: \(statusCode)")
                } else {
                    print("200 OK")
                }
            }
            
            print("Response data: \(String(data: data, encoding: .utf8) ?? "No response data")")
        } catch {
            print("Error during URLSession data task: \(error.localizedDescription)")
        }
        
        completion()
    }
}
#Preview {
    if #available(iOS 18.0, *) {
        CameraView(showStart: .constant(true))
            .environmentObject(UserStore.example())
    } else {
        // Fallback on earlier versions
    }
}
