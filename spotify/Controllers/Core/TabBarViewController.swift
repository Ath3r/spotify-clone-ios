//
//  TabBarViewController.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = HomeViewContorller()
        let search = SearchViewController()
        let library = LibraryViewController()
        
        home.title = "Home"
        search.title = "Search"
        library.title = "Library"
        
        home.navigationItem.largeTitleDisplayMode = .always
        search.navigationItem.largeTitleDisplayMode = .always
        library.navigationItem.largeTitleDisplayMode = .always
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        library.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        let homeNav = UINavigationController(rootViewController: home)
        let searchNav = UINavigationController(rootViewController: search)
        let libraryNav = UINavigationController(rootViewController: library)
        
        homeNav.navigationBar.tintColor = .label
        searchNav.navigationBar.tintColor = .label
        libraryNav.navigationBar.tintColor = .label
        
        homeNav.navigationBar.prefersLargeTitles = true
        searchNav.navigationBar.prefersLargeTitles = true
        libraryNav.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNav,searchNav, libraryNav], animated: false)
    }
    


}
