//
//  ArticleDetailViewController.swift
//  NYT-TopStories
//
//  Created by Maitree Bain on 2/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class ArticleDetailViewController: UIViewController {
    
    let articleDV = ArticleDetailView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    override func loadView() {
        view = articleDV
    }
    
    public var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        updateUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }

    private func updateUI() {
        //TODO: Refactor and set up in Article Detail View
        //e.g articleDV.configureView(for article: article)
        guard let article = article else {
            fatalError("did not laod an article")
        }
        
        navigationItem.title = article.title
        
        articleDV.abstractLabel.text = article.abstract
        articleDV.newsImageView.getImage(with: article.getArticleImageUrl(for: .superJumbo)) { [weak self](result) in
            
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.articleDV.newsImageView.image = UIImage(systemName: "exclamationmark-octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.articleDV.newsImageView.image = image
                }
            }
        }
        
    }
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        sender.image = UIImage(systemName: "bookmark.fill")
        print("save article button test")
        
        sender.isEnabled = false
    }
}
