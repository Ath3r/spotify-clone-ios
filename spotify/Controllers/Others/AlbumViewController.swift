//
//  AlbumViewController.swift
//  spotify
//
//  Created by Ather Hussain on 18/06/21.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album: Album
    
    init(album: Album) {
    
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getAlbumsDetails(for: album) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    


}
