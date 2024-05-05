//
//  NewsIOSWidgetBundle.swift
//  NewsIOSWidget
//
//  Created by Julio Rodriguez on 5/5/24.
//

import WidgetKit
import SwiftUI

@main
struct NewsIOSWidgetBundle: WidgetBundle {
    var body: some Widget {
        NewsIOSWidget()
        NewsIOSWidgetLiveActivity()
    }
}
