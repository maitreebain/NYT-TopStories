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
    
    private var savedArticles = [Article]() {
        didSet {
            print("there are \(savedArticles.count) articles")
            DispatchQueue.main.async {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        fetchSavedArticles()
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        }catch {
            print("could not load items")
        }
    }

}

//step 5: setting up data persistence and its delegate
//conforming to the DataPersistenceDelegate
extension SavedArticleViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
    
}
