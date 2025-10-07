//
//  ContentView.swift
//  piCodeTest
//
//  Created by nasir on 7. 10. 2025..
//

import SwiftUI

struct PostsView: View {
    // MARK: - Properties

    @StateObject private var viewModel = PostsViewModel()
    @State private var colorScheme: ColorScheme?

    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    SearchBar(text: $viewModel.searchText, placeholder: "Search posts")
                        .padding(.horizontal)
                        .padding(.vertical, 8)

                    ToolbarView(sortOption: $viewModel.sortOption, colorScheme: $colorScheme)

                    switch viewModel.state {
                    case .idle:
                        Spacer()
                    case .loading:
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.5)
                        Spacer()
                    case .success:
                        if viewModel.filteredPosts.isEmpty {
                            EmptyStateView(
                                title: "No Posts Found",
                                message: "Try adjusting your search"
                            )
                        } else {
                            List(viewModel.filteredPosts) { post in
                                NavigationLink(destination: PostDetailView(post: post)) {
                                    PostRowView(post: post)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                            }
                            .listStyle(PlainListStyle())
                            .refreshable {
                                await viewModel.fetchPosts()
                            }
                        }
                    case .failure(let error):
                        ErrorView(
                            title: "Network Error",
                            message: errorMessage(for: error)
                        ) {
                            Task {
                                await viewModel.fetchPosts()
                            }
                        }
                    }
                }
                .navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .preferredColorScheme(colorScheme)
        .task {
            await viewModel.fetchPosts()
        }
    }

    // MARK: - Helper Methods

    private func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let message):
            return message
        case .invalidResponse:
            return "Invalid server response"
        case .decodingFailed(let message):
            return "Failed to decode: \(message)"
        }
    }
}

#Preview {
    PostsView()
}
