//
//  LibraryToggleViewDelegate.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}
