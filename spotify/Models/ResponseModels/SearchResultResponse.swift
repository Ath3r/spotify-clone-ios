//
//  SearchResultResponse.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation

struct SearchResultResponse: Codable {
    let albums: SearchAlbumsResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTracksResponse
}
