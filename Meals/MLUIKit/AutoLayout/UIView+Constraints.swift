//
//  UIView+Constraints.swift
//  Meals
//
//  Created by Yongfeng on 1/17/23.
//

import UIKit

extension UIView {
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }

    func constraintsEqualWithSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[self]|", options: [], metrics: nil, views: ["self": self]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[self]|", options: [], metrics: nil, views: ["self": self]))
    }
}
