//
//  FabButtonStyle.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 11/2/25.
//

import SwiftUI

struct FabButtonStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .background(Color.secondary.opacity(0.6))
            .cornerRadius(55/2)
            .padding()
    }
}
