//
//  ColorTheme.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/26/23.
//

import Foundation
import SwiftUI

class ColorTheme: ObservableObject {
    @Published var darkMode = false
    var backgroundColor: Color {
        darkMode ? Color.black : Color.white
    }
    var sectionsColor: Color {
        darkMode ? Color.gray : Color.black
    }

}
