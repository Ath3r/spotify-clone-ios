//
//  SearchResultViewController.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import UIKit


class SearchResultViewController: UIViewController {
    
    private var sections: [SearchSection] = []
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(
            SearchResultDefaultTableViewCell.self,
            forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifer
        )
        tableView.register(
            SearchResultSubtitleTableViewCell.self,
            forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifer
        )
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [SearchResult]){
        
        let artists = results.filter({
            switch $0{
            case .artist:
                return true
            default: return false
            }
        })
        
        let albums = results.filter({
            switch $0{
            case .album:
                return true
            default: return false
            }
        })
        
        let tracks = results.filter({
            switch $0{
            case .track:
                return true
            default: return false
            }
        })
        
        let playlists = results.filter({
            switch $0{
            case .playlist:
                return true
            default: return false
            }
        })
        
        self.sections = [
            SearchSection(title: "Tracks", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Albums", results: albums)
        ]
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
}
extension SearchResultViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        switch result {
        case .artist(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultDefaultTableViewCell.identifer,
                    for: indexPath
            ) as? SearchResultDefaultTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(
                with: SearchResultDefaultTableViewCellViewModel(
                    title: model.name,
                    imageURL: URL(
                        string: model.images?.first?.url ?? ""
                    )
                )
            )
            return cell
        case .album(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifer,
                for: indexPath
            ) as? SearchResultSubtitleTableViewCell else{
                return UITableViewCell()
            }
            cell.configure(
                with: SearchResultSubtitleTableViewCellViewModel(
                    title: model.name,
                    imageURL: URL(
                        string: model.images.first?.url ?? ""),
                    subtitle: model.artists.first?.name ?? "-"
                )
            )
            return cell
        case .track(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifer,
                for: indexPath
            ) as? SearchResultSubtitleTableViewCell else{
                return UITableViewCell()
            }
            cell.configure(
                with: SearchResultSubtitleTableViewCellViewModel(
                    title: model.name,
                    imageURL: URL(
                        string: model.album?.images.first?.url ?? ""),
                    subtitle: model.artists.first?.name ?? "-"
                )
            )
            return cell
        case .playlist(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultSubtitleTableViewCell.identifer,
                for: indexPath
            ) as? SearchResultSubtitleTableViewCell else{
                return UITableViewCell()
            }
            cell.configure(
                with: SearchResultSubtitleTableViewCellViewModel(
                    title: model.name,
                    imageURL: URL(
                        string: model.images.first?.url ?? ""),
                    subtitle: model.owner.display_name
                )
            )
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrate(for: .success)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResults(result)
    }
}
