//
//  RecipeViewModel.swift
//  Meals
//
//  Created by Yongfeng on 1/15/23.
//

import Foundation

protocol RecipeViewModelDelegate: AnyObject {
    func recipeDataSource(_ dataSource: RecipeViewModel, recipe: Recipe?, error: Error?)
}

class RecipeViewModel {
    weak var delegate: RecipeViewModelDelegate?
    
    func requestRecipeData(with mealId: String) {
        let endpoint = Endpoint.getRecipe(mealId: mealId)
        NetworkManager.request(endpoint: endpoint) { [weak self] (result: Result<Recipes, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.delegate?.recipeDataSource(self, recipe: response.meals.first, error: nil)
                case .failure(let error):
                    self.delegate?.recipeDataSource(self, recipe: nil, error: error)
                }
            }
        }
    }
}
