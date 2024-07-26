//
//  CameraView.swift
//  Buddy
//
//  Created by Aadit Noronha on 7/25/24.
//


import SwiftUI

struct CameraView: View {
    @ObservedObject var cameraManager = CameraManager()
    @Binding var showStart: Bool
    @State var showAccessibility: Bool = false
    @State var text: String = ""
    @State var opacity: Double = 0
    
    @State var showSettings: Bool = false
    
    @State var log: Person = UserStore.example().people.first!
    
    @EnvironmentObject var user: UserStore
    
    @State var playSuccess: Bool = false
    @State var animateSuccessOpacity: Double = 0
    
    @State var hide: Bool = false

    var body: some View {
        if (showSettings) {
            PeopleSettingsView(log: log, goTabAfter: true)
        } else {
            ZStack {
                if (hide) {
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
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 5)
                                .foregroundStyle(Color.black.opacity(0.2))
                                .frame(width: 313)
                                .overlay(
                                    Text(text)
                                        .opacity(opacity)
                                        .animation(.easeInOut(duration: 0.5), value: opacity)
                                        .font(.system(size: 70, weight: .thin))
                                        .foregroundStyle(Color.white.opacity(0.8))
                                )
                        )
                }
                

                VStack {
                    HStack {
                        Button(action:{
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
                    }){
                        ZStack {
                            Circle()
                                .fill(Color.gray)
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .foregroundStyle(Color("fg"))
                        } .frame(width: 80)
                    }

                    if (playSuccess) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .opacity(animateSuccessOpacity)
                        Text("FaceScan is now complete.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(Color("fg"))
                    }
                    
                    Button(action:{
                        showAccessibility = true
                    }) {
                        Text("Accessibility Options")
                            .font(.system(size: 18, weight: .medium))
                    }.padding(.top, 60)
                }.offset(y: playSuccess ? 30 : 0)
            }
            .onChange(of: text) { newValue in
                if newValue.isEmpty {
                    cameraManager.capturePhoto()
                }
            }
            .onReceive(cameraManager.$capturedImage) { image in
                if let image = image {
                    user.people.append(Person(fName: "", lName: "", tag: "0000\(user.people.count + 1)", isFavorite: false, img: Image(uiImage: image), pattern: Pattern.oneTap()))
                    
                    log = user.people.last!
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                text = "3"
            }
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
            }
        }
    }
}
