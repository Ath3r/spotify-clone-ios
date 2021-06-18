//
//  BrowseSectionType.swift
//  spotify
//
//  Created by Ather Hussain on 18/06/21.
//

import Foundation

enum BrowseSectionType {
    case newReleases(viewModels:[NewReleasesCellViewModel])
    case featuredPlaylists(viewModels:[FeaturedPlaylistViewModel])
    case recommendedTracks(viewModels:[RecommendedTrackCellViewModel])
    
    var title: String{
        switch self {
        case .newReleases:
            return "New Releases"
        case .featuredPlaylists:
            return "Featured Playlists"
        case .recommendedTracks:
            return "Recommended"
        }
    }
}
