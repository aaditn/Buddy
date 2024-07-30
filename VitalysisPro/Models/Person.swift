//
//  MigraineLog.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/13/24.
//

import Foundation
import SwiftUI

class Person: Identifiable {
    var id = UUID()
    var fName: String
    var lName: String
    var tag: String
    var isFavorite: Bool
    var img: Image
    var trainingData: [Image]
    var pattern: Pattern

    func circleImg(size: Int, x: Bool) -> some View {
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
                    if x {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color("secondary"))
                            .offset(x: CGFloat(Double(size) * 0.3), y: CGFloat(Double(size) * 0.4))
                    }
                }
            )
            .frame(width: CGFloat(size), height: CGFloat(size))
    }

    

    init(fName: String, lName: String, tag: String, isFavorite: Bool, img: Image, pattern: Pattern, trainingData: [Image]) {
        self.fName = fName
        self.lName = lName
        self.tag = tag
        self.isFavorite = isFavorite
        self.img = img
        self.pattern = pattern
        self.trainingData = trainingData
    }
    func name() -> String {
        return ("\(fName) \(lName)")
    }
}
