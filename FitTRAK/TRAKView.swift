//
//  TRAKView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

struct TRAKView: View {
    private var darkMode: Bool
    private var backgroundColor: Color {
        darkMode ? Color.black : Color.white
    }
    private var sectionsColor: Color {
        darkMode ? Color.white : Color.black
    }

    private var cornerSectionsSize = CGSize(width: 15, height: 15)
    private var frameSectionsWidth = CGFloat(350)
    private var frameSectionsHeight = CGFloat(150)

    init(darkMode: Bool){
        self.darkMode = darkMode
    }
    
    
    
    var body: some View{
        ZStack{
            NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                ScrollView{
                        VStack(spacing: 165){
                            ForEach(1..<6) { sections in
                                GeometryReader{ geometry in
                                    Button(action: {
                                        print("section button pressed!")
                                    }, label: {
                                        
                                        RoundedRectangle(cornerSize: CGSize(width: 18, height: 18))
                                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 16)
                                            
                                            .foregroundColor(sectionsColor)
                                        
                                        
                                        
                                    })
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
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
