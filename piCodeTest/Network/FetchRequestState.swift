//
//  FetchRequestState.swift
//  piCodeTest
//
//  Created by nasir on 7. 10. 2025..
//

import Foundation

enum FetchRepoState {
    case idle
    case loading
    case success
    case failure(NetworkError)
}
