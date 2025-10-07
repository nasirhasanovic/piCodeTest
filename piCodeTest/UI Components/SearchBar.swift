//
//  SearchBar.swift
//  piCodeTest
//
//  Created by nasir on 07. 10. 2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    init(text: Binding<String>, placeholder: String = "Search") {
        self._text = text
        self.placeholder = placeholder
    }

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.App.textSecondary)
            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(12)
        .background(Color.App.searchBackground)
        .cornerRadius(10)
    }
}

#Preview {
    SearchBar(text: .constant(""), placeholder: "Search posts")
        .padding()
}
