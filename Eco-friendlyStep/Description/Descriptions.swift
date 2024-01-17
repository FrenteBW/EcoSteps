//
//  Descriptions.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/06/06.
//

import Foundation

struct Descriptions {
    
    static let initialViewDescription: String = " This app uses Apple health's flights climbed data to calculate calories consumed through stair climbing and CO2 emission reductions through stair climbing. To use these features, please allow permission to access Apple health data. This app only uses data related to stair climbing. The settings for permissions can be modified in the Settings app -> Apple health -> Data access.\n"
    
    static let firstViewDescription: String = "1. The app calculates that about 2.4 kcal is consumed every time a user goes up one stair.\n\n 2. The amount of CO2 reduction is calculated by assuming that user used stair climbing instead of elevator. It is calculated that there is a 12.7g CO2 reduction effect per number of stair climbing performances.\n\n 3.  Data is based on the same data source as Apple's health app.\n\n 4.  If you want to set data access rights, you can access and control health apps -> flights climbed -> data sources and access.\n\n 5.  This app's stair climbing data is recorded only when you move with an iPhone. Not recognized if only Apple Watch is worn and moved.\n\n 6. The above results may differ slightly from the actual results.\n"
    
    static let thirdViewDescription: String = "1. The amount of CO2 reduction is calculated by assuming that user used stair climbing instead of elevator. It is calculated that there is a 12.7g CO2 reduction effect per number of stair climbing performances.\n\n 2.  The tree picture changes according to the amount of CO2 emission reduction. Leaf shapes appear when emissions are 0 to 500g, small tree appear when emissions are 500 to 2000g, and big tree appear when emissions are more than 2000g. However, in reality, each tree has different CO2 absorption depending on its size, environment, and type. Therefore, the amount of CO2 absorbed by the tree in the picture and the amount of CO2 reduction may not be exactly the same.\n\n 3. The above results may differ slightly from the actual results.\n"
    
}
