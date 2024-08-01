//
//  MigraineLog.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/13/24.
//

import Foundation
import SwiftUI

// MARK: - Person Model
class Person: Identifiable, Decodable {
    var id = UUID()
    var fName: String
    var lName: String
    var tag: String
    var isFavorite: Bool
    var img: Image // Assuming this is populated elsewhere in your app
    var pattern: Pattern

    // Coding keys for decoding
    enum CodingKeys: String, CodingKey {
        case id
        case fName
        case lName
        case tag
        case isFavorite
        case pattern
    }

    // Initializer for Decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        fName = try container.decode(String.self, forKey: .fName)
        lName = try container.decode(String.self, forKey: .lName)
        tag = try container.decode(String.self, forKey: .tag)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        pattern = try container.decode(Pattern.self, forKey: .pattern)
        
        // Note: The img property is not decoded here as it is populated elsewhere
        img = Image("exampleDude") // Placeholder or default image, adjust as needed
    }

    // Function to create a circular image view with optional heart overlay
    func circleImg(size: Int, showHeart: Bool) -> some View {
        Circle()
            .fill(Color("secondary").opacity(0.3))
            .overlay(
                img
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: CGFloat(size), height: CGFloat(size))
                    .clipShape(Circle())
            )
            .overlay(
                Group {
                    if showHeart {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color("secondary"))
                            .offset(x: CGFloat(Double(size) * 0.3), y: CGFloat(Double(size) * 0.4))
                    }
                }
            )
            .frame(width: CGFloat(size), height: CGFloat(size))
    }

    // Initializer
    init(fName: String, lName: String, tag: String, isFavorite: Bool, img: Image, pattern: Pattern) {
        self.fName = fName
        self.lName = lName
        self.tag = tag
        self.isFavorite = isFavorite
        self.img = img
        self.pattern = pattern
    }

    // Function to return the full name of the person
    func name() -> String {
        return "\(fName) \(lName)"
    }
}

