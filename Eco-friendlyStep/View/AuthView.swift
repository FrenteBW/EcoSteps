//
//  AuthView.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/06/09.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var vm: HealthKitViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("HealthKitImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
            
            Text(" To use the app, you need to synchronize with your health data.\n")
                .font(.title)
                .bold()
                .foregroundColor(.black)
            
            Text(Descriptions.initialViewDescription)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding()
        
        HStack(alignment: .center){
            Button {
                vm.healthRequest()
            } label: {
                Text("Authorize Health data")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .background(Color.blue)
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .cornerRadius(20)
            .controlSize(.large)
        }
        .padding()
    }
}
