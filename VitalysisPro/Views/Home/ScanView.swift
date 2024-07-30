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
                if !images.isEmpty {
                    let circularImages = images.map { circularImage(from: $0) }
                    
                    // Check if the user already exists
                    if let existingUser = user.people.first(where: { $0.tag == "0001" }) {
                        // Append images to the existing user's training data
                        existingUser.trainingData.append(contentsOf: circularImages.map { Image(uiImage: $0) })
                        createTextFile()
                    } else {
                        // Create a new user if it doesn't exist
                        let newUser = Person(
                            fName: "Aadit",
                            lName: "Noronha",
                            tag: "0001", // Use a fixed tag for the single user
                            isFavorite: false,
                            img: Image(uiImage: circularImages.first!), // Use the first image as the main image
                            pattern: Pattern.oneTap(),
                            trainingData: circularImages.map { Image(uiImage: $0) }
                        )
                        user.people.append(newUser)
                        createUserFolder(for: newUser) // Create a folder for the new user
                        createTextFile()
                    }

                    log = user.people.first! // Update log to the first user
                    playSuccess = true
                    withAnimation(.linear(duration: 1)) {
                        animateSuccessOpacity = 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showSettings = true
                    }
                }
            }
        }
    }

    private func startBlinkingAnimation() {
        if text.isEmpty {
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
        cameraManager.startBurstCapture()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            cameraManager.stopBurstCapture()
        }
    }

    private func circularImage(from image: UIImage) -> UIImage {
        let size = min(image.size.width, image.size.height)
        let squareRect = CGRect(x: (image.size.width - size) / 2, y: (image.size.height - size) / 2, width: size, height: size)

        guard let croppedCGImage = image.cgImage?.cropping(to: squareRect) else {
            return image
        }
        return UIImage(cgImage: croppedCGImage)
    }

    private func createUserFolder(for user: Person) {
        let userFolderName = "\(user.fName)\(user.lName)"
        let url = URL(string: "http://127.20.10.6:5000/create_folder")! // Replace with your Raspberry Pi's IP
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["folder_name": userFolderName]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error creating folder: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Folder created successfully: \(userFolderName)")
            } else {
                print("Unexpected response")
            }
        }.resume()
    }

    private func createTextFile() {
        let url = URL(string: "http://127.20.10.6:5000/create_file")! // Replace with your Raspberry Pi's IP
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let content = "User created on \(Date())"
        let body: [String: Any] = ["file_name": "user_created.txt", "content": content]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error creating text file: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Text file created successfully")
            } else {
                print("Unexpected response")
            }
        }.resume()
    }
}

#Preview {
    if #available(iOS 18.0, *) {
        ScanView()
            .environmentObject(UserStore.example())
    } else {
        // Fallback on earlier versions
    }
}
