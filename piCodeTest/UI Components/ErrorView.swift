//
//  ErrorView.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import SwiftUI

struct ErrorView: View {
    var icon: String
    var title: String
    var message: String
    var retryAction: () -> Void

    init(
        icon: String = "wifi.slash",
        title: String,
        message: String,
        retryAction: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.retryAction = retryAction
    }

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(Color.App.errorRed)
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(message)
                .font(.subheadline)
                .foregroundColor(Color.App.textSecondary)
                .multilineTextAlignment(.center)
            Button("Retry") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView(
        title: "Network Error",
        message: "Unable to connect to the server. Please check your connection and try again."
    ) {
        print("Retry tapped")
    }
}
