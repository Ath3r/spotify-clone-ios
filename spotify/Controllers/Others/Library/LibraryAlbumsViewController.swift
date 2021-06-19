//
//  LibraryAlbumsViewController.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {
        
    private var albums = [Album]()
    
    private let noAlbumsView = ActionLabelView()
    
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
    
    private var observer: NSObjectProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noAlbumsView)
        view.addSubview(tableView)
        noAlbumsView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setupNoAlbumsView()
        fetchData()
        observer = NotificationCenter.default.addObserver(
            forName: .albumSavedNotification,
            object: nil,
            queue: .main,
            using: {[weak self] _ in
                self?.fetchData()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumsView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    @objc func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    
    private func setupNoAlbumsView(){
        noAlbumsView.configure(
            with: ActionLabelViewViewModel(
                text: "You don't have any albums saved yet.",
                actionTitle: "Browse")
        )
    }
    
    private func fetchData(){
        albums.removeAll()
        APICaller.shared.getUserAlbums { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let albums):
                    self?.albums = albums
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI(){
        if albums.isEmpty{
            print("No Playlist")
            noAlbumsView.isHidden = false
            tableView.isHidden = true
        }else{
            print(self.albums)
            tableView.isHidden = false
            noAlbumsView.isHidden = true
            tableView.reloadData()
        }
    }
    
}
extension LibraryAlbumsViewController: ActionLabelViewDeleagete{
    
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
    
}
extension LibraryAlbumsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultSubtitleTableViewCell.identifer,
            for: indexPath
        ) as? SearchResultSubtitleTableViewCell else{
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
                        title: album.name,
                        imageURL: URL(string: album.images.first?.url ?? ""),
                        subtitle: album.artists.first?.name ?? "-")
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
