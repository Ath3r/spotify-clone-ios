//
//  LIbraryViewController.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistsVC =  LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let toggleView = LibraryToggleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        toggleView.delegate = self
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        addChildren()
        updateBarButtons()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top+55,
            width: view.width,
            height: height
        )
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 55)
    }
    private func addChildren(){
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistsVC.didMove(toParent: self)
        
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumsVC.didMove(toParent: self)
    }
    private func updateBarButtons(){
        switch toggleView.state {
        case .playlist:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(didTapAdd)
            )
        case .album:
            navigationItem.rightBarButtonItem = nil
        }
    }
    @objc private func didTapAdd(){
        playlistsVC.createPlaylistAlert()
    }
}
extension LibraryViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width-100){
            toggleView.update(for: .album)
            updateBarButtons()
        }else{
            toggleView.update(for: .playlist)
            updateBarButtons()
        }
    }
}

extension LibraryViewController: LibraryToggleViewDelegate{
    
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        updateBarButtons()
    }
    
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
    
    
}
