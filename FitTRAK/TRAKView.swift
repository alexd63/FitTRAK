//
//  TRAKView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import Foundation
import SwiftUI

enum SectionNames: String, CaseIterable {
    case calories = "Calories"
    case macros = "Macros"
    case water = "Water"
    case logs = "Logs"
}

struct TRAKView: View {
    private var darkMode: Bool
    private var backgroundColor: Color {
        darkMode ? Color.black : Color.white
    }
    private var sectionsColor: Color {
        darkMode ? Color.gray : Color.black
    }
    @State private var infoCardShowing = false

    private var cornerSectionsSize = CGSize(width: 15, height: 15)
    private var frameSectionsWidth = CGFloat(350)
    private var frameSectionsHeight = CGFloat(150)
        
//    private var sectionNames = ["Calories", "Macros", "Water", "Logs", "Five", "Six"]
    private var sectionIndex = 0 //keep track of
    

    init(darkMode: Bool){
        self.darkMode = darkMode
    }
    
    var body: some View{
        ZStack{
            NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                ScrollView{
                    ZStack{
                        VStack(spacing: 165){
                            addHorizontalSections(sectionNames: [SectionNames.calories.rawValue, SectionNames.macros.rawValue])
                                    .allowsHitTesting(infoCardShowing ? false : true) // dont allow section to be pressed

                            
                        }
                    }
                }
            }
            if infoCardShowing {
                infoCardView()
            }
        }
    }
    
    
    func addHorizontalSections(sectionNames: [String]) -> some View{
        let sectionsCornerRadius = 18.0
        
        let sectionsWidthMultiplier = 0.9
        let sectionsHeightMultplier = 16.0
        
        let infoButtonTopPad = 1.5
        let infoButtonRightPad = 0.1
        return GeometryReader{ geometry in
            VStack{
                ForEach(sectionNames.indices, id: \.self){
                    let sectionName = sectionNames[$0]
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
                                    caloriesSectionUI(sectionName: sectionName)
                                }
                                if sectionName == "Macros"{
                                    ZStack{
                                        macrosSectionUI(sectionName: sectionName)
                                        infoButton()
                                            .padding(.top, geometry.size.height * infoButtonTopPad)
                                            .padding(.trailing, geometry.size.width * infoButtonRightPad)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    }
                                    
                                }
                                
                            }
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        
                    }
                    
 
                }
            }
        }
    }
    
//    func rowWithColumns(columnNames: [String]) -> some View {
//
//    }
    
    func caloriesSectionUI(sectionName: String) -> some View {
        //var cornerRadius: CGSize = CGSize(width: 5, height: 5)
        VStack(spacing: 0){
            HStack(alignment: .top){
                Text(sectionName)
                    .foregroundColor(.white)
                    .customFont(size: 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 55)
            .padding(.bottom, 20)
            
            //Progress bars
            ZStack(alignment: .leading){
                
                //Background Bar
                Rectangle()
                    .frame(maxWidth: 300, maxHeight: 20)
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                ZStack(alignment: .trailing){
                    Rectangle()
                        .frame(width: 30, height: 20, alignment: .leading)
                        .foregroundColor(.blue)
                        .padding(.bottom, 25)
                    Rectangle()
                        .frame(width: 12, height: 20, alignment: .trailing)
                        .foregroundColor(.red)
                        .padding(.bottom, 25)
                        .padding(.leading, 0)
                }
            }
            Text("2000")
                .foregroundColor(.white)
                .customFont(size: 25)
        }
    }
    
    func macrosSectionUI(sectionName: String) -> some View{
        let macrosCornerRadius: CGSize = CGSize(width: 5, height: 5)
        let macrosTextSize = 18.0
        let macrosLeftPad = 55.0
        let macrosBottomPad = 10.0
        let macrosWidth = 40.0
        let macrosHeight = 60.0
        
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
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerSize: macrosCornerRadius)
                                .frame(maxWidth: macrosWidth, maxHeight: macrosHeight)
                                .foregroundColor(.white)
                        }
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerSize: macrosCornerRadius)
                            .frame(maxWidth: macrosWidth, maxHeight: macrosHeight)
                            .foregroundColor(.white)
                    }
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerSize: macrosCornerRadius)
                            .frame(maxWidth: macrosWidth, maxHeight: macrosHeight)
                            .foregroundColor(.white)
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
    func infoButton() -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)){
                infoCardShowing = true
            }
            print("info card is: \(infoCardShowing)")
        }, label: {
            Image(systemName: "info.circle")
                .background(Rectangle().fill(Color.clear))
        })
        .foregroundColor(.blue)
    }
    
    func infoCardView() -> some View {
        let cardCornerRadius = 20.0
        let widthMultiplier = 0.8
        let heightMultiplier = 0.23
        let xPosDivider = 2.0
        let yPosDivider = 7.0
        
        let cardOpacity = 0.95
        let xTextPosDivider = 45.0
        let frameTextWidthMultiplier = 0.7
        
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
                    Text("Macronutrients are the main nutrients our bodies need in large amounts for energy and proper functioning.\n C - Carbs, F - Fats\n P - Proteins")
                        .customFont(size: geometry.size.height / xTextPosDivider)
                        .frame(width: geometry.size.width * frameTextWidthMultiplier)

                    
                }
                .position(CGPoint(x:geometry.size.width / xPosDivider, y: geometry.size.height / yPosDivider))
               
                if infoCardShowing {
                    Color.clear
                        .contentShape(Rectangle())
                        .ignoresSafeArea(.all)
                        .onTapGesture{
                            infoCardShowing = false
                        }
                }
            }
            
        }
    }
    
//    func waterAndLogs() -> some View {
//        GeometryReader{ geometry in
//            RoundedRectangle(cornerRadius: 20)
//                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height )
//        }
//    }


}


struct TRAKView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
