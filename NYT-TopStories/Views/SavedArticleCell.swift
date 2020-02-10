//
//  SavedArticleCell.swift
//  NYT-TopStories
//
//  Created by Maitree Bain on 2/10/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

//Step 1: custom protocol
protocol SavedArticleCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article)
}

class SavedArticleCell: UICollectionViewCell {
    
    //Step 2: custom protocol
    weak var delegate: SavedArticleCellDelegate?
    //more button
    //article title
    //news image
    
    private var currentArticle: Article!
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var articleTitle: UILabel = {
         let label = UILabel()
         label.font = UIFont.preferredFont(forTextStyle: .title2)
         label.text = "Article Title"
         return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpMoreButtonConstrains()
        setUpArticleTitleConstraints()
    }
    
    private func setUpMoreButtonConstrains() {
        addSubview(moreButton)
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
    }
    
    private func setUpArticleTitleConstraints() {
        addSubview(articleTitle)
        
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        //Step 3: custom protocol
        //this is what is being communicated
        delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    public func configureCell(for savedArticle: Article) {
        currentArticle = savedArticle
        articleTitle.text = savedArticle.title
    }
    
}
