//
//  MealsListViewController.swift
//  Meals
//
//  Created by Yongfeng on 1/13/23.
//

import Foundation
import UIKit

class MealsListViewController: UIViewController {
    private let viewModel = MealsListViewModel()
    private var meals: [Meal] = []
    private var category: String
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 250.0
    }
    
    // MARK: - Life cycle
    
    init(_ category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestMealsListData(with: category)
        viewModel.delegate = self
        
        setupViews()
        setupLayouts()
        collectionView.reloadData()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Dessert"
        
        view.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MealsCollectionCell.self, forCellWithReuseIdentifier: MealsCollectionCell.identifier)
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

// MARK: - ViewModel Delegate

extension MealsListViewController: MealsListViewModelDelegate {
    func mealsListDataSource(_ dataSource: MealsListViewModel, meals: Meals?, error: Error?) {
        if let meals = meals {
            self.meals = meals.meals.sorted { $0.name.lowercased() < $1.name.lowercased() }
            self.collectionView.reloadData()
        }
        if let error = error {
            print("fetch meals list error: \(error)")
        }
    }
}

// MARK: - Collection DataSource

extension MealsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealsCollectionCell.identifier, for: indexPath) as! MealsCollectionCell

        let meal = meals[indexPath.row]
        cell.setup(with: meal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        navigateToRecipeViewController(meal.mealId)
    }
    
    private func navigateToRecipeViewController(_ mealId: String) {
        let recipeViewController = RecipeViewController(mealId: mealId)
        present(recipeViewController, animated: true)
    }
}

// MARK: - Collection FlowLayout

extension MealsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)

        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return floor(finalWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}

