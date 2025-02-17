//
//  FabButtonView.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/25.
//

import SwiftUI

struct FabButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: "chevron.up")
                .font(.largeTitle)
                .frame(width: 55, height: 55)
        }
        .buttonStyle(FabButtonStyle())
        .accessibilityIdentifier("FabButton")
    }
}

struct FabButtonStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .background(Color.secondary.opacity(0.6))
            .cornerRadius(55/2)
            .padding()
    }
}
