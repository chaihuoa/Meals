//
//  UIStackView+Extension.swift
//  Meals
//
//  Created by Yongfeng on 1/17/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView?]) {
        views.compactMap({ $0 }).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }
}
