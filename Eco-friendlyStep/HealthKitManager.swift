//
//  HealthKitManager.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/06.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    //health 데이터 접근이 가능한지 체크, 얻고자 하는 데이터 정의(flightsClimbed),사용자에게 권한 요청하는 팝업
    func setUpHealthRequest(healthStore: HKHealthStore, readSteps: @escaping () -> Void) {
        if HKHealthStore.isHealthDataAvailable(), let flightsClimbed = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed) {
            healthStore.requestAuthorization(toShare: [flightsClimbed], read: [flightsClimbed]) { success, error in
                if success {
                    readSteps()
                } else if error != nil {
                    print(error ?? "Error")
                }
            }
        }
    }
    
    //하루 계단 오르기 횟수 누적 데이터 정의(Fetch)
    func readStepCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else { return }
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        healthStore.execute(query)
    }
    
    //일주일 계단 오르기 횟수 누적 데이터 정의
    func weekreadStepCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else { return }
        let now = Date()
        let startOfWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: now)! //-> 정확히 1주일 전 시간
        let endOfWeek = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startOfWeek, end: endOfWeek, options: [.strictStartDate, .strictEndDate])
        let options: HKStatisticsOptions = [.cumulativeSum]
        
        let query = HKStatisticsCollectionQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: options, anchorDate: startOfWeek, intervalComponents: DateComponents(day: 7))
        
        query.initialResultsHandler = { query, results, error in
            if let statistics = results?.statistics().first {
                let weekstepCount = statistics.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0.0
                completion(weekstepCount)
            }
        }
        healthStore.execute(query)
    }
    
    //한 달 계단 오르기 횟수 누적 데이터 정의
    func monthreadStepCount(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else { return }
        let now = Date()
        let startOfMonth = Calendar.current.date(byAdding: .month, value: -1, to: now)!
        //let endOfMonth = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let endOfMonth = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startOfMonth, end: endOfMonth, options: [.strictStartDate, .strictEndDate])
        let options: HKStatisticsOptions = [.cumulativeSum]
        
        let query = HKStatisticsCollectionQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: options, anchorDate: startOfMonth, intervalComponents: DateComponents(month: 1))
        
        query.initialResultsHandler = { query, results, error in
            if let statistics = results?.statistics().first {
                let monthstepCount = statistics.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0.0
                completion(monthstepCount)
            }
        }
        
        healthStore.execute(query)
    }
    
    //하루 계단 오르기 수행 횟수 정의
    func readStepCountperform(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        let calendar = Calendar.current
        
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            guard error == nil, let samples = results as? [HKQuantitySample] else {
                completion(0.0)
                return
            }
            
            var totalFlightsClimbed = 0.0

            for sample in samples {
                if !sample.description.contains("Watch"){
                    totalFlightsClimbed += 1
                }
            }
            completion(totalFlightsClimbed)
        }
        
        healthStore.execute(query)
    }
    
    //월간 계단 오르기 횟수 정의
    func monthreadStepCountperform(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: now)))!
        let endDate = Date()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            guard error == nil, let samples = results as? [HKQuantitySample] else {
                completion(0.0)
                return
            }
            
            var monthtotalFlightsClimbed = 0.0

            for sample in samples {
                if !sample.description.contains("Watch"){
                    monthtotalFlightsClimbed += 1
                }
            }
            completion(monthtotalFlightsClimbed)
        }
        
        healthStore.execute(query)
    }
}
