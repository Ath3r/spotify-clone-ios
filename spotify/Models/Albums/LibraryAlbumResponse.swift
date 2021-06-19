//
//  LibraryAlbumResponse.swift
//  spotify
//
//  Created by Ather Hussain on 20/06/21.
//

import Foundation

struct LibraryAlbumResponse: Codable {
    let items: [SavedAlbum]
}
struct SavedAlbum: Codable{
    let added_at: String
    let album: Album
}
