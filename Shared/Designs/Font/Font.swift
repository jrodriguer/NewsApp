//
//  Font.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 9/12/24.
//

import Foundation
import SwiftUI

extension Font {
  public static var h1: Font = {
    return notoSans(.bold, size: 36)
  }()
  
  public static var h2: Font = {
    return notoSans(.semiBold, size: 24)
  }()
  
  public static var h3: Font = {
    return notoSans(.medium, size: 18)
  }()
  
  public static var h4: Font = {
    return notoSans(.medium, size: 14)
  }()
  
  public static var h5: Font = {
    return notoSans(.medium, size: 12)
  }()
  
  public static var h6: Font = {
    return notoSans(.regular, size: 12)
  }()

  public static func notoSans(_ font: NotoSans, size: CGFloat) -> Font {
    return .custom(font.rawValue, size: size)
  }
}
