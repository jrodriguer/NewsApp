//
//  NewsAppIOSWidgetBundle.swift
//  NewsAppIOSWidget
//
//  Created by Julio Rodriguez on 5/5/24.
//

import WidgetKit
import SwiftUI

@main
struct NewsAppIOSWidgetBundle: WidgetBundle {
    var body: some Widget {
        NewsAppIOSWidget()
        NewsAppIOSWidgetLiveActivity()
    }
}
