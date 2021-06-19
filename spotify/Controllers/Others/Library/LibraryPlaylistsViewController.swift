//
//  LibraryPlaylistsViewController.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    private var playlists = [Playlist]()
    
    private let noPlaylistView = ActionLabelView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noPlaylistView)
        noPlaylistView.delegate = self
        setupNoPlaylistView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistView.center = view.center
    }
    
    private func setupNoPlaylistView(){
        noPlaylistView.configure(
            with: ActionLabelViewViewModel(
                text: "You don't have any playlists yet.",
                actionTitle: "Create")
        )
    }
    
    private func fetchData(){
        APICaller.shared.getCurrentUserPlaylist { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    private func updateUI(){
        print(playlists)
        if playlists.isEmpty{
            print("No Playlist")
            noPlaylistView.isHidden = false
        }else{
            //Show table
        }
    }
}
extension LibraryPlaylistsViewController: ActionLabelViewDeleagete{
    
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        //Push VC to create a playlist
        let alert = UIAlertController(
            title: "New Playlist",
            message: "Enter Playlist Name",
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = "Enter..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else{
                return
            }
            APICaller.shared.createPlaylist(with: text) { success in
                if success{
                    //Refresh View
                } else{
                    print("Failed to create playlist")
                }
            }
        }))
        present(alert, animated: true)
    }
    
}
