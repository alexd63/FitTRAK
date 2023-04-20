//
//  UserDetails.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/20/23.
//

import Foundation
import SwiftUI

class UserDetails {
    //Main user parameters
    var weight: Int
    var age: Int
    var height: Int //entered in cm or convert to cm
    var activityLevel: ActivityLevel
    
    //User Tracking Details
    var calories: Int
    var proteins: Int
    var carbs: Int
    var fats: Int

    init(weight: Int, age: Int, height: Int, activityLevel: ActivityLevel, calories: Int, proteins: Int, carbs: Int, fats: Int) {
        self.weight = weight
        self.age = age
        self.height = height
        self.activityLevel = activityLevel
        self.calories = calories
        self.proteins = proteins
        self.carbs = carbs
        self.fats = fats
    }
    
    
}

enum ActivityLevel: String {
    case sedentary = "Sedentary"
    case light = "Light"
    case moderate = "Moderate"
    case high = "High"
    case extreme = "Extreme"
}
