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
        darkMode ? Color(red: rgbValueConvert(25), green: rgbValueConvert(25), blue: rgbValueConvert(25)) : Color.white // Color value = R: 0, G: 66, B: 120
        
    }
    var navTextColor: Color {
        darkMode ? Color.white : Color.black
    }
    var sectionsColor: Color {
        darkMode ? Color(red: rgbValueConvert(84), green: rgbValueConvert(81), blue: rgbValueConvert(146)) : Color.black
//        darkMode ? Color(red: rgbValueConvert(9), green: rgbValueConvert(69), blue: rgbValueConvert(121)) : Color.black

    }
    
    var textColor =  Color.white

    func rgbValueConvert(_ value: Double) -> Double {
        return value / 255.0
    }
}
