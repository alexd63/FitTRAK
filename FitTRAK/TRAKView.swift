//
//  TRAKView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

//enum SectionNames: String, CaseIterable {
//    case calories = "Calories"
//    case macros = "Macros"
//    case water = "Water"
//    case logs = "Logs"
//    case quote = "Daily Quote"
//}

struct TRAKView: View {
    @ObservedObject var colorTheme: ColorTheme
//    private var backgroundColor: Color {
//        colorTheme.darkMode ? Color.black : Color.white
//    }
//    private var sectionsColor: Color {
//        colorTheme.darkMode ? Color.gray : Color.black
//    }
    @State private var infoCardShowing = false
    
    private var cornerSectionsSize = CGSize(width: 15, height: 15)
    private var frameSectionsWidth = CGFloat(350)
    private var frameSectionsHeight = CGFloat(150)
    private let sectionTextSize = 18.0
    @State private var currentInfoCard: String = "none"
    
    private var sections = Sections()
    private var names = Sections.SectionNames.self
        
    init(colorTheme: ColorTheme){
        self.colorTheme = colorTheme
    }
    
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                    ScrollView{
                        ZStack{
                            VStack(spacing: 160){
//                                addHorizontalSections(sectionNames: [SectionNames.calories.rawValue, SectionNames.macros.rawValue], infoAtSection: [SectionNames.calories.rawValue, SectionNames.macros.rawValue])
//                                    .allowsHitTesting(infoCardShowing ? false : true) // dont allow section to be pressed
                                
                                //Calories section
                                sections.addHorizontalSections(sectionName: names.calories.rawValue, sectionsColor: colorTheme.sectionsColor, sectionUIFunc: {sectionName in
                                    caloriesSectionUI(sectionName: names.calories.rawValue)
                                }, infoIncluded: true, infoButton: {sectionName in
                                    infoButton(sectionName: names.calories.rawValue)
                                })
                                
                                //macros section
                                sections.addHorizontalSections(sectionName: names.macros.rawValue, sectionsColor: colorTheme.sectionsColor, sectionUIFunc: {sectionName in
                                    macrosSectionUI(sectionName: names.macros.rawValue)
                                }, infoIncluded: true, infoButton: {sectionName in
                                    infoButton(sectionName: names.macros.rawValue)
                                })
                                
                                //water and logs columns
                                sections.rowWithColumns(columnNames: [names.water.rawValue, names.logs.rawValue], sectionsColor: colorTheme.sectionsColor, sectionTextSize: sectionTextSize)
                                
                                //daily quote
                                sections.addHorizontalSections(sectionName: names.quote.rawValue, sectionsColor: colorTheme.sectionsColor, sectionUIFunc: {sectionName in
                                    quoteSectionUI(sectionName: names.quote.rawValue)//probably dont need this parameter
                                }, infoIncluded: true, infoButton:{ sectionName in infoButton(sectionName:names.calories.rawValue)
                                    
                                })

                                
//                                section
//                                Spacer(minLength: 10)
                                
//                                rowWithColumns(columnNames: [SectionNames.water.rawValue, SectionNames.logs.rawValue])
//
//                                addHorizontalSections(sectionNames: [SectionNames.quote.rawValue])
//                                    .padding(.top, -10)
                                //                                rowWithColumns(columnNames: [SectionNames.water.rawValue, SectionNames.logs.rawValue])
                                
                                //next idea: add weight tracking
//                                addHorizontalSections(sectionNames: [SectionNames.quote.rawValue])

//                                sections.addHorizontalSections(sectionNames: ["Weight"], sectionsColor: sectionsColor, sectionUIFunc: {sectionName in
//                                    caloriesSectionUI(sectionName: "Cals")
//                                }, infoButton: {sectionName in
//                                    infoButton(sectionName: "Cals")
//                                })
                            }
                        }
                    }
                }
            }
            if infoCardShowing {
                infoCardView(sectionName: currentInfoCard)
            }
        }
    }
        
    
    
