//
//  SettingsModels.swift
//  spotify
//
//  Created by Ather Hussain on 15/06/21.
//

import Foundation
struct Section {
    let title:String
    let options: [Option]
}


struct Option {
    let title: String
    let handler: () -> Void
    
}
