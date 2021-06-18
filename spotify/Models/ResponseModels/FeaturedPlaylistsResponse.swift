//
//  FeaturedPlaylistsResponse.swift
//  spotify
//
//  Created by Ather Hussain on 17/06/21.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: CategoryPlaylistResponse
}

struct CategoryPlaylistResponse: Codable {
    let items: [Playlist]
}




