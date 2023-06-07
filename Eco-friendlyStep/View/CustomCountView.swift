//
//  CustomCountView.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/06/07.
//

import Foundation
import SwiftUI

struct CustomCountView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    let title: String
    let datavalue: String
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .bold()
                .foregroundColor(.gray)
            Text(" ")
                .bold()
            //Text("\(datavalue) floors")
            HStack{
                Text("\(datavalue)")
                Text(unit)
            }
                .font(.title2)
                .foregroundColor(.blue)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .foregroundColor(.white)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
        .cornerRadius(20, corners: [.allCorners])
    }
}
