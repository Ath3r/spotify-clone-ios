//
//  PlayerDataSource.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}
