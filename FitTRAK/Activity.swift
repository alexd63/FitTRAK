//
//  Activity.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/28/23.
//

import Foundation


struct Activity: Identifiable {
    var id: String
    var name: String?
    var image: String?
        
    static func allActivities() -> [Activity] {
        return [
        Activity(id: "Calories", name: "Calories", image: "lightningSymbol"),
        Activity(id: "Exercise", name: "Exercise", image: "jofen"),
        Activity(id: "appleStandTime", name: "Stand Time", image: "jpiogs"),
        Activity(id: "Distance", name: "Distance", image: "grioj"),
        Activity(id: "stepCount", name: "Step Count", image: "ohit"),
        Activity(id: "Water", name: "Water", image: "ohiegt"),
        Activity(id: "Macros", name: "Macros", image: "ohiegt"),
        Activity(id: "Fats", name: "Fat", image: "ohiegt"),
        Activity(id: "Proteins", name: "Proteins", image: "ohiegt"),
        Activity(id: "Carbs", name: "Carbs", image: "ohiegt")
        

        
        ]
        
    }
}
