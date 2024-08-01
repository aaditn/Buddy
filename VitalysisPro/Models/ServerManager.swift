import Foundation
import SwiftUI
import Swifter

class ServerManager: ObservableObject {
    private var server: HttpServer?
    private var user: UserStore // Reference to UserStore

    // Initialize with UserStore
    init(user: UserStore) {
        self.user = user
        startServer()
    }

    deinit {
        stopServer()
    }

    func startServer() {
        server = HttpServer()
        server?.POST["/newEncounter"] = { [weak self] request in
            guard let self = self else { return .internalServerError }
            let body = request.body
            do {
                let json = try JSONDecoder().decode([String: String].self, from: Data(body))
                if let name = json["name"] {
                    // Handle the incoming name
                    print("Received name: \(name)")
                    if name == "Unknown" {
                        let unknownPerson = Person(fName: "Unknown", lName: "", tag: "00001", isFavorite: false, img: Image("exampleDude"), pattern: Pattern.oneTap())
                        print ("hehe")
                        DispatchQueue.main.async {
                            self.user.encounters.append(Encounter(date: Date(), person: unknownPerson))
                        }
                    } else {
                        if let match = self.user.people.first(where: { $0.fName + $0.lName == name }) {
                            DispatchQueue.main.async {
                                self.user.encounters.append(Encounter(date: Date(), person: match))
                            }
                        } else {
                            print("No match found for \(name)")
                        }
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
            return .ok(.text("Encounter added"))
        }

        do {
            try server?.start(8080)
            print("Server started on port 8080")
        } catch {
            print("Failed to start server: \(error)")
        }
    }

    func stopServer() {
        server?.stop()
        server = nil
        print("Server stopped")
    }
}
