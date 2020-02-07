//
//  TopStoriesTabController.swift
//  NYT-TopStories
//
//  Created by Maitree Bain on 2/6/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class TopStoriesTabController: UITabBarController {
    
    private lazy var newsFeedVC: NewsFeedViewController = {
    let viewController = NewsFeedViewController()
    viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
    return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticleViewController = {
    let viewController = SavedArticleViewController()
    viewController.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "folder"), tag: 1)
    return viewController
    }()
    
    private lazy var settingsVC: SettingsViewController = {
    let viewController = SettingsViewController()
    viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
    return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        viewControllers = [UINavigationController(rootViewController: newsFeedVC), UINavigationController(rootViewController: savedArticlesVC), UINavigationController(rootViewController: settingsVC)]
    }

}
