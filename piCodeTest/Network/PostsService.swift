//
//  PostsService.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import Foundation

protocol PostsServiceProtocol {
    func fetchPosts() async throws -> [Post]
}

class PostsService: PostsServiceProtocol {
    private let apiClient: APIClient
    private let baseURL = "https://jsonplaceholder.typicode.com"

    init(apiClient: APIClient = URLSessionAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let posts: [Post] = try await apiClient.send(request)

        return posts.filter { $0.id < 50 }
    }
}
