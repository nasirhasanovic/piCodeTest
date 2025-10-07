//
//  ToolbarView.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import SwiftUI

struct ToolbarView: View {
    @Binding var sortOption: SortOption
    @Binding var colorScheme: ColorScheme?
    @State private var showingSortOptions = false

    var body: some View {
        HStack {
            Button(action: {
                showingSortOptions.toggle()
            }) {
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                    Text(sortOption.rawValue)
                        .font(.subheadline)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.App.primaryBlueLight)
                .foregroundColor(Color.App.primaryBlue)
                .cornerRadius(8)
            }
            .confirmationDialog("Sort By", isPresented: $showingSortOptions, titleVisibility: .visible) {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Button(option.rawValue) {
                        sortOption = option
                    }
                }
            }

            Spacer()

            Button(action: {
                toggleColorScheme()
            }) {
                Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                    .font(.title3)
                    .foregroundColor(colorScheme == .dark ? Color.App.themeDark : Color.App.themeLight)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private func toggleColorScheme() {
        if colorScheme == nil || colorScheme == .light {
            colorScheme = .dark
        } else {
            colorScheme = .light
        }
    }
}

#Preview {
    ToolbarView(sortOption: .constant(.idAsc), colorScheme: .constant(.light))
}
