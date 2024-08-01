import Foundation
import SwiftUI

// MARK: - Pattern Model
class Pattern: Identifiable, Decodable {
    var id = UUID() // Unique identifier for each pattern
    let timestamps: [Double]
    let length: Double

    // Initializer
    init(timestamps: [Double], length: Double) {
        self.timestamps = timestamps
        self.length = length
    }

    // Static methods to create common patterns
    static func oneTap() -> Pattern {
        return Pattern(timestamps: [0], length: 1)
    }

    static func twoTap() -> Pattern {
        return Pattern(timestamps: [0, 0.2], length: 1)
    }

    // Decodable initializer
    enum CodingKeys: String, CodingKey {
        case timestamps
        case length
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        timestamps = try container.decode([Double].self, forKey: .timestamps)
        length = try container.decode(Double.self, forKey: .length)
    }
}