//    func addHorizontalSections(sectionNames: [String], infoAtSection: [String]? = nil) -> some View {
//        let sectionsCornerRadius = 18.0
//        
//        let sectionsWidthMultiplier = 0.9
//        let sectionsHeightMultplier = 16.0
//        
//        let infoButtonTopPad = 1.5
//        let infoButtonRightPad = 0.1
//        
//        return GeometryReader{ geometry in
//            VStack(spacing: 10){
//                ForEach(sectionNames, id: \.self){ sectionName in
//                    ZStack{
//                        Button(action: {
//                            print("section button pressed!")
//                        }, label: {
//                            ZStack{
//                                //Rectangle sections
//                                HStack{
//                                    RoundedRectangle(cornerRadius: sectionsCornerRadius)
//                                        .frame(width: geometry.size.width * sectionsWidthMultiplier, height: geometry.size.height * sectionsHeightMultplier)
//                                        .foregroundColor(sectionsColor)
//                                }
//                                if sectionName == "Calories" {
//                                    caloriesSectionUI(sectionName: sectionName)
//                                }
//                                if sectionName == "Macros" {
//                                    macrosSectionUI(sectionName: sectionName)
//                                }
//                                if sectionName == "Daily Quote" {
//                                    quoteSectionUI(sectionName: sectionName)
//                                }
//                                
//                                
//                            }
//                        })
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        
//                        if infoAtSection?.contains(sectionName) == true{
//                            infoButton(sectionName: sectionName)
//                                .padding(.top, geometry.size.height * infoButtonTopPad)
//                                .padding(.trailing, geometry.size.width * infoButtonRightPad)
//                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
//                        }
//                    }
//                }
//            }
//        }
//        
//    }
    
    
    func rowWithColumns(columnNames: [String]) -> some View {
        let cornerRadius = 20.0
        let sectionsWidthMultiplier = 0.43
        let sectionsHeightMultipler = 15.0
        
        let imageHeight = 42.0
        let imageWidth = 35.0
        let frameHSSpacing = 3.0
        
        //        var calculateSpace: CGFloat {
        //            var mustEqual = frameHSSpacing
        //            var totalWidthHeight = imageWidth + imageHeight
        //            var difference = mustEqual - totalWidthHeight
        //            var newValue = difference + totalWidthHeight
        //            return newValue
        //        }
        // 175 =
        return ZStack{
            GeometryReader{ geometry in
                HStack(spacing: 15){
                    ForEach(columnNames, id: \.self){columnName in
                        ZStack{
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .frame(width: geometry.size.width * sectionsWidthMultiplier, height: geometry.size.height * sectionsHeightMultipler)
                                .foregroundColor(colorTheme.sectionsColor)
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
                                    }
                                    else if (columnName == "Logs"){
                                        Image(systemName: "note.text")
                                            .resizable()
                                            .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                                            .foregroundColor(.white)
                                    }
                                    
                                    Spacer()
                                    Text("0%")
                                        .foregroundColor(.white)
                                    Spacer()
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
    
    func caloriesSectionUI(sectionName: String) -> some View {
        let totalKcalTextSize = 18.0
//        let totalKcalBar
        let barHeight = 20.0
        let totalBarSize = 300.0
        let totalCalories = 2000.0
        let caloriesConsumed = 2000.0
        let activeCalories = 100.0
        
        var netCalories = totalCalories - caloriesConsumed + activeCalories
        var calculateKcalBar: CGFloat {
            var barRatio = caloriesConsumed / totalCalories
            var calculatedBar = totalBarSize * barRatio
            if calculatedBar >= totalBarSize{
                calculatedBar = totalBarSize
            }
            
            return calculatedBar
        }
        
        var calculateNetKcalBar: CGFloat { //NOT WORKING
            
            
            var barRatio = activeCalories / totalCalories
            var calculatedBar = totalBarSize * barRatio
            
            if calculateKcalBar >= totalBarSize {
                barRatio = calculatedBar / netCalories
                calculatedBar = calculatedBar * barRatio
                return calculatedBar
            }
            
            
            
            

            return calculatedBar
        }

        
        return VStack(spacing: 0){
            Spacer(minLength: 17)
            HStack(alignment: .top){
                Text(sectionName)
                    .foregroundColor(.white)
                    .customFont(size: sectionTextSize)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 55)
            .padding(.bottom, 20)
            
            //Progress bars
            ZStack(alignment: .leading){
                
                //Background Bar
                Rectangle()
                    .frame(maxWidth: totalBarSize, maxHeight: barHeight)
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                ZStack(alignment: .trailing){
                    Rectangle()
                        .frame(width: calculateKcalBar, height: barHeight, alignment: .leading)
                        .foregroundColor(.blue)
                        .padding(.bottom, 25)
                    Rectangle()
                        .frame(width: calculateNetKcalBar, height: barHeight, alignment: .trailing)
                        .foregroundColor(.red)
                        .padding(.bottom, 25)
                        .padding(.leading, 0)
                }
            }
            HStack(){
                VStack{
                    Text("\(totalCalories.formatted())")
                        .foregroundColor(.white)
                        .customFont(size: totalKcalTextSize)
                    Spacer()
                    Text("(Total)")
                        .foregroundColor(.white)
                        .customFont(size: 13)
                }
                
                VStack{
                    Text("-")
                        .foregroundColor(.white)
                        .customFont(size: totalKcalTextSize)
                    Spacer()
                }
                VStack{
                    Text("\(caloriesConsumed.formatted())")
                        .foregroundColor(.white)
                        .customFont(size: totalKcalTextSize)
                    Spacer()
                    Text("(Ate)")
                        .foregroundColor(.white)
                        .customFont(size: 13)
                    
                }
                VStack{
                    Text("+")
                        .foregroundColor(.white)
                        .customFont(size: totalKcalTextSize)
                    Spacer()
                }
                VStack{
                    Text("\(activeCalories.formatted())")
                        .foregroundColor(.white)
                        .customFont(size: totalKcalTextSize)
                    Spacer()
                    Text("(Used)")
                        .foregroundColor(.white)
                        .customFont(size: 13)
                    
                }
                VStack{
                    Text("=")
                        .foregroundColor(.white)
                        .customFont(size: totalKcalTextSize)
                    Spacer()
                    
                }

                VStack{
                    Text("\(netCalories.formatted())")
                        .foregroundColor(.white)
                        .customFont(size: totalKcalTextSize)
                    Spacer()
                    Text("(Left)")
                        .foregroundColor(.white)
                        .customFont(size: 13)
                    
                }
            }
            Spacer()
        }
    }
    
    func macrosSectionUI(sectionName: String) -> some View{
        let macrosCornerRadius: CGSize = CGSize(width: 5, height: 5)
        let macrosTextSize = 18.0
        let macrosLeftPad = 55.0
        let macrosBottomPad = 10.0
        let macrosWidth = 40.0
        let macrosHeight = 60.0
        
        var carbsProgress = 20.0
        var fatsProgress = 20.0
        var proteinsProgress = 20.0
        
        let progressHSSpacing = 70.0
        let cfpSize = 20.0
        let cfpHSSpacing = 98.0
        let cfgBottomPadding = 8.0
        
        return VStack(spacing: 0){
            HStack(){
                Text(sectionName)
                    .foregroundColor(.white)
                    .customFont(size: macrosTextSize)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .padding(.leading, macrosLeftPad)
            .padding(.bottom, macrosBottomPad)
            
            //Progress bars
            HStack(spacing: progressHSSpacing){
                ZStack (alignment: .bottom){
                    RoundedRectangle(cornerSize: macrosCornerRadius)
                        .frame(maxWidth: macrosWidth, maxHeight: macrosHeight)
                        .foregroundColor(.white)
                    
                    RoundedRectangle(cornerSize: macrosCornerRadius)
                        .frame(maxWidth: macrosWidth, maxHeight: carbsProgress)
                        .foregroundColor(.blue)
                }
//                .overlay(.green)
                ZStack(alignment: .bottom){
                    RoundedRectangle(cornerSize: macrosCornerRadius)
                        .frame(maxWidth: macrosWidth, maxHeight: macrosHeight)
                        .foregroundColor(.white)
                    
                    RoundedRectangle(cornerSize: macrosCornerRadius)
                        .frame(maxWidth: macrosWidth, maxHeight: carbsProgress)
                        .foregroundColor(.red)
                }
                ZStack(alignment: .bottom){
                    RoundedRectangle(cornerSize: macrosCornerRadius)
                        .frame(maxWidth: macrosWidth, maxHeight: macrosHeight)
                        .foregroundColor(.white)
                    
                    RoundedRectangle(cornerSize: macrosCornerRadius)
                        .frame(maxWidth: macrosWidth, maxHeight: carbsProgress)
                        .foregroundColor(.purple)
                }
            }
            HStack(spacing: cfpHSSpacing){
                
                Text("C")
                    .foregroundColor(.white)
                    .customFont(size: cfpSize)
                Text("F")
                    .foregroundColor(.white)
                    .customFont(size: cfpSize)
                Text("P")
                    .foregroundColor(.white)
                    .customFont(size: cfpSize)
                
            }.padding(.top, cfgBottomPadding)
            
        }
    }
    
    func infoButton(sectionName: String) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)){
                infoCardShowing = true
            }
            currentInfoCard = sectionName
            print("info card is: \(infoCardShowing)")
        }, label: {
            Image(systemName: "info.circle")
                .background(Rectangle().fill(Color.clear))
        })
        .foregroundColor(.blue)
    }
    
    func infoCardView(sectionName: String) -> some View {
        let cardCornerRadius = 20.0
        let widthMultiplier = 0.85
        let heightMultiplier = 0.3
        let xPosDivider = 2.0
        let yPosDivider = 2.0
        
        let cardOpacity = 0.95
        let xTextPosDivider = 45.0
        let frameTextWidthMultiplier = 0.8
        
        var explanationText: String {
            
            if sectionName == "Macros"{
                return "Macronutrients are the main nutrients our bodies need in large amounts for energy and proper functioning.\n C - Carbs, F - Fats\n P - Proteins"
            }
            
            else if sectionName == "Calories"{
                return "Calories are a unit used to express the amount of energy that food provides. They are essential as they fuel our daily activities and maintain vital bodily functions."
            }
            else {
                return "ERROR: Section name not found"
            }
            
        }
        
        return ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .frame(width: geometry.size.width * widthMultiplier, height: geometry.size.height * heightMultiplier)
                    .position(CGPoint(x:geometry.size.width / xPosDivider, y: geometry.size.height / yPosDivider))
                    .foregroundColor(.green)
                    .opacity(infoCardShowing ? cardOpacity : 0)
                
                VStack{
                    Text("What is this?")
                        .customFont(size: geometry.size.height / xTextPosDivider)
                    Text(explanationText)
                        .customFont(size: geometry.size.height / xTextPosDivider)
                        .frame(width: geometry.size.width * frameTextWidthMultiplier)
                    
                    
                }
                .position(CGPoint(x:geometry.size.width / xPosDivider, y: geometry.size.height / yPosDivider))
                
                if infoCardShowing {
                    //tappable clear background
                    Color.clear
                        .contentShape(Rectangle())
                        .ignoresSafeArea(.all)
                        .onTapGesture{
                            infoCardShowing = false
                            currentInfoCard = "none"
                        }
                }
            }
            
        }
    }
    
    func quoteSectionUI(sectionName: String) -> some View {
        let quoteTextSize = 22.0
        return VStack{
            Text(sectionName)
                .customFont(size: quoteTextSize)
                .foregroundColor(.white)
            
            //the quote will go here
            Text("\"placeholder quote\"")
                .customFont(size: quoteTextSize - 2)
                .foregroundColor(.white)
        }
    }
    
    }


struct TRAKView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
