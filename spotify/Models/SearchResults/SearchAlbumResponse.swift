//
//  SearchAlbumResponse.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation

struct SearchAlbumsResponse: Codable {
    let items: [Album]
}

struct SearchArtistsResponse: Codable {
    let items: [Artist]
}

struct SearchPlaylistsResponse: Codable {
    let items: [Playlist]
}

struct SearchTracksResponse: Codable {
    let items: [AudioTrack]
}
