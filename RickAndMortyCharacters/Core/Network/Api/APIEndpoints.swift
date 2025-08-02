//
//  APIEndpoints.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 30/07/2025.
//

import Foundation

// MARK: - API Endpoints
enum APIEndpoints {
    case characters(page: Int, status: String?)
    case characterDetails(id: Int)
}
// MARK: - RequestConfigurable Implementation
extension APIEndpoints: RequestConfigurable {
    var baseURL: String {
        return NetworkConfig.baseURL
    }

    var path: String {
        switch self {
        case .characters(let page, let status):
            var query = "?page=\(page)"
            if let status = status {
                query += "&status=\(status)"
            }
            return "\(NetworkConfig.Paths.charaters)\(query)"
        case .characterDetails(let id):
            return "\(NetworkConfig.Paths.charaters)/\(id)"
        }
    }

    var method: HTTPMethod { .get }

    var headers: [String: String]? { NetworkConfig.defaultHeaders }

    var decoder: JSONDecoder? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
// MARK: - HTTP Method Enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
