//
//  ViewController.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import UIKit

class HomeViewContorller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        fetchData()
    }
    
    private func fetchData(){
        //        APICaller.shared.getNewReleases { result in
        //            switch result{
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            case .success(let result):
        //                print(result)
        //            }
        //        }
        
        //        APICaller.shared.getFeaturedPlaylist { result in
        //            switch result{
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            case .success(let result):
        //                print(result)
        //            }
        //        }
        
        //        APICaller.shared.getRecommendataion { result in
        //            switch result{
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            case .success(let result):
        //                print(result)
        //            }
        //        }
        
        APICaller.shared.getRecommendedGenres { result in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                let genres = result.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement(){
                        seeds.insert(random)
                    }
                    
                }
                APICaller.shared.getRecommendataion(genres: seeds) { _ in
                    
                }
            }
        }
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

