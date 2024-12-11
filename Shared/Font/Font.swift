//
//  Font + Extension.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/12/24.
//

import Foundation
import SwiftUI

extension Font {
    static var h1: Font = {
        return notoSans(.bold, size: 24)
    }()
    
    static var h2: Font = {
        return notoSans(.semiBold, size: 18)
    }()
    
    static var h3: Font = {
        return notoSans(.medium, size: 16)
    }()
    
    static var h4: Font = {
        return notoSans(.medium, size: 14)
    }()
    
    static func notoSans(_ font: NotoSans, size: CGFloat) -> Font {
        return .custom(font.rawValue, size: size)
    }
}

