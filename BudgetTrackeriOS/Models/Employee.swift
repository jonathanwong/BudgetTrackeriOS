//
//  Employee.swift
//  BudgetTrackeriOS
//
//  Created by Jonathan Wong on 4/16/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import Foundation

class Employee: Codable, CustomStringConvertible {
  
  var id: UUID?
  var firstName: String
  var lastName: String
  
  init(firstName: String,
       lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
  var description: String {
    return "\(String(describing: id)) \(firstName) \(lastName)"
  }
}
