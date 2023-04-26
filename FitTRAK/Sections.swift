////
////  Sections.swift
////  FitTRAK
////
////  Created by Alex Diaz on 4/23/23.
////
//
import Foundation
import SwiftUI
//

struct Sections {

    public enum SectionNames: String, CaseIterable {
        case calories = "Calories"
        case macros = "Macros"
        case water = "Water"
        case logs = "Logs"
        case quote = "Daily Quote"
    }
    
    func addHorizontalSections(
        sectionName: String,
        sectionsColor: Color,
        sectionUIFunc: @escaping (_ sectionName: String) -> some View,
        infoIncluded: Bool,
        infoButton: @escaping (_ sectionName: String) -> some View) -> some View
        {
            
        let sectionsCornerRadius = 18.0
        
        let sectionsWidthMultiplier = 0.9
        let sectionsHeightMultplier = 16.0
        
        let infoButtonTopPad = 1.5
        let infoButtonRightPad = 0.1
        
        return GeometryReader{ geometry in
            VStack{
//                ForEach(sectionNames, id: \.self){ sectionName in
                    ZStack{
                        Button(action: {
                            print("section button pressed!")
                        }, label: {
                            ZStack{
                                //Rectangle sections
                                HStack{
                                    RoundedRectangle(cornerRadius: sectionsCornerRadius)
                                        .frame(width: geometry.size.width * sectionsWidthMultiplier, height: geometry.size.height * sectionsHeightMultplier)
                                        .foregroundColor(sectionsColor)
                                }
                                if sectionName == "Calories" {
                                    sectionUIFunc(sectionName)
                                }
                                if sectionName == "Macros" {
                                    sectionUIFunc(sectionName)
                                }
                                if sectionName == "Daily Quote" {
                                    sectionUIFunc(sectionName)
                                }
                                
                                
                            }
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        if infoIncluded{
                            infoButton(sectionName)
                                .padding(.top, geometry.size.height * infoButtonTopPad)
                                .padding(.trailing, geometry.size.width * infoButtonRightPad)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        }
                    }
//                } ForEach
            }
        }
        
    }
    
    
    func rowWithColumns(columnNames: [String], sectionsColor: Color, sectionTextSize: CGFloat) -> some View {
        let cornerRadius = 20.0
        let sectionsWidthMultiplier = 0.43
        let sectionsHeightMultipler = 15.0
        
        let imageHeight = 42.0
        let imageWidth = 35.0
        let frameHSSpacing = 3.0
        
        return ZStack{
            GeometryReader{ geometry in
                HStack(spacing: 15){
                    ForEach(columnNames, id: \.self){columnName in
                        ZStack{
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .frame(width: geometry.size.width * sectionsWidthMultiplier, height: geometry.size.height * sectionsHeightMultipler)
                                .foregroundColor(sectionsColor)
                            VStack{
                                Spacer()
                                Text(columnName)
                                    .customFont(size: sectionTextSize)
                                    .foregroundColor(.white)
                                Spacer()
                                HStack{
                                    Spacer()
                                    if(columnName == "Water"){
                                        Image(systemName: "drop.fill")
                                            .resizable()
                                            .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("0%")
                                            .foregroundColor(.white)
                                        Spacer()

                                    }
                                    else if (columnName == "Logs"){
                                        Image(systemName: "note.text")
                                            .resizable()
                                            .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.white)
                                        Spacer()

                                    }
                                    
                                }
                                .frame(maxWidth: geometry.size.width / frameHSSpacing)
                                Spacer()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }


    }
    










