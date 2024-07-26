//
//  VitalysisProApp.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/13/24.
//

import SwiftUI
import SwiftData

@available(iOS 18.0, *)
@main
struct VitalysisProApp: App {
    private var store = UserStore.example()
    
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
    
    
    // "4:44 PM on June 23, 2016\n"
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

@available(iOS 18.0, *)
struct CustomNavigationStack<Content>: View where Content: View {
    @Binding var currentIndex: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack {
            content()
                .zIndex(0)
            
            // Handle transitions between views based on currentIndex
            if currentIndex == true {
                HomeView()
                    .zIndex(1)
            } else {
                HomeView()
                    .zIndex(1)
            }
        }
    }
}
