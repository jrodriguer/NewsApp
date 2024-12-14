//
//  NotoSans.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/12/24.
//

import Foundation
import SwiftUI

public enum NotoSans: String, CaseIterable {
  case thin = "NotoSans-Thin"
  case bold = "NotoSans-Bold"
  case light = "NotoSans-Light"
  case black = "NotoSans-Black"
  case medium = "NotoSans-Medium"
  case regular = "NotoSans-Regular"
  case semiBold = "NotoSans-SemiBold"
  case extraBold = "NotoSans-ExtraBold"
  case extraLight = "NotoSans-ExtraLight"
}

public struct NotoSansFont {

#if SWIFT_PACKAGE
  public static func registerFonts() {
    NotoSans.allCases.forEach {
        registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
    }
  }
#endif
    
  fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider) else {
      fatalError("Couldn't ceate font from filename: \(fontName) with extension \(fontExtension)")
    }
    var error: Unmanaged<CFError>?
    CTFontManagerRegisterGraphicsFont(font, &error)
  }
}

