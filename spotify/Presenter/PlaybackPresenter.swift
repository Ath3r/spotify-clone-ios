//
//  PlaybackPresenter.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation
import UIKit
import AVFoundation

final class PlaybackPresenter{
    
    static let shared = PlaybackPresenter()
    
    var playerVC: PlayerViewController?
    
    private var track: AudioTrack?
    
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty{
            return track
        } else if let player = self.playerQueue, !tracks.isEmpty{
            return tracks[index]
        }
        return nil
    }
    
    func startPlayback(from viewController: UIViewController,track: AudioTrack){
        guard let url = URL(string: track.preview_url ?? "") else{
            print("No Preview URL")
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.track = track
        self.tracks = []
        
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) {[weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController,tracks: [AudioTrack]){
        
        self.tracks = tracks
        self.track = nil
        
        let items: [AVPlayerItem] = tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else{
                print("No Peview Found")
                return nil
            }
            return AVPlayerItem(url: url)
        })
        
        self.playerQueue = AVQueuePlayer(items: items)
        self.playerQueue?.volume = 0.5
        
        self.playerQueue?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
        self.playerVC = vc
    }
    
}
extension PlaybackPresenter: PlayerDataSource{
    
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}

extension PlaybackPresenter: PlayerViewControllerDelegate{
    
    func didTapPlayPlause() {
        if let player = player{
            if player.timeControlStatus == .playing{
                player.pause()
            }else if player.timeControlStatus == .paused{
                player.play()
            }
        }else if let playerQueue = playerQueue{
            if playerQueue.timeControlStatus == .playing{
                playerQueue.pause()
            }else if playerQueue.timeControlStatus == .paused{
                playerQueue.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty{
            player?.pause()
        }else if let player = playerQueue{
            player.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty{
            player?.pause()
            player?.seek(to: .zero)
            player?.play()
        }else if let firstItem = playerQueue?.items().first{
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0.5
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
}
