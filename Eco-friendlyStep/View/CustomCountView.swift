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
        .background(Color("blockbackgroundcolor"))
        .cornerRadius(20, corners: [.allCorners])
    }
}
