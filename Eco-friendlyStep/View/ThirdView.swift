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
                        Text("\(Int((Double(vm.monthuserStepCountPerform) ?? 0.0)*12.7))g")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.green)
                        Text("of CO2 in this month!")
                            .fontWeight(.semibold)
                            .font(.title2)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if (Int((Double(vm.monthuserStepCountPerform) ?? 0.0)*12.7)) <= 500 {
                            Image("Leaf")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:400, height:400)
                        }
                        else if (Int((Double(vm.monthuserStepCountPerform) ?? 0.0)*12.7)) <= 2000 {
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
                    VStack(alignment: .leading) {
                        Image("HealthKitImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:100, height:100)
                        
                        Text(" To use the app, you need to synchronize with your health data.\n")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)

                        Text(description.initialViewDescription)
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
            .padding()
            .onAppear {
                vm.monthreadStepsTakenToday()
                vm.monthreadStepsperformTakenToday()
            }
        }
    }
}
