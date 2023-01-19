//
//  EndpointTests.swift
//  MealsTests
//
//  Created by Yongfeng on 1/18/23.
//

import XCTest
@testable import Meals

final class EndpointTests: XCTestCase {

    let listEndpoint = Endpoint.getMealsList(category: "dessert")
    let recipeEndpoint = Endpoint.getRecipe(mealId: "52768")
    
    func test_ListEndpoint() {
        XCTAssertTrue(listEndpoint.baseURL == "themealdb.com")
        XCTAssertTrue(listEndpoint.path == "/api/json/v1/1/filter.php")
        XCTAssertTrue(listEndpoint.method == .GET)
        XCTAssertTrue(listEndpoint.params == [URLQueryItem(name: "c", value: "dessert")])
    }
    
    func test_RecipeEndpoint() {
        XCTAssertTrue(recipeEndpoint.baseURL == "themealdb.com")
        XCTAssertTrue(recipeEndpoint.path == "/api/json/v1/1/lookup.php")
        XCTAssertTrue(recipeEndpoint.method == .GET)
        XCTAssertTrue(recipeEndpoint.params == [URLQueryItem(name: "i", value: "52768")])
    }

}
