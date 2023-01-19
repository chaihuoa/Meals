//
//  LayoutDimension.swift
//  Meals
//
//  Created by Yongfeng on 1/18/23.
//

import Foundation
import UIKit

protocol LayoutDimension {
    func constraint(equalToConstant float: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant float: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant float: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutDimension: LayoutDimension {}

struct LayoutDimensionProperty<Anchor: LayoutDimension> {
    let anchor: Anchor
}

extension LayoutDimensionProperty {
    func equal(to constant: CGFloat = 0) {
        anchor.constraint(equalToConstant: constant).isActive = true
    }

    func greaterThanOrEqual(to constant: CGFloat = 0) {
        anchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }

    func lessThanOrEqual(to constant: CGFloat = 0) {
        anchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
}

func ==<B: LayoutDimension>(lhs: LayoutDimensionProperty<B>, rhs: CGFloat) {
    lhs.equal(to: rhs)
}
