//
//  ErrorView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 15/1/25.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .applyStyle(.h1)
                    .padding(.bottom, Spacing.medium)
                Text(error)
                    .applyStyle(.headLine)
                
                Spacer()
            }
            .padding()
            .background(Color.background.opacity(0.6))
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
    }
}

#Preview {
    ErrorView(error: "")
}
