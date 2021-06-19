//
//  PlayerControlsViewDelegate.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPause(_ playerControlView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlView: PlayerControlsView)
    func playerControlsViewDidTapBackwardsButton(_ playerControlView: PlayerControlsView)
    func playerControlsView(_ playerControlView: PlayerControlsView, didSlideSlider value: Float)
}
