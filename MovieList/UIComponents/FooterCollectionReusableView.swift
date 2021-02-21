//
//  FooterCollectionReusableView.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit
protocol HideHeaderViewDelegate {
    func hideHeaderView()
}
class FooterCollectionReusableView: UICollectionReusableView {
    var delegate: HideHeaderViewDelegate?

    static let identifier = "FooterCollectionReusableView"
     let button: UIButton = {
        let button = UIButton()
        button.setTitle("LoadMore", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loadMore), for: .touchUpInside)
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
    @objc func loadMore(){
        guard let delegate = delegate else { return }
        delegate.hideHeaderView()

    }

}
