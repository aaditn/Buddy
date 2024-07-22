//
//  MigraineLog.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/13/24.
//

import Foundation
import SwiftData


@Model
final class MigraineLog {
  @Attribute(.unique) var id = UUID()
  var date: Date
  var severity: Int
  // No relationship attribute needed

  init(date: Date, severity: Int) {
    self.date = date
    self.severity = severity
  }
}
