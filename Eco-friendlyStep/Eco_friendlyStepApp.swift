//
//  Eco_friendlyStepApp.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/06.
//

import SwiftUI

@main
struct TryHealthKitApp: App {
    
    var healthVM = HealthKitViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthVM)
        }
    }
}
