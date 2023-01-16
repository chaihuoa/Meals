//
//  MealsListViewModel.swift
//  Meals
//
//  Created by Yongfeng on 1/13/23.
//

import Foundation

protocol MealsListViewModelDelegate: AnyObject {
    func mealsListDataSource(_ dataSource: MealsListViewModel, meals: Meals?, error: Error?)
}

class MealsListViewModel {
    weak var delegate: MealsListViewModelDelegate?
    
    func requestMealsListData() {
        let endpoint = Endpoint.getListMeals(category: "Dessert")
        NetworkManager.request(endpoint: endpoint) { [weak self] (result: Result<Meals, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.delegate?.mealsListDataSource(self, meals: response, error: nil)
                case .failure(let error):
                    self.delegate?.mealsListDataSource(self, meals: nil, error: error)
                }
            }
        }
    }
}
