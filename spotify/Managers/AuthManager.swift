//
//  AuthManager.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import Foundation

final class AuthManger {
    static let shared = AuthManger()
    
    private init () {}
    
    struct Constants {
        static let clientId = "YOUR_CLIENT_ID"
        static let clientSecret = "YOUR_CLIENT_SECRET"
    }
    
    var isSignedIn: Bool{
        return false
    }
    
    private var accessToken: String?{
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    private var tokenExpirationDate: Date?{
        return nil
    }
    private var shouldRefreshToken: Bool{
        return false
    }
}
