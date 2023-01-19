//
//  MealsService.swift
//  Meals
//
//  Created by Yongfeng on 1/13/23.
//

import Foundation

enum Endpoint: API {
    case getMealsList(category: String)
    case getRecipe(mealId: String)
    
    var baseURL: String {
        return "themealdb.com"
    }
    
    var path: String {
        switch self {
        case .getMealsList:
            return "/api/json/v1/1/filter.php"
        case .getRecipe:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMealsList:
            return .GET
        case .getRecipe:
            return .GET
        }
    }
    
    var params: [URLQueryItem]? {
        switch self {
        case .getMealsList(let category):
            return [URLQueryItem(name: "c", value: category)]
        case .getRecipe(let mealId):
            return [URLQueryItem(name: "i", value: mealId)]
        }
    }
}
