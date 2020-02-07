//
//  NewsFeedViewController.swift
//  NYT-TopStories
//
//  Created by Maitree Bain on 2/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private let newsFeedView = NewsFeedView()
    
    //data for our collection view
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = newsFeedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        newsFeedView.collectionView.delegate = self
        newsFeedView.collectionView.dataSource = self
        
        //register a collection view cell
        newsFeedView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        fetchStories()
    }
    
    private func fetchStories(for section: String = "Technology") {
        NYTTopStoriesAPIClient.fetchTopStories(for: section) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("no data found: \(appError)")
            case .success(let articles):
                self?.newsArticles = articles
            }
        }
    }
}

extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    
    //return item size
    //itemHeight ~ 30% of height of device
    //itemWidth = 100% of width of device
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.4
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        let articleDetailVC = ArticleDetailViewController()
        //TODO: after assessment we will be using initializers as dependency injection mechanisms
        
        articleDetailVC.article = article
        navigationController?.pushViewController(articleDetailVC, animated: true)
    }
    
}

extension NewsFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? NewsCell else {
            fatalError("could not downcast to NewsCell")
        }
        let selectedArticle = newsArticles[indexPath.row]
        
        cell.configureCell(with: selectedArticle)
        return cell
    }
    
}
