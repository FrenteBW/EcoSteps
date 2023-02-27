//
//  Step.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/10.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
