//
//  VideoView.swift
//  Meals
//
//  Created by Yongfeng on 1/18/23.
//

import UIKit

protocol VideoViewDelegate: AnyObject {
    func openVideoFromUrl()
}

class VideoView: UIView {
    
    weak var delegate: VideoViewDelegate?
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Watch Video", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .systemRed
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        button.addTarget(self, action: #selector(clickWatchVideoButton), for: .touchUpInside)
        addSubview(button)
    }
    
    private func setupLayout() {
        button.layout {
            $0.top == topAnchor + 30
            $0.leading == leadingAnchor + 30
            $0.trailing == trailingAnchor - 30
            $0.height == 50
            $0.bottom == bottomAnchor - 40
        }
    }
    
    @objc func clickWatchVideoButton() {
        delegate?.openVideoFromUrl()
    }
}
