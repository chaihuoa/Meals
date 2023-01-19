//
//  RecipeViewModelTests.swift
//  MealsTests
//
//  Created by Yongfeng on 1/18/23.
//

import XCTest
@testable import Meals

final class RecipeViewModelTests: XCTestCase {

    func test_requestGetRecipe_shouldReturnValidData() {
        let endpoint = Endpoint.getRecipe(mealId: "52768")

        let expectation = self.expectation(description: "Request should complete")

        NetworkManager.request(endpoint: endpoint) { (result: Result<Recipes, Error>) in
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
