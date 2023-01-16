//
//  MealsService.swift
//  Meals
//
//  Created by Yongfeng on 1/13/23.
//

import Foundation

enum Endpoint: API {
    case getListMeals(category: String)
    case getMealDetail(mealId: String)
    
    var baseURL: String {
        return "themealdb.com"
    }
    
    var path: String {
        switch self {
        case .getListMeals:
            return "/api/json/v1/1/filter.php"
        case .getMealDetail:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getListMeals:
            return .GET
        case .getMealDetail:
            return .GET
        }
    }
    
    var params: [URLQueryItem]? {
        switch self {
        case .getListMeals(let category):
            return [URLQueryItem(name: "c", value: category)]
        case .getMealDetail(let mealId):
            return [URLQueryItem(name: "i", value: mealId)]
        }
    }
}
