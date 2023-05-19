//
//  HKRepository.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/28/23.
//

import Foundation
import HealthKit

final class HKRepository {
    var store: HKHealthStore?
    
    let allTypes = Set([
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
        HKObjectType.quantityType(forIdentifier: .appleMoveTime)!,
        HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!,
        HKObjectType.quantityType(forIdentifier: .dietaryProtein)!,
        HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
        HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
        HKObjectType.quantityType(forIdentifier: .dietaryWater)!
        ])
    
    var query: HKStatisticsCollectionQuery?
    
    
    var dietaryFat: HKQuantityTypeIdentifier = .dietaryFatTotal
    var dietaryProtein: HKQuantityTypeIdentifier = .dietaryProtein
    var dietaryCarbs: HKQuantityTypeIdentifier = .dietaryCarbohydrates
    
    init() {
        store = HKHealthStore()
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let store = store else { //make sure store is initialize
            return
        }
        store.requestAuthorization(toShare: [], read: allTypes) { success, error in
            completion(success)
        }
    }
    
    
    
    func requestHealthStat(by category: String, completion: @escaping ([HealthStat]) -> Void) {
        guard let store = store, let type = HKObjectType.quantityType(forIdentifier: typeByCategory(category: category)) else {
            return
        }
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let endDate = Date()
        let anchorDate = Date.firstDayOfWeek()
        let dailyComponent = DateComponents(day: 1) //every day where going to collect the data
        
        var healthStats = [HealthStat]()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        

        query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: dailyComponent)
        
        query?.initialResultsHandler = { query, statistics, error in
            statistics?.enumerateStatistics(from: startDate, to: endDate) { stats, _ in
                let stat = HealthStat(statType: category, stat: stats.sumQuantity(), date: stats.startDate)
                healthStats.append(stat)
            }
            completion(healthStats)
        }
        
        guard let query = query else {
            return
        }
        store.execute(query)
    }
    
    private func typeByCategory(category: String) -> HKQuantityTypeIdentifier {
        switch category {
        case "Calories":
            return .activeEnergyBurned
        case "Exercise":
            return .appleExerciseTime
        case "appleStandTime":
            return .appleStandTime
        case "Distance":
            return .distanceWalkingRunning
        case "stepCount":
            return .stepCount
        case "Water":
            return .dietaryWater
        case "Macros":
            return .dietaryFatTotal
        case "Fat":
            return dietaryFat // place a flag here to activate MacrosChartView
        case "Proteins":
            return dietaryProtein
        case "Carbs":
            return dietaryCarbs
        default:
            return .stepCount
        }
    }
}
