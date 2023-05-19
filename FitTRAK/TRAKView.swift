//
//  TRAKView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI
import SwiftUICharts

//enum SectionNames: String, CaseIterable {
//    case calories = "Calories"
//    case macros = "Macros"
//    case water = "Water"
//    case logs = "Logs"
//    case quote = "Daily Quote"
//}

struct TRAKView: View {
    @ObservedObject var colorTheme: ColorTheme
//    @ObservedObject private var viewManager: ViewManager
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
//        self.viewManager = viewManager
    }
    
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack{

                //Note: removed it from here because NavigationView should be on top level before the ZStack. (Moved to ContentView instead)
//                NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                    ScrollView{
                        ZStack{
                            VStack(spacing: 160){

                                
                                //Calories section
                                sections.addHorizontalSections(sectionName: names.calories.rawValue, sectionsColor: colorTheme.sectionsColor, sectionUIFunc: {sectionName in
                                    caloriesSectionUI(sectionName: names.calories.rawValue)
                                }, infoButton: {sectionName in
                                    infoButton(sectionName: names.calories.rawValue)
                                }, healthAccess: true)
                                
                                //macros section
                                sections.addHorizontalSections(sectionName: names.macros.rawValue, sectionsColor: colorTheme.sectionsColor, sectionUIFunc: {sectionName in
                                    macrosSectionUI(sectionName: names.macros.rawValue)
                                }, infoButton: {sectionName in
                                    infoButton(sectionName: names.macros.rawValue)
                                }, healthAccess: true)
                                
                                //water and logs columns
                                sections.rowWithColumns(columnNames: [names.water.rawValue, names.logs.rawValue], sectionsColor: colorTheme.sectionsColor, sectionTextSize: sectionTextSize, healthAccessAtIndex: [true], navigationLinkFor: [Sections.SectionNames.water.rawValue])
                                
                                
                                //daily quote
                                sections.addHorizontalSections(sectionName: names.quote.rawValue, sectionsColor: colorTheme.sectionsColor, sectionUIFunc: {sectionName in
                                    quoteSectionUI(sectionName: names.quote.rawValue)//probably dont need this parameter
                                })
                                .padding(.top, -10)

//                                BarChartView(data: ChartData(values: [("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)]), title: "Sales", legend: "Quarterly", form: CGSize(width: 100, height: 100))
//                                    // legend is optional
                            }
                        }
                    }
//                } nav view
            }
            if infoCardShowing {
                infoCardView(sectionName: currentInfoCard)
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
