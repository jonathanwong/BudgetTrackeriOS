//
//  BudgetCalculatorTests.swift
//  BudgetTrackeriOSTests
//
//  Created by Jonathan Wong on 7/12/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import XCTest
@testable import BudgetTrackeriOS

class BudgetCalculatorTests: XCTestCase {

  var budgetCalculator: BudgetCalculator!
  
  override func setUp() {
    budgetCalculator = BudgetCalculator()
  }

  override func tearDown() {
    budgetCalculator = nil
  }

  func testCalculateTotal() {
    var trainingViewModels = [TrainingViewModel]()
    trainingViewModels.append(TrainingViewModel(
      training: Training(name: "training1", price: 5), isEnrolled: true))
    trainingViewModels.append(TrainingViewModel(
      training: Training(name: "training2", price: 6), isEnrolled: true))
    trainingViewModels.append(TrainingViewModel(
      training: Training(name: "training3", price: 7), isEnrolled: false))
    
    let result = budgetCalculator.calculateTotal(trainingViewModels: trainingViewModels)
    XCTAssertEqual(result, 11)
  }

}
