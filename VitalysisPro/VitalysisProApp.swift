//
//  VitalysisProApp.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/13/24.
//

import SwiftUI
import SwiftData

@main
struct VitalysisProApp: App {
    @StateObject private var store = userStore(n: "Aadit", s: [Servo(power: 0)], m: [])
    
    /*var sharedModelContainer: ModelContainer = {
           let schema = Schema([
               User.self,
               Servo.self,
               MigraineLog.self
           ])
           let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

           do {
               return try ModelContainer(for: schema, configurations: [modelConfiguration])
           } catch {
               fatalError("Could not create ModelContainer: \(error)")
           }
       }()
     */

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
        
        
       // .modelContainer(sharedModelContainer)
    }
}
struct HoverEffect: ViewModifier {
    @State private var isHovered = false // Track hover state
    let action: () -> Void // Action to perform on hover

    func body(content: Content) -> some View {
        content
            .onHover { hovered in
                isHovered = hovered
                if hovered {
                    action() // Execute action on hover
                }
            }
    }
}

extension View {
    func onHover(perform action: @escaping () -> Void) -> some View {
        modifier(HoverEffect(action: action))
    }
}

struct CustomNavigationStack<Content>: View where Content: View {
    @Binding var currentIndex: Int
    var content: () -> Content
    
    var body: some View {
        ZStack {
            content()
                .zIndex(0)
            
            // Handle transitions between views based on currentIndex
            if currentIndex >= 0 && currentIndex <= 4 {
                PressureMapView(currentIndex: $currentIndex)
                    .zIndex(1)
            } else {
                HomeView(currentIndex: currentIndex)
                    .zIndex(1)
            }
        }
    }
}
