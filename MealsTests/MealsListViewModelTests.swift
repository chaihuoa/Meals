//
//  MealsListViewModelTests.swift
//  MealsTests
//
//  Created by Yongfeng on 1/18/23.
//

import XCTest
@testable import Meals

final class MealsListViewModelTests: XCTestCase {

    func test_requestGetMealsList_shouldReturnValidData() {
        let endpoint = Endpoint.getMealsList(category: "dessert")

        let expectation = self.expectation(description: "Request should complete")

        NetworkManager.request(endpoint: endpoint) { (result: Result<Meals, Error>) in
            switch result {
            case .success(let data):
                let meals = data.meals
                XCTAssertTrue(meals.count > 0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request should not fail with error: \(error)")
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
