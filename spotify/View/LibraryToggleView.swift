//
//  LibraryToggleView.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import UIKit

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(playlistButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylist), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
        updateIndicatorLayout()
    }
    
    @objc func didTapPlaylist(){
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorLayout()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc func didTapAlbums(){
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorLayout()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    private func updateIndicatorLayout(){
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom, width: 100, height: 3)
        }
    }
    func update(for state: State){
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorLayout()
        }
    }
}
