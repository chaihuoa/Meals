//
//  Recipe.swift
//  Meals
//
//  Created by Yongfeng on 1/15/23.
//

import Foundation

struct Recipes: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable {
    let mealId: String
    let name: String
    let thumb: String
    let video: String
    let category: String
    let region: String
    let instructions: String
    var ingredients: [String]
    
    private enum CodingKeys: String, CodingKey {
        case mealId = "idMeal"
        case name = "strMeal"
        case thumb = "strMealThumb"
        case video = "strYoutube"
        case category = "strCategory"
        case region = "strArea"
        case instructions = "strInstructions"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measurement1 = "strMeasure1"
        case measurement2 = "strMeasure2"
        case measurement3 = "strMeasure3"
        case measurement4 = "strMeasure4"
        case measurement5 = "strMeasure5"
        case measurement6 = "strMeasure6"
        case measurement7 = "strMeasure7"
        case measurement8 = "strMeasure8"
        case measurement9 = "strMeasure9"
        case measurement10 = "strMeasure10"
        case measurement11 = "strMeasure11"
        case measurement12 = "strMeasure12"
        case measurement13 = "strMeasure13"
        case measurement14 = "strMeasure14"
        case measurement15 = "strMeasure15"
        case measurement16 = "strMeasure16"
        case measurement17 = "strMeasure17"
        case measurement18 = "strMeasure18"
        case measurement19 = "strMeasure19"
        case measurement20 = "strMeasure20"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.mealId = try values.decode(String.self, forKey: .mealId)
        self.name = try values.decode(String.self, forKey: .name)
        self.thumb = try values.decode(String.self, forKey: .thumb)
        self.video = try values.decode(String.self, forKey: .video)
        self.category = try values.decode(String.self, forKey: .category)
        self.region = try values.decode(String.self, forKey: .region)
        self.instructions = try values.decode(String.self, forKey: .instructions)
        
        self.ingredients = []
        
        try (1...20).forEach { index in
            let ingredientRawValue = "strIngredient\(index)"
            let measurementRawValue = "strMeasure\(index)"
            
            if let ingredientKey = CodingKeys(rawValue: ingredientRawValue), let measurementKey = CodingKeys(rawValue: measurementRawValue) {
                let ingredient = try values.decodeIfPresent(String.self, forKey: ingredientKey)
                let measurement = try values.decodeIfPresent(String.self, forKey: measurementKey)
                
                if let ingredient = ingredient, let measurement = measurement, !ingredient.isEmpty, !measurement.isEmpty {
                    self.ingredients.append("\(measurement) - \(ingredient)")
                }
            }
        }
    }
}
