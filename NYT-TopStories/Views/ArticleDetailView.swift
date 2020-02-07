//
//  ArticleDetailView.swift
//  NYT-TopStories
//
//  Created by Maitree Bain on 2/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit


class ArticleDetailView: UIView {
    
    public lazy var newsImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    public lazy var abstractLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Abstract"
        return label
    }()
    
    public lazy var byLineLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpImageViewConstraints()
        setUpAbstractLabelConstraints()
    }
    
    
    
    private func setUpImageViewConstraints() {
        addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40)
        ])
    }
    
    private func setUpAbstractLabelConstraints() {
        addSubview(abstractLabel)
        
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abstractLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            abstractLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            abstractLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
//    private func setUpbyLineConstraints() {
//        addSubview(byLineLabel)
//
//        byLineLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            byLineLabel.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>, constant: <#T##CGFloat#>)
//        ])
//}
    
}

