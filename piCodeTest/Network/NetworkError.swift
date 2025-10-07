//
//  NetworkError.swift
//  piCodeTest
//
//  Created by nasir on 7. 10. 2025..
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(String)
    case invalidResponse
    case decodingFailed(String)
}
