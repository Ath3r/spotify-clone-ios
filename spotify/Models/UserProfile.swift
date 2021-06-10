//
//  UserProfile.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import Foundation


struct UserProfile: Codable{
    let display_name: String
    let country: String
    let email: String
    let explicit_content: [String:Int]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage:Codable{
    let url: String
}
