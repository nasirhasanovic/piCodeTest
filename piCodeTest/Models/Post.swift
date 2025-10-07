//
//  Post.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
