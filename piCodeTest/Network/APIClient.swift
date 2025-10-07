//
//  APIClient.swift
//  piCodeTest
//
//  Created by nasir on 7. 10. 2025..
//

import Foundation
// MARK: - Networking

protocol APIClient {
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
}

class URLSessionAPIClient: APIClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error.localizedDescription)
        }
    }
}
