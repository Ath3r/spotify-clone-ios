//
//  AllCategoriesResponse.swift
//  spotify
//
//  Created by Ather Hussain on 18/06/21.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
    }

struct Categories: Codable{
    let items: [Category]

}

struct Category: Codable {
    let id, name: String
    let  icons: [APIImage]
}
