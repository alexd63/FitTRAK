//
//  HealthStat.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/28/23.
//

import Foundation
import HealthKit

struct HealthStat: Identifiable {
    let id = UUID()
    let statType: String
    let stat: HKQuantity?
    let date: Date
}
