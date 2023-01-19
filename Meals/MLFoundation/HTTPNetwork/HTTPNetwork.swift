//
//  HTTPNetwork.swift
//  Meals
//
//  Created by Yongfeng on 1/13/23.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [URLQueryItem]? { get }
}

final class NetworkManager {
    
    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.params
        
        return components
    }
    
    class func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, Error>) -> Void) {
        let components = buildURL(endpoint: endpoint)
        guard let url = components.url else {
            let error = HTTPError.invalidURL(url: String(describing: components.url))
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response != nil, let data = data else {
                let error = HTTPError.responseIsNull
                completion(.failure(error))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch let jsonError as NSError {
                completion(.failure(jsonError))
            }
        }
        
        task.resume()
    }
}
