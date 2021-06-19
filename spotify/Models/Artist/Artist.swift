//
//  Artist.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name:String
    let type:String
    let external_urls: [String:String]
    let images: [APIImage]?
}
