//
//  ThirdView.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/07.
//

import SwiftUI

struct ThirdView: View {
    
    @EnvironmentObject var vm: HealthKitViewModel
    @State private var ThirdViewisShowingPopover = false
    let description: Descriptions
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if vm.isAuthorized {
                    VStack {
                        Spacer()
                        Text("CO2 emission reductions")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.top, 10)

                        Spacer()
                        Text("You saved")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .foregroundColor(.black)
                        Text("\(Int(vm.calculateCO2(userStepCountPerform: Double(vm.monthuserStepCountPerform) ?? 0.0)))g")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.green)
                        Text("of CO2 in this month!")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if (vm.calculateCO2(userStepCountPerform: Double(vm.monthuserStepCountPerform) ?? 0.0)) <= 500 {
                            Image("Leaf")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:400, height:400)
                        }

                        else if (vm.calculateCO2(userStepCountPerform: Double(vm.monthuserStepCountPerform) ?? 0.0)) <= 2000 {
                            Image("SmallTree")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:400, height:400)
                        }
                        
                        else{
                            Image("Tree")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:400, height:400)
                        }
                    
                        Spacer()

                        VStack {
                            Button("Description of measures") {
                                        self.ThirdViewisShowingPopover = true
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .popover(isPresented: $ThirdViewisShowingPopover) {
                                ZStack {
                                    Color("background")
                                        .scaleEffect(1.5)
                                    VStack{
                                        Text("Description")
                                            .foregroundColor(.black)
                                            .font(.title)
                                            .bold()
                                        Text(description.thirdViewDescription)
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                }
                            }
                        }
                            .padding()
                    }
                }
                else {
                    AuthView(description: description)
                }
            }
            .padding()

            .onAppear {
                vm.monthreadStepsTakenToday()
                vm.monthreadStepsperformTakenToday()
            }
        }
    }
}
