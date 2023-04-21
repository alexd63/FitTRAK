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
        
    private var sectionNames = ["Calories", "Macros", "Three", "Four", "Five", "Six"]

    init(darkMode: Bool){
        self.darkMode = darkMode
    }
    
    
    
    var body: some View{
        ZStack{
            NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                ScrollView{
                        VStack(spacing: 165){
                            ForEach(0..<5) { sectionCount in
                                    sections(sectionName: sectionNames[sectionCount], sectionCount: sectionCount)
                                
                            }
                        }
                    }
            }
        }
    }
    func sections(sectionName: String, sectionCount: Int) -> some View{
        GeometryReader{ geometry in
            ZStack{
            Button(action: {
                print("section button pressed!")
            }, label: {
                ZStack{
                    HStack{
                        RoundedRectangle(cornerSize: CGSize(width: 18, height: 18))
                        
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 16)
                            .foregroundColor(sectionsColor)
                    }
                    if sectionName == "Calories" {
                        caloriesSection(sectionName: sectionName)
                    }
                    if sectionName == "Macros"{
                        
                    }
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
              

        }
            
        }
    }
    
    func caloriesSection(sectionName: String) -> some View {
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
            
            //Progress bars(Calories)
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
}


struct TRAKView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
