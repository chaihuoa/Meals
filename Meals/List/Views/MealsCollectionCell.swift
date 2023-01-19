//
//  MealsCollectionCell.swift
//  Meals
//
//  Created by Yongfeng on 1/13/23.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class MealsCollectionCell: UICollectionViewCell {
    private enum Constants {
        static let contentViewCornerRadius: CGFloat = 4.0
        static let imageHeight: CGFloat = 180.0
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 16.0
    }

    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }

    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white

        contentView.addSubview(mealImageView)
        contentView.addSubview(nameLabel)
    }

    private func setupLayouts() {        
        mealImageView.layout {
            $0.leading == contentView.leadingAnchor
            $0.trailing == contentView.trailingAnchor
            $0.top == contentView.topAnchor
            $0.height == Constants.imageHeight
        }
        
        nameLabel.layout {
            $0.leading == contentView.leadingAnchor + Constants.horizontalPadding
            $0.trailing == contentView.trailingAnchor - Constants.horizontalPadding
            $0.top == mealImageView.bottomAnchor + Constants.verticalSpacing
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with meal: Meal) {
        mealImageView.load(meal.thumb)
        nameLabel.text = meal.name
    }
}

extension MealsCollectionCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
