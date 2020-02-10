//
//  SavedArticleViewController.swift
//  NYT-TopStories
//
//  Created by Maitree Bain on 2/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticleViewController: UIViewController {
    
    //step 4: setting up data persistence and its delegate
    public var dataPersistence: DataPersistence<Article>!
    
    //TODO: create a SavedArticleView
    //TODO: add a collection view to the SAV - vertical with 2 cells
    //TODO: add SAView to the SAVController
    //TODO: create an array of savedArticle = [Article]
    //TODO: reload collection view in didSave of DPDelegate /(reload collection view in didSet of savedArticles)
    
    let savedArticlesView = SavedArticleView()
    
    private var savedArticles = [Article]() {
        didSet {
            savedArticlesView.collectionView.reloadData()
            if savedArticles.isEmpty {
                //setup our empty view on the collection view background
                savedArticlesView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles. Start browsing by tapping on the News icon.")
            } else {
                savedArticlesView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        fetchSavedArticles()
        savedArticlesView.collectionView.delegate = self
        savedArticlesView.collectionView.dataSource = self
        
        //register
        savedArticlesView.collectionView.register(SavedArticleCell.self, forCellWithReuseIdentifier: "savedArticleCell")
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        }catch {
            print("could not load items")
        }
    }
    
}

extension SavedArticleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedArticleCell", for: indexPath) as? SavedArticleCell else {
            fatalError("could not downcast to SavedArticleCell")
        }
        cell.backgroundColor = .white
        let selectedItem = savedArticles[indexPath.row]
        
        cell.configureCell(for: selectedItem)
        //Step 1: registering as the delegate object
        cell.delegate = self
        return cell
    }
    
}

extension SavedArticleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let itemHeight: CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

//step 5: setting up data persistence and its delegate
//conforming to the DataPersistenceDelegate
extension SavedArticleViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        fetchSavedArticles()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
    
    
}

//Step 2: registering as the delegate object
extension SavedArticleViewController: SavedArticleCellDelegate {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article) {
        print("didSelectMoreButton: \(article.title)")
        
        //create an action sheet
        //cancel action
        //delete action
        //post MVP shareAction
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (alertAction) in
//            dataPersistence.deleteItem(at: <#T##Int#>)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    
}
