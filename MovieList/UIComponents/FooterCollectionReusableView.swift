//
//  FooterCollectionReusableView.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView,ReusableView {
    static let identifier = "FooterCollectionReusableView"
     let button: UIButton = {
        let button = UIButton()
        button.setTitle("LoadMore", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.clipsToBounds = true
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
    }

}
