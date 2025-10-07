//
//  PostsViewModel.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var posts: [Post] = []
    @Published var filteredPosts: [Post] = []
    @Published var searchText: String = "" {
        didSet {
            filterAndSortPosts()
        }
    }
    @Published var sortOption: SortOption = .idAsc {
        didSet {
            filterAndSortPosts()
        }
    }
    @Published var state: FetchRepoState = .idle

    // MARK: - Private Properties

    private let postsService: PostsServiceProtocol
    private var fetchTask: Task<Void, Never>?

    // MARK: - Initialization

    init(postsService: PostsServiceProtocol = PostsService()) {
        self.postsService = postsService
    }

    // MARK: - Public Methods

    func fetchPosts() async {
        fetchTask?.cancel()

        fetchTask = Task {
            guard !Task.isCancelled else { return }

            state = .loading

            do {
                let fetchedPosts = try await postsService.fetchPosts()

                guard !Task.isCancelled else { return }

                posts = fetchedPosts
                filterAndSortPosts()
                state = .success
            } catch is CancellationError {
                return
            } catch let error as NetworkError {
                guard !Task.isCancelled else { return }
                state = .failure(error)
            } catch {
                guard !Task.isCancelled else { return }
                state = .failure(.requestFailed(error.localizedDescription))
            }
        }

        await fetchTask?.value
    }

    // MARK: - Private Methods

    private func filterAndSortPosts() {
        var result = posts

        if !searchText.isEmpty {
            result = result.filter { post in
                post.title.localizedCaseInsensitiveContains(searchText) ||
                post.body.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .titleAsc:
            result.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
        case .titleDesc:
            result.sort { $0.title.localizedCompare($1.title) == .orderedDescending }
        case .idAsc:
            result.sort { $0.id < $1.id }
        case .idDesc:
            result.sort { $0.id > $1.id }
        }

        filteredPosts = result
    }
}
