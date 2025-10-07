//
//  Color+App.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import SwiftUI

extension Color {
    enum App {
        static let primaryBlue = Color.blue
        static let primaryBlueLight = Color.blue.opacity(0.1)
        static let primaryGreenLight = Color.green.opacity(0.1)

        static let errorRed = Color.red

        static let themeLight = Color.orange
        static let themeDark = Color.yellow

        static let textSecondary = Color.secondary
        static let textPrimary = Color.primary

        static let searchBackground = Color(.systemGray6)
        static let cardBackground = Color(.systemBackground)

        static let shadowColor = Color.black.opacity(0.05)
    }
}
