//
//  SearchViewController.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultViewController())
        vc.searchBar.placeholder = "Songs, Artists, Albums"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ ->NSCollectionLayoutSection? in
                //Item
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1))
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing:7)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(150)
                    ),
                    subitem: item,
                    count: 2
                )
                
                group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                return NSCollectionLayoutSection(group: group)
            }))
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}
extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsController = searchController.searchResultsController as? SearchResultViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        //        APICaller.shared
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GenreCollectionViewCell.identifier,
            for: indexPath
        ) as? GenreCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: "Title here")
        return cell
    }
    
    
}
