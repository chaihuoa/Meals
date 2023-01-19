//
//  RecipeHeaderView.swift
//  Meals
//
//  Created by Yongfeng on 1/17/23.
//

import UIKit

class RecipeHeaderView: UIView {
    private var imageUrl: String
    private var name: String
    private var category: String
    private var source: String
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private enum Constants {
        static let labelHeight: CGFloat = 20.0
        static let imageHeight: CGFloat = 400.0
        static let verticalSpacing: CGFloat = 5.0
        static let horizontalPadding: CGFloat = 16.0
    }
    
    init(imageUrl: String, name: String, category: String, source: String) {
        self.imageUrl = imageUrl
        self.name = name
        self.category = category
        self.source = source
        
        super.init(frame: .zero)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(mealImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        mealImageView.load(imageUrl)
        titleLabel.text = name
        subTitleLabel.text = "\(category) \(source)"
    }
    
    private func setupLayouts() {
        mealImageView.layout {
            $0.leading == leadingAnchor
            $0.trailing == trailingAnchor
            $0.top == topAnchor
            $0.height == Constants.imageHeight
            $0.bottom == bottomAnchor
        }
        
        titleLabel.layout {
            $0.leading == leadingAnchor + Constants.horizontalPadding
            $0.trailing == trailingAnchor - Constants.horizontalPadding
            $0.height == Constants.labelHeight
            $0.bottom == subTitleLabel.topAnchor - Constants.verticalSpacing
        }
        
        subTitleLabel.layout {
            $0.leading == leadingAnchor + Constants.horizontalPadding
            $0.trailing == trailingAnchor - Constants.horizontalPadding
            $0.height == Constants.labelHeight
            $0.bottom == mealImageView.bottomAnchor - (Constants.verticalSpacing * 2)
        }
    }
}
