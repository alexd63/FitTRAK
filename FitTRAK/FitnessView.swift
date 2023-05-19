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
    @ObservedObject var colorTheme: ColorTheme
    
    init(colorTheme: ColorTheme) {
        self.colorTheme = colorTheme
    }
    
    var body: some View{
        
        GeometryReader{ geometry in
            ZStack{
                
                    ScrollView{
                        ZStack{
                            VStack(spacing: 160){
                                sections.addHorizontalSections(sectionName: names.exercise.rawValue, sectionsColor: colorTheme.sectionsColor, sectionUIFunc: { _ in
                                    exerciseSectionUI(sectionName: Sections.SectionNames.exercise.rawValue)
                                })
                                
                                sections.addHorizontalSections(sectionName: "Distance", sectionsColor: colorTheme.sectionsColor, sectionUIFunc: { _ in
                                    distanceSectionUI(sectionName: Sections.SectionNames.distance.rawValue)
                                })
                                
                                sections.rowWithColumns(columnNames: [Sections.SectionNames.steps.rawValue, Sections.SectionNames.weight.rawValue], sectionsColor: colorTheme.sectionsColor, sectionTextSize: 18, healthAccessAtIndex: [true, false], navigationLinkFor: [Sections.SectionNames.steps.rawValue, Sections.SectionNames.weight.rawValue])
                            }
                        }
                        
                    }
                    
//                } nav view
            }
        }
    }

    func exerciseSectionUI(sectionName: String) -> some View {
        let fontSize = 18.0
        return ZStack{
            HStack(alignment: .center){
                VStack(alignment: .leading){
                    Spacer()
                    Text("\(sectionName)")
                        .foregroundColor(colorTheme.textColor)
                        .customFont(size: fontSize + 4)
                    Spacer()
                    
                    HStack{
                        Text("Time:")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                        Text("124 mins")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                    }
                    
                    Spacer()
                    
                    HStack{
                        Text("\(Sections.SectionNames.calories.rawValue):")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                        Text("231 KCal")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                    }
                    Spacer()
                }
                Spacer()
                Image(systemName: "figure.run.square.stack")
                    .resizable()
                    .frame(maxWidth: 70, maxHeight: 70)
                    .foregroundColor(colorTheme.textColor)
                    .padding(.trailing)
                Spacer()
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 60)
//        .overlay(.red)

        
    }
    
    func distanceSectionUI(sectionName: String) -> some View {
        let fontSize = 16.0
        return ZStack{
            HStack(alignment: .center){
                VStack(alignment: .leading){
                    Spacer()
                    Text("\(sectionName)")
                        .foregroundColor(colorTheme.textColor)
                        .customFont(size: fontSize + 4)
                    Spacer()
                    
                    HStack{
                        Text("Total Distance:")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                        Text("3 miles")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                    }
                    
                    Spacer()
                    
                    HStack{
                        Text("Walking speed:")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                        Text("1.6 mph")
                            .foregroundColor(colorTheme.textColor)
                            .customFont(size: fontSize)
                    }
                    Spacer()
                }
                Spacer()
                HStack{
                    Image(systemName: "figure.walk")
                        .resizable()
                        .frame(maxWidth: 40, maxHeight: 45)
                        .foregroundColor(colorTheme.textColor)
                        .padding(.trailing)
                    VStack{
                        Image(systemName: "arrow.forward")
                            .resizable()
                            .frame(maxWidth: 20, maxHeight: 15)
                            .foregroundColor(colorTheme.textColor)
                            .padding(.leading, -20)
                            .padding(.trailing, 15)
                        Image(systemName: "arrow.forward")
                            .resizable()
                            .frame(maxWidth: 20, maxHeight: 15)
                            .foregroundColor(colorTheme.textColor)
                            .padding(.leading, -20)
                            .padding(.trailing, 15)
                    }
                }
                Spacer()
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 60)
//        .overlay(.red)

        
    }

}


struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
