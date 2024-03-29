//
//  Font.swift
//  NewsApp
//
//  Created by Julio Rodriguez on 22/2/24.
//

import SwiftUI

extension Font {
    static let appTheme = FontTheme()
}

/*
 Font KodeMono
 Regular: 400
 Medium: 500
 SemiBold: 600
 Bold: 700
 Black: 900
 */
struct FontTheme {
    func kodeMono400(size: CGFloat) -> Font { return Font.custom("KodeMono-Regular", size: size) }
    func kodeMono500(size: CGFloat) -> Font { return Font.custom("KodeMono-Medium", size: size) }
    func kodeMono600(size: CGFloat) -> Font { return Font.custom("KodeMono-SemiBold", size: size) }
    func kodeMono700(size: CGFloat) -> Font { return Font.custom("KodeMono-Bold", size: size) }
}
