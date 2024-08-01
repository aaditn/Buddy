import Foundation
import SwiftUI

class UserStore: ObservableObject {
    @Published var name: String
    @Published var img: Image
    @Published var people: [Person]
    @Published var encounters: [Encounter]
    
    init(name: String, img: Image, people: [Person], encounters: [Encounter]) {
        self.name = name
        self.img = img
        self.people = people
        self.encounters = encounters
    }
    
    static func example() -> UserStore {
        let person1 = Person(fName: "Aadharsh", lName: "Rajkumar", tag: "00001", isFavorite: false, img: Image("exampleDude"), pattern: Pattern.oneTap())
        let person2 = Person(fName: "Paige", lName: "Shugart", tag: "00002", isFavorite: false, img: Image("exampleDude"), pattern: Pattern.oneTap())
        let person3 = Person(fName: "Aadit", lName: "Noronha", tag: "00003", isFavorite: false, img: Image("exampleDude"), pattern: Pattern.twoTap())

        let calendar = Calendar.current
        let now = Date()
        let oneWeekAgo = calendar.date(byAdding: .weekOfYear, value: -1, to: now)!
        let fourMonthsAgo = calendar.date(byAdding: .month, value: -4, to: now)!
        let twoHoursAgo = calendar.date(byAdding: .hour, value: -2, to: now)!
        
        let encounter1 = Encounter(date: oneWeekAgo, person: person1)
        let encounter2 = Encounter(date: fourMonthsAgo, person: person2)
        let encounter3 = Encounter(date: twoHoursAgo, person: person3)
        
        return UserStore(name: "Matt Lussier", img: Image("exampleDude"), people: [person1, person2, person3], encounters: [encounter1, encounter2, encounter3])
    }
    
    func addOrUpdateUser(with images: [UIImage]) {
        if let existingUser = people.first(where: { $0.tag == "0001" }) {
            // Update logic if needed
        } else {
            let newUser = Person(
                fName: "Aadit",
                lName: "Noronha",
                tag: "0001",
                isFavorite: false,
                img: Image(uiImage: images.first!),
                pattern: Pattern.oneTap()
            )
            people.append(newUser)
        }
    }

    func getFirstUser() -> Person? {
        return people.first
    }
}

struct GetProfile: View {
    @EnvironmentObject var user: UserStore
    var size: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.2))
            
            user.img
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: CGFloat(size), height: CGFloat(size))
                .clipShape(Circle())
        }
        .frame(width: CGFloat(size), height: CGFloat(size))
    }
}
