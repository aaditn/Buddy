import Foundation

// MARK: - Encounter Model
class Encounter: Identifiable, Decodable {
    var id = UUID()
    var date: Date
    var person: Person

    // Initializer
    init(date: Date, person: Person) {
        self.date = date
        self.person = person
    }

    // Coding keys for decoding
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case person
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        date = try container.decode(Date.self, forKey: .date)
        person = try container.decode(Person.self, forKey: .person)
    }
}
