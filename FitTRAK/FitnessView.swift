//
//  FitnessView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

struct FitnessView: View {
    var body: some View{
        ZStack{
            NavigationViewDetails(title: "Fitness", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                VStack{
                    Text("test")
                }
            }
            
        }

    }
}

struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
