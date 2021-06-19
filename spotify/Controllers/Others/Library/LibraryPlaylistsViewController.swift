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
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(
            SearchResultSubtitleTableViewCell.self,
            forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifer
        )
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noPlaylistView)
        view.addSubview(tableView)
        noPlaylistView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setupNoPlaylistView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistView.center = view.center
        tableView.frame = view.bounds
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
            tableView.isHidden = true
        }else{
            tableView.isHidden = false
            noPlaylistView.isHidden = true
            tableView.reloadData()
        }
    }
    func createPlaylistAlert(){
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
            APICaller.shared.createPlaylist(with: text) {[weak self] success in
                if success{
                    self?.fetchData()
                } else{
                    print("Failed to create playlist")
                }
            }
        }))
        present(alert, animated: true)
    }
}
extension LibraryPlaylistsViewController: ActionLabelViewDeleagete{
    
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        createPlaylistAlert()
    }
    
}
extension LibraryPlaylistsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifer,
                for: indexPath
        ) as? SearchResultSubtitleTableViewCell else{
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
                        title: playlist.name,
                        imageURL: URL(string: playlist.images.first?.url ?? ""),
                        subtitle: playlist.owner.display_name)
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
