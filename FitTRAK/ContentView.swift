//
//  ContentView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import SwiftUI



struct ContentView: View {
    @State private var selectedTheme = 0
//    @State private var darkMode = false
    @Environment (\.colorScheme) var colorScheme
    @StateObject var colorTheme = ColorTheme()
    
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedTheme) {
                TRAKView(colorTheme: colorTheme)
                    .tabItem{
                        Text("TRAK")
                        Image(systemName: "bolt")
                        
                    }
                    .tag(0)
                FitnessView()
                    .tabItem{
                        Text("Fitness")
                        Image(systemName: "figure.run")
                        
                    }
                    .tag(1)
                
                
            }
            .onAppear(){
                print(colorScheme.hashValue)
                if colorScheme == .dark{
                    colorTheme.darkMode = true
                    print("dark mode set to true")
                } else {
                    colorTheme.darkMode = false
                    print("dark mode set to false")
                    
                }
                print(colorScheme)
            }
            .onChange(of: colorScheme, perform: { newThemeValue in
                if newThemeValue == .dark{
                    colorTheme.darkMode = true
                    print("dark mode set to true")
                } else {
                    colorTheme.darkMode = false
                    print("dark mode set to false")
                    
                }
                print(newThemeValue)
                
            })
            .foregroundColor(Color.black)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
