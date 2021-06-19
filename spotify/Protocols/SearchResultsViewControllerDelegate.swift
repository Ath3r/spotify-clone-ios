//
//  SearchResultsViewControllerDelegate.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation
import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResults(_ results: SearchResult)
    
}
