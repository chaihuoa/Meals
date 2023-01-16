//
//  Meal.swift
//  Meals
//
//  Created by Yongfeng on 1/13/23.
//

import Foundation

struct Meals: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let name: String
    let thumb: String
    let mealId: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case mealId = "idMeal"
    }
}
