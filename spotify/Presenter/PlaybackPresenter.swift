//
//  PlaybackPresenter.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation
import UIKit

final class PlaybackPresenter{
    
    static func startPlayback(from viewController: UIViewController,track: AudioTrack){
        let vc = PlayerViewController()
        viewController.present(vc, animated: true)
    }
    
    static func startPlayback(from viewController: UIViewController,tracks: [AudioTrack]){
        let vc = PlayerViewController()
        viewController.present(vc, animated: true)
    }

}
