//
//  PlaylistDetailsResponse.swift
//  spotify
//
//  Created by Ather Hussain on 18/06/21.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let name: String
    let id: String
    let images: [APIImage]
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack?
}
