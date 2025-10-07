//
//  PostRowView.swift
//  piCodeTest
//
//  Created by nasir on 7. 10. 2025..
//

import SwiftUI

struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("ID: \(post.id)")
                    .font(.caption)
                    .foregroundColor(Color.App.textSecondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.App.primaryBlueLight)
                    .cornerRadius(4)

                Spacer()
            }

            Text(post.title)
                .font(.headline)
                .lineLimit(2)

            Text(post.body)
                .font(.subheadline)
                .foregroundColor(Color.App.textSecondary)
                .lineLimit(3)
        }
        .padding()
        .background(Color.App.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.App.shadowColor, radius: 5, x: 0, y: 2)
    }
}
