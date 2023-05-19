////
////  Sections.swift
////  FitTRAK
////
////  Created by Alex Diaz on 4/23/23.
////
//
import Foundation
import SwiftUI
import SwiftUICharts
//

struct Sections {

//    @ObservedObject private var viewManager: ViewManager
    private var repository = HKRepository()

    public enum SectionNames: String, CaseIterable {
        case calories = "Calories"
        case macros = "Macros"
        
        //TRAKView
        case water = "Water"
        case logs = "Logs"
        case quote = "Daily Quote"
        
        //Fitness View
        case exercise = "Exercise"
        case steps = "Steps"
        case weight = "Weight"
        case dailyGoal = "DailyGoal"
        case distance = "Distance"
        
        case fats = "Fats"
        case carbs = "Carbs"
        case proteins = "Proteins"
        
    }
    
    func addHorizontalSections(
        sectionName: String,
        sectionsColor: Color,
        sectionUIFunc: @escaping (_ sectionName: String) -> some View,
        infoButton: @escaping (_ sectionName: String) -> some View = {_ in EmptyView()},
        healthAccess: Bool = false) -> some View
        {
        var activity = Activity(id: sectionName)

        let sectionsCornerRadius = 18.0
        
        let sectionsWidthMultiplier = 0.9
        let sectionsHeightMultplier = 16.0
        
        let infoButtonTopPad = 1.5
        let infoButtonRightPad = 0.1
        
        return GeometryReader{ geometry in
            VStack{
                    ZStack{
                            NavigationLink(destination: DetailView(activity: activity, repository: repository), label: {
                                ZStack{
                                    //Rectangle sections
                                    HStack{
                                        RoundedRectangle(cornerRadius: sectionsCornerRadius)
                                            .frame(width: geometry.size.width * sectionsWidthMultiplier, height: geometry.size.height * sectionsHeightMultplier)
                                            .foregroundColor(sectionsColor)
                                    }
                                    
                                    sectionUIFunc(sectionName)
                                    
                                }
                            })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                            infoButton(sectionName)
                                .padding(.top, geometry.size.height * infoButtonTopPad)
                                .padding(.trailing, geometry.size.width * infoButtonRightPad)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        
                    }
//                } ForEach
            }
        }
        
    }
    
    
    func rowWithColumns(columnNames: [String], sectionsColor: Color, sectionTextSize: CGFloat, healthAccessAtIndex: [Bool] = [], navigationLinkFor: [String] = []) -> some View {
        let cornerRadius = 20.0
        let sectionsWidthMultiplier = 0.43
        let sectionsHeightMultipler = 15.0
        
        let imageHeight = 42.0
        let imageWidth = 35.0
        let frameHSSpacing = 3.0
        
        let barHeight = 70.0
        let barWidth = 30.0
        var progressBar = 20.0
        var currentSteps = 5500
        var stepsLeft = 5500
        var currentWeight = 155
        var goalWeight = 155
        
        
        return ZStack{
            GeometryReader{ geometry in
                HStack(spacing: 15){
                    ForEach(columnNames.indices, id: \.self){index in
                        let columnName = columnNames[index]
                        
                        //For Sections with Health access
                        if (!healthAccessAtIndex.isEmpty) && (navigationLinkFor.contains(columnName) && healthAccessAtIndex[index]) {
                            let activity = Activity(id: columnName)
                            NavigationLink(destination: DetailView(activity: activity, repository: repository), label: {
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
                                        if(columnName == SectionNames.water.rawValue){
                                            Image(systemName: "drop.fill")
                                                .resizable()
                                                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("0%")
                                                .foregroundColor(.white)
                                            Spacer()
                                            
                                        }
                                        else if (columnName == SectionNames.logs.rawValue){
                                            Image(systemName: "note.text")
                                                .resizable()
                                                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.white)
                                            Spacer()
                                            
                                        }
                                        else if (columnName == SectionNames.steps.rawValue) {
                                            VStack(alignment: .leading){
                                                Spacer()
                                                Text("Current: \(currentSteps)")
                                                    .customFont(size: 15)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("Left: \(stepsLeft)")
                                                    .foregroundColor(.white)
                                                    .customFont(size: 15)
                                                Spacer()
                                                
                                            }
                                            Spacer()
                                            ZStack(alignment: .bottom){
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: barHeight)
                                                    .foregroundColor(.white)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: progressBar)
                                                    .foregroundColor(.red)
                                            }
                                            Spacer()
                                        }
                                        
                                        else if (columnName == SectionNames.weight.rawValue) {
                                            VStack(alignment: .leading){
                                                Spacer()
                                                Text("Current: \(currentWeight)")
                                                    .customFont(size: 15)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("Left: \(goalWeight)")
                                                    .foregroundColor(.white)
                                                    .customFont(size: 15)
                                                Spacer()
                                                
                                            }
                                            Spacer()
                                            ZStack(alignment: .bottom){
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: barHeight)
                                                    .foregroundColor(.white)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: progressBar)
                                                    .foregroundColor(.red)
                                            }
                                            Spacer()
                                        }
                                        
                                        
                                    }
                                    .frame(maxWidth: geometry.size.width / frameHSSpacing)
                                    Spacer()
                                }
                            }
                        })
                        }
                        //for Sections with Custom Views with label creation
                        else if navigationLinkFor.contains(columnName) && (healthAccessAtIndex.isEmpty || !healthAccessAtIndex[index]) {
                            NavigationLink(destination: EmptyView(), label: {
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
                                        if(columnName == SectionNames.water.rawValue){
                                            Image(systemName: "drop.fill")
                                                .resizable()
                                                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("0%")
                                                .foregroundColor(.white)
                                            Spacer()
                                            
                                        }
                                        else if (columnName == SectionNames.logs.rawValue){
                                            Image(systemName: "note.text")
                                                .resizable()
                                                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.white)
                                            Spacer()
                                            
                                        }
                                        else if (columnName == SectionNames.steps.rawValue) {
                                            VStack(alignment: .leading){
                                                Spacer()
                                                Text("Current: \(currentSteps)")
                                                    .customFont(size: 15)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("Left: \(stepsLeft)")
                                                    .foregroundColor(.white)
                                                    .customFont(size: 15)
                                                Spacer()
                                                
                                            }
                                            Spacer()
                                            ZStack(alignment: .bottom){
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: barHeight)
                                                    .foregroundColor(.white)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: progressBar)
                                                    .foregroundColor(.red)
                                            }
                                            Spacer()
                                        }
                                        
                                        else if (columnName == SectionNames.weight.rawValue) {
                                            VStack(alignment: .leading){
                                                Spacer()
                                                Text("Current: \(currentWeight)")
                                                    .customFont(size: 15)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("Left: \(goalWeight)")
                                                    .foregroundColor(.white)
                                                    .customFont(size: 15)
                                                Spacer()
                                                
                                            }
                                            Spacer()
                                            ZStack(alignment: .bottom){
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: barHeight)
                                                    .foregroundColor(.white)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: progressBar)
                                                    .foregroundColor(.red)
                                            }
                                            Spacer()
                                        }
                                        
                                        
                                    }
                                    .frame(maxWidth: geometry.size.width / frameHSSpacing)
                                    Spacer()
                                }
                            }
                        })
                        }
                        else {
                            //only section view (no navigation link)
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
                                        if(columnName == SectionNames.water.rawValue){
                                            Image(systemName: "drop.fill")
                                                .resizable()
                                                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("0%")
                                                .foregroundColor(.white)
                                            Spacer()
                                            
                                        }
                                        else if (columnName == SectionNames.logs.rawValue){
                                            Image(systemName: "note.text")
                                                .resizable()
                                                .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.white)
                                            Spacer()
                                            
                                        }
                                        else if (columnName == SectionNames.steps.rawValue) {
                                            VStack(alignment: .leading){
                                                Spacer()
                                                Text("Current: \(currentSteps)")
                                                    .customFont(size: 15)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("Left: \(stepsLeft)")
                                                    .foregroundColor(.white)
                                                    .customFont(size: 15)
                                                Spacer()
                                                
                                            }
                                            Spacer()
                                            ZStack(alignment: .bottom){
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: barHeight)
                                                    .foregroundColor(.white)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: progressBar)
                                                    .foregroundColor(.red)
                                            }
                                            Spacer()
                                        }
                                        
                                        else if (columnName == SectionNames.weight.rawValue) {
                                            VStack(alignment: .leading){
                                                Spacer()
                                                Text("Current: \(currentWeight)")
                                                    .customFont(size: 15)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("Goal: \(goalWeight)")
                                                    .foregroundColor(.white)
                                                    .customFont(size: 15)
                                                Spacer()
                                                
                                            }
                                            Spacer()
                                            ZStack(alignment: .bottom){
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: barHeight)
                                                    .foregroundColor(.white)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(maxWidth: barWidth, maxHeight: progressBar)
                                                    .foregroundColor(.red)
                                            }
                                            Spacer()
                                        }
                                        
                                        
                                    }
                                    .frame(maxWidth: geometry.size.width / frameHSSpacing)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }


    }
    










