//
//  PlaylistViewController.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import UIKit

class PlaylistViewController: UIViewController {

    private let playlist: Playlist
    
    init(playlist: Playlist) {
    
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playlist.name
        view.backgroundColor = .systemBackground
    }

}
