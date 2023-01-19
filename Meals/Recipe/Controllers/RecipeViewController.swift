//
//  RecipeViewController.swift
//  Meals
//
//  Created by Yongfeng on 1/15/23.
//

import Foundation
import UIKit

class RecipeViewController: UIViewController {
    private var recipe: Recipe?
    private var mealId: String
    private let viewModel: RecipeViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Life cycle
    
    init(mealId: String, viewModel: RecipeViewModel) {
        self.mealId = mealId
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestRecipeData(with: mealId)
        viewModel.delegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
        guard let recipe = recipe else { return }
        
        let imageView = RecipeHeaderView(imageUrl: recipe.thumb, name: recipe.name, category: recipe.category, source: recipe.region)
        
        let instructionView = InstructionView(recipe.instructions)
        
        let ingredientString = recipe.ingredients.joined(separator: "\n")
        let ingredientView = IngredientView(ingredientString)
        
        let videoView = VideoView()
        videoView.delegate = self
        
        stackView.addArrangedSubviews([imageView, ingredientView, instructionView, videoView])
    }
    
    private func setupLayout() {
        scrollView.constraintsEqualWithSuperview()
        stackView.layout {
            $0.top == scrollView.topAnchor
            $0.bottom == scrollView.bottomAnchor
            $0.leading == scrollView.leadingAnchor
            $0.trailing == scrollView.trailingAnchor
            $0.width == view.bounds.width
        }
    }
}

// MARK: - ViewModel Delegate

extension RecipeViewController: RecipeViewModelDelegate {
    func recipeDataSource(_ dataSource: RecipeViewModel, recipe: Recipe?, error: Error?) {
        if let recipe = recipe {
            self.recipe = recipe
            
            setupViews()
            setupLayout()
        }
        if let error = error {
            print("fetch meals list error: \(error)")
        }
    }
}

// MARK: - VideoView Delegate

extension RecipeViewController: VideoViewDelegate {
    func openVideoFromUrl() {
        guard let recipe = recipe, let url = URL(string: recipe.video) else { return }
        let application = UIApplication.shared
        if application.canOpenURL(url) {
            application.open(url)
        } else {
            // prompt the user video is unavailable
        }
    }
}
