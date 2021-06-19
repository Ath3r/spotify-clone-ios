//
//  SearchResult.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation

enum SearchResult{
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
