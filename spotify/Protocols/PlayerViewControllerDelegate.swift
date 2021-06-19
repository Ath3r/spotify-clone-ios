//
//  PlayerViewControllerDelegate.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation

protocol PlayerViewControllerDelegate:AnyObject {
    func didSlideSlider(_ value: Float)
    func didTapPlayPlause()
    func didTapForward()
    func didTapBackward()
}
