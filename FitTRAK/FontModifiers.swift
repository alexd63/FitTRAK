//
//  FontModifiers.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/20/23.
//

import Foundation
import SwiftUI

struct FontModifiers: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .ultraLight, design: .monospaced))
    }
}

//extends to whole View protocol
extension View {
    func customFont(size: CGFloat) -> some View{
        self.modifier(FontModifiers(size: size))
    }
}
