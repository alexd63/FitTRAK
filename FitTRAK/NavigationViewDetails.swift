//
//  NavigationViewDetails.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

struct NavigationViewDetails<Content: View>: View {
    var title: String
    var leadingToolbarItem: String
    var trailingToolbarItem: String
    let content: () -> Content?
    
    var body: some View{
        NavigationView{
            
                content()
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {
                                print("settings pressed")
                            }, label: {
                                Image(systemName: leadingToolbarItem)
                            })
                        }
                        ToolbarItem(placement: .principal){
                            Text(title)
                                .font(.system(size: 24, weight: .light, design: .monospaced))
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button(action: {
                                print("profile pressed")
                            }, label: {
                                Image(systemName: trailingToolbarItem)
                            })
                        }
                    }
            
        }
    }
}

struct NavigationViewDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
