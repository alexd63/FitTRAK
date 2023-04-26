//
//  FitnessView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

struct FitnessView: View {
    private var sections = Sections()
    private var names = Sections.SectionNames.self
    
    var body: some View{
        
        GeometryReader{ geometry in
            ZStack{
                NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                    ScrollView{
                        ZStack{
                            VStack(spacing: 160){
                                sections.addHorizontalSections(sectionName: names.calories.rawValue, sectionsColor: .green, sectionUIFunc: { _ in
                                    testFunction(sectionName: "Test")
                                }, infoIncluded: true, infoButton: {_ in
                                    testFunction(sectionName: "es")
                                })
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }

    func testFunction(sectionName: String) -> some View {
            Text(sectionName)
    }
}

struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
