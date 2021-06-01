//
//  AuthManager.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import Foundation

final class AuthManger {
    static let shared = AuthManger()
    
    struct Constants {
        static let clientId = "Your_Client_Id"
        static let clientSecret = "YOUR_CLIENT_SECRET"
    }
    
    private init () {}
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scope = "user-read-private"
        let redirectUri = "https://yourside.com"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientId)&scope=\(scope)&redirect_uri=\(redirectUri)&show_dialog=TRUE"
        return URL(string: string)
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
    
    public func getCodeForToken(code:String, completion: @escaping ((Bool)->Void)){
        
    }
    
    private func cacheToken(){
        
    }
    
    private func refreshToken(){
        
    }
}
