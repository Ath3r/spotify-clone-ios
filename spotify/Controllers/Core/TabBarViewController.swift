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
        
        homeNav.navigationBar.prefersLargeTitles = true
        searchNav.navigationBar.prefersLargeTitles = true
        libraryNav.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNav,searchNav, libraryNav], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
