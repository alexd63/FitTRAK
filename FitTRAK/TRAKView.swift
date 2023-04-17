//
//  TRAKView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

struct TRAKView: View {
    private var cornerSectionsSize = CGSize(width: 15, height: 15)
    private var frameSectionsWidth = CGFloat(350)
    private var frameSectionsHeight = CGFloat(150)

    
    var body: some View{
        ZStack{
            NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                VStack{
                    Text("test")
                }
            }
            
        }
        
    }
}

struct TRAKView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
