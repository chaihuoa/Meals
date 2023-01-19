//
//  LayoutProxy.swift
//  Meals
//
//  Created by Yongfeng on 1/17/23.
//

import Foundation
import UIKit

class LayoutProxy {
    lazy var leading  = property(with: view.leadingAnchor)
    lazy var trailing = property(with: view.trailingAnchor)
    lazy var top = property(with: view.topAnchor)
    lazy var bottom = property(with: view.bottomAnchor)
    lazy var width = dimensionProperty(with: view.widthAnchor)
    lazy var height = dimensionProperty(with: view.heightAnchor)

    private let view: UIView

    init(view: UIView) {
       self.view = view
    }
   
    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
       return LayoutProperty(anchor: anchor)
    }
    
    private func dimensionProperty<B: LayoutDimension>(with anchor: B) -> LayoutDimensionProperty<B> {
        return LayoutDimensionProperty(anchor: anchor)
    }
}
