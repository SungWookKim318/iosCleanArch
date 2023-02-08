//
//  SearchBarView.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import SwiftUI

struct SearchBarView: View {
    @State private var text: String = ""
    var defaultText: String = "Search"
    var action: (String) -> ()
    private let inactiveColor = Color.gray.opacity(0.5)
    private let activeColor = Color.gray
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(defaultText, text: $text)
                    .onSubmit {
                        action(text)
                    }
                    .foregroundColor(text.isEmpty ? .gray : .black)
                    
                if text.isEmpty {
                    EmptyView()
                } else {
                    Button {
                        self.text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(activeColor)
                    }
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            Button {
                action(text)
            } label: {
                Text("Search")
                    .font(.system(size: 12))
            }
            .buttonStyle(.borderedProminent)
            .disabled(text.isEmpty)
        }
        .padding(.horizontal)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(action: { print($0)})
    }
}
