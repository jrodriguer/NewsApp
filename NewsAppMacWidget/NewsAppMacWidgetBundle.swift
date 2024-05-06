//
//  NewsAppMacWidgetBundle.swift
//  NewsAppMacWidget
//
//  Created by Julio Rodriguez on 5/5/24.
//

import WidgetKit
import SwiftUI

@main
struct NewsAppMacWidgetBundle: WidgetBundle {
    var body: some Widget {
        NewsAppMacWidget()
        NewsAppMacWidgetLiveActivity()
    }
}
