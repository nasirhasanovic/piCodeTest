//
//  PostDetailView.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Post ID: \(post.id)")
                            .font(.caption)
                            .foregroundColor(Color.App.textSecondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.App.primaryBlueLight)
                            .cornerRadius(8)

                        Spacer()

                        Text("User ID: \(post.userId)")
                            .font(.caption)
                            .foregroundColor(Color.App.textSecondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.App.primaryGreenLight)
                            .cornerRadius(8)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Title")
                        .font(.subheadline)
                        .foregroundColor(Color.App.textSecondary)

                    Text(post.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Content")
                        .font(.subheadline)
                        .foregroundColor(Color.App.textSecondary)

                    Text(post.body)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(4)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        PostDetailView(post: Post(userId: 1, id: 1, title: "Sample Post Title", body: "This is a sample post body content."))
    }
}
