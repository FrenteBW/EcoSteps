//
//  SecondView.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/07.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var vm: HealthKitViewModel
    let description: Descriptions
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if vm.isAuthorized {
                    VStack() {
                        Text("Weekly & Monthly Data")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            Group {
                                Text("Daily Data")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Today")
                                    .fontWeight(.regular)
                                    .bold()
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                CustomCountView(title: "Daily step count", datavalue: vm.userStepCount, unit: "Floors")
                                
                                CustomCountView(title: "Daily calorie consumption", datavalue: String((Int(vm.calculateCalories(userStepCount: Double(vm.userStepCount) ?? 0.0)))), unit: "Kcal")
                            }
                            
                            Group {
                                Text(" ")
                                    .fontWeight(.regular)
                                Text("Weekly Data")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!, style: .date) ~ Today")
                                    .fontWeight(.regular)
                                    .bold()
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                CustomCountView(title: "Weekly step count", datavalue: vm.weekuserStepCount, unit: "Floors")
                                
                                CustomCountView(title: "Weekly calorie consumption", datavalue: String((Int(vm.calculateCalories(userStepCount: Double(vm.weekuserStepCount) ?? 0.0)))), unit: "Kcal")
                            }
                            
                            Group {
                                Text(" ")
                                    .fontWeight(.regular)
                                Text("Monthly Data")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(Calendar.current.date(byAdding: .month, value: -1, to: Date())!, style: .date) ~ Today")
                                    .fontWeight(.regular)
                                    .bold()
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                CustomCountView(title: "Monthly step count", datavalue: vm.monthuserStepCount, unit: "Floors")
                                
                                CustomCountView(title: "Monthly calorie consumption", datavalue: String((Int(vm.calculateCalories(userStepCount: Double(vm.monthuserStepCount) ?? 0.0)))), unit: "Kcal")
                            }
                        }
                    }
                } else {
                    AuthView(description: description)
                }
            }
            .padding()
            .onAppear {
                vm.readStepsTakenToday()
                vm.weekreadStepsTakenToday()
                vm.monthreadStepsTakenToday()
            }
        }
    }
}
