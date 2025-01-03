//
//  Font + Extension.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/12/24.
//

import Foundation
import SwiftUI

extension Font {
    static func from(_ definition: TextDefinition) -> Font {
        return .notoSans(definition.weight, size: definition.size)
    }
    
    static func notoSans(_ font: NotoSans, size: CGFloat) -> Font {
        return .custom(font.rawValue, size: size)
    }
}
