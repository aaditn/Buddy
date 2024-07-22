import Foundation

class userStore: ObservableObject {
    @Published var name: String
    @Published var servos: [Servo]
    @Published var migraineLogs: [MigraineLog]
    
    init(n: String, s: [Servo], m: [MigraineLog]) {
        name = n
        servos = s
        migraineLogs = m
    }
    
    func example() -> userStore {
        return userStore(n: "Aadit", s: [Servo(power: 0)], m: [])
    }
    
    func setAll(n: String, s: [Servo], m: [MigraineLog]) {
        name = n
        servos = s
        migraineLogs = m
    }
}
