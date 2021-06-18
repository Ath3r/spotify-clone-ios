//
//  Playlist.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import Foundation

struct Playlist: Codable{
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
