//
//  Log.swift
//  Buddy
//
//  Created by Aadit Noronha on 7/24/24.
//

import Foundation

class Encounter: Identifiable {
    var id = UUID()
    var date: Date
    var person: Person
    
    init(date: Date, person: Person) {
        self.date = date
        self.person = person
    }
    
}
