//
//  EmptyStateView.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import SwiftUI

struct EmptyStateView: View {
    var icon: String
    var title: String
    var message: String

    init(
        icon: String = "doc.text.magnifyingglass",
        title: String,
        message: String
    ) {
        self.icon = icon
        self.title = title
        self.message = message
    }

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(Color.App.textSecondary)
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(message)
                .font(.subheadline)
                .foregroundColor(Color.App.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
        title: "No Posts Found",
        message: "Try adjusting your search"
    )
}
