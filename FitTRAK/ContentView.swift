//
//  ContentView.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/16/23.
//

import SwiftUI
import HealthKit


struct ContentView: View {
//    @ObservedObject private var viewManager = ViewManager()
    var testTheme = ""
//    @State private var darkMode = false
    @Environment (\.colorScheme) var colorScheme
    @StateObject var colorTheme = ColorTheme()
//    private var healthStore: HealthStore?
//    @State private var stepsAdd: [Steps] = [Steps]()
        @State private var selectedTheme = 0
    private var repository = HKRepository()
    @State private var testString = "hello"
//    @StateObject var foodFactsViewModel = FoodFactsViewModel()

//    init(){
//        healthStore = HealthStore()
//    }
    
//    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
//        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
//        let endDate = Date()
//
//        statisticsCollection.enumerateStatistics(from: startDate, to: endDate){ (statistics, stop) in
//            let count = statistics.sumQuantity()?.doubleValue(for: .count())
//
//            let steps = Steps(count: Int(count ?? 0), date: statistics.startDate)
//            stepsAdd.append(steps)
//        }
//    }
    var body: some View {
//        List(stepsAdd, id: \.id) { step in
//            VStack(alignment: .leading){
//                Text("\(step.count)")
//                Text(step.date, style: .date)
//                    .opacity(0.5)
//            }
//            
//        }
        ZStack{
            
            TabView(selection: $selectedTheme) {
                NavigationViewDetails(title: "TRAK", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                    TRAKView(colorTheme: colorTheme)
                        .background(colorTheme.backgroundColor)
                }
                    .tabItem{
                        Text("TRAK")
                        Image(systemName: "bolt")
                        
                    }
                    .tag(0)
                
                
                VStack(alignment: .center){
                    NavigationViewDetails(title: "Log", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                        LogView()

                            .background(colorTheme.backgroundColor)
                    }
                    

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                    .tabItem {
                        Text("LOG")
                        Image(systemName: "plus")
                    }
                    .tag(1)
                
                NavigationViewDetails(title: "Fitness", leadingToolbarItem: "gear", trailingToolbarItem: "person.fill"){
                    FitnessView(colorTheme: colorTheme)
                        .background(colorTheme.backgroundColor)
                }
                        .tabItem{
                            Text("Fitness")
                            Image(systemName: "figure.run")
                            
                        }
                        .tag(2)
                
                
            }
            .onAppear(){
                repository.requestAuthorization{ success in
                    print("Auth success? \(success)")
                }
                print(colorScheme.hashValue)
                if colorScheme == .dark{
                    colorTheme.darkMode = true
                    print("dark mode set to true")
                } else {
                    colorTheme.darkMode = false
                    print("dark mode set to false")
                    
                }

                print(colorScheme)
//                print(viewManager.currentView)

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
            .task {
//                await foodFactsViewModel.getData()
            }
//            .onChange(of: viewManager.currentView, perform: { newCurrent in
//                print(viewManager.currentView)
//
//            })
            .foregroundColor(colorTheme.navTextColor)
            
            
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
