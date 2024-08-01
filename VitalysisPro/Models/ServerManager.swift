import Foundation
import SwiftUI
import Swifter

class ServerManager: ObservableObject {
    private var server: HttpServer?
    @ObservedObject private var user: UserStore

    // Initialize with UserStore
    init(user: UserStore) {
        self.user = user
        startServer()
    }

    deinit {
        stopServer()
    }

    func startServer() {
        print("User list: \(user.people.count)")
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
                        print("Adding unknown person")
                        DispatchQueue.main.async {
                            self.user.encounters.append(Encounter(date: Date(), person: unknownPerson))
                        }
                    } else {
                        var matchFound = false

                        for person in self.user.people {
                            print("\(person.fName)\(person.lName)")
                            print(name)
                            if ("\(person.fName)\(person.lName)") == name {
                                DispatchQueue.main.async {
                                    self.user.encounters.append(Encounter(date: Date(), person: person))
                                }
                                matchFound = true
                                break // Exit the loop once a match is found
                            }
                        }

                        if !matchFound {
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
