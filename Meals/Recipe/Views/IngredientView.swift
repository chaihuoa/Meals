//
//  Ingredients.swift
//  Meals
//
//  Created by Yongfeng on 1/17/23.
//

import UIKit

class IngredientView: UIView {
    private var ingredientString: String
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "Ingredients"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private enum Constants {
        static let titleLabelHeight: CGFloat = 35.0
        static let verticalSpacing: CGFloat = 10.0
        static let horizontalPadding: CGFloat = 16.0
    }
    
    init(_ ingredientString: String) {
        self.ingredientString = ingredientString
        super.init(frame: .zero)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        contentLabel.text = ingredientString
    }
    
    private func setupLayout() {
        titleLabel.layout{
            $0.top == topAnchor + Constants.verticalSpacing
            $0.leading == leadingAnchor + Constants.horizontalPadding
            $0.trailing == trailingAnchor - Constants.horizontalPadding
            $0.height == Constants.titleLabelHeight
        }
        
        contentLabel.layout{
            $0.top == titleLabel.bottomAnchor + Constants.verticalSpacing
            $0.leading == leadingAnchor + Constants.horizontalPadding
            $0.trailing == trailingAnchor - Constants.horizontalPadding
            $0.bottom == bottomAnchor
        }
    }
}
