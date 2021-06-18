//
//  APICaller.swift
//  spotify
//
//  Created by Ather Hussain on 01/06/21.
//

import Foundation


final class APICaller{
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants{
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error{
        case failedToGetData
    }
    
    //MARK: - Albums
    
    public func getAlbumsDetails(for album: Album, completion: @escaping ((Result<AlbumDetailsResponse,Error>)->Void)){
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/albums/\(album.id)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    //MARK: - Playlists
    
    public func getPlaylistDetail(for playlist: Playlist, completion: @escaping ((Result<PlaylistDetailsResponse,Error>)->Void)){
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/playlists/\(playlist.id)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    //MARK: - Profile
    
    public func getUserProfile(completion: @escaping ((Result<UserProfile,Error>) ->Void)){
        let url = "\(Constants.baseAPIURL)/me"
        createRequest(with: URL(string: url), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else{
                    print("Failure to Get data")
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("Error Fetch UserProfile \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)->Void)){
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print("Error Fetch New Releases \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    public func getFeaturedPlaylist(completion: @escaping ((Result<FeaturedPlaylistsResponse,Error>)->Void)){
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print("Error Fetch Featuered Playlists \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendataion(genres: Set<String>,completion: @escaping ((Result<RecommendationsResponse, Error>)->Void)){
        let seeds = genres.joined(separator: ",")
        createRequest(
            with: URL(string: "\(Constants.baseAPIURL)/recommendations?limit=40&seed_genres=\(seeds)"),
            type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print("Error Fetch Recommendations \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>)->Void)){
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print("Error Fetch Recommendations \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    //MARK: - Categories
    
    public func getCategories(completion: @escaping ((Result<[Category],Error>)->Void)){
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/browse/categories"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                    
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getCategoryPlaylists(category: Category,completion: @escaping ((Result<[Playlist],Error>)->Void)){
        createRequest(with: URL(string: "\(Constants.baseAPIURL)/browse/categories/\(category.id)/playlists?limit=2"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    print("Playlists: \(result.playlists.items)")
                    completion(.success(result.playlists.items))
                    
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: - Private
    
    enum HTTPMethod: String{
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,type: HTTPMethod,completion: @escaping ((URLRequest)->Void)) {
        AuthManger.shared.withValidToken { token in
            guard let apiURL = url else{
                print("Incorrect Url")
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            completion(request)
        }
    }
}
