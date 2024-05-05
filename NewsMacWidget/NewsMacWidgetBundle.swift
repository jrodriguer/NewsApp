//
//  NewsMacWidgetBundle.swift
//  NewsMacWidget
//
//  Created by Julio Rodriguez on 5/5/24.
//

import WidgetKit
import SwiftUI

@main
struct NewsMacWidgetBundle: WidgetBundle {
    var body: some Widget {
        NewsMacWidget()
        NewsMacWidgetLiveActivity()
    }
}
