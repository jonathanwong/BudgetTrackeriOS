//
//  Manager.swift
//  BudgetTrackeriOS
//
//  Created by Jonathan Wong on 6/1/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import Foundation

class Manager: Employee {
  let budget: Int
  
  init(firstName: String,
       lastName: String,
       budget: Int) {
    self.budget = budget
    super.init(firstName: firstName,
               lastName: lastName)
  }
  
  private enum CodingKeys: Int, CodingKey {
   case budget
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.budget = try container.decode(Int.self, forKey: .budget)
    try super.init(from: decoder)
  }
  
}

