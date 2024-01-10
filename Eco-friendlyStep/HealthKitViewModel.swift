//
//  HealthKitViewModel.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/06.
//

import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject {
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userStepCount = ""
    @Published var weekuserStepCount = ""
    @Published var monthuserStepCount = ""
    @Published var userStepCountPerform = ""
    @Published var monthuserStepCountPerform = ""
    @Published var isAuthorized = false
    
    init() {
        changeAuthorizationStatus()
    }
    
    //MARK: - HealthKit Authorization Request Method
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
            self.weekreadStepsTakenToday()
            self.monthreadStepsTakenToday()
            self.readStepsperformTakenToday()
            self.monthreadStepsperformTakenToday()
        }
    }
    
    func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .flightsClimbed) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        
        switch status {
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            DispatchQueue.main.async {
                self.isAuthorized = true
            }
        @unknown default:
            isAuthorized = false
        }
    }
    
    //MARK: - Read User's Step Count
    //하루 누적 계단오르기 횟수
    func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
    
    //주간 누적 계단오르기 횟수
    func weekreadStepsTakenToday() {
        healthKitManager.weekreadStepCount(forToday: Date(), healthStore: healthStore) { weekstep in
            if weekstep != 0.0 {
                DispatchQueue.main.async {
                    self.weekuserStepCount = String(format: "%.0f", weekstep)
                }
            }
        }
    }
    
    //월간 누적 계단오르기 횟수
    func monthreadStepsTakenToday() {
        healthKitManager.monthreadStepCount(forToday: Date(), healthStore: healthStore) { monthstep in
            if monthstep != 0.0 {
                DispatchQueue.main.async {
                    self.monthuserStepCount = String(format: "%.0f", monthstep)
                }
            }
        }
    }
    
    //MARK: - Read User's Step count perform
    //계단 오르기 수행 횟수
    func readStepsperformTakenToday() {
        healthKitManager.readStepCountperform(forToday: Date(), healthStore: healthStore) { stepperform in
            if stepperform != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCountPerform = String(format: "%.0f", stepperform)
                }
            }
        }
    }
    
    //월간 계단 오르기 수행 횟수
    func monthreadStepsperformTakenToday() {
        healthKitManager.monthreadStepCountperform(forToday: Date(), healthStore: healthStore) { monthstepperform in
            if monthstepperform != 0.0 {
                DispatchQueue.main.async {
                    self.monthuserStepCountPerform = String(format: "%.0f", monthstepperform)
                }
            }
        }
    }

    //MARK: - Calculate Calorie cumsumtion & CO2 emission reduction
    //칼로리 소모량 계산
    func calculateCalories(userStepCount: Double) -> Double {
        let caloriesBurned = userStepCount * 2.4
        return caloriesBurned
    }
    
    //탄소 배출 감소량 계산
    func calculateCO2(userStepCountPerform: Double) -> Double {
        let co2Reduction = userStepCountPerform * 12.7
        return co2Reduction
    }
    
}
