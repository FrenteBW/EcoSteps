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
                            //.fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(.black)
                        Text("\(Int((Double(vm.monthuserStepCountPerform) ?? 0.0)*12.7))g")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.green)
                        Text("of CO2 in this month.")
                            //.fontWeight(.bold)
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
                                        Text(" 1. The amount of CO2 reduction is calculated by assuming that user used stair climbing instead of elevator. It is calculated that there is a 12.7g CO2 reduction effect per number of stair climbing performances.\n\n 2.  The tree picture changes according to the amount of CO2 emission reduction. Leaf shapes appear when emissions are 0 to 500g, small tree appear when emissions are 500 to 2000g, and big tree appear when emissions are more than 2000g. However, in reality, each tree has different CO2 absorption depending on its size, environment, and type. Therefore, the amount of CO2 absorbed by the tree in the picture and the amount of CO2 reduction may not be exactly the same.\n\n 3. The above results may differ slightly from the actual results.\n")
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                }
                            }
                        }
                            .padding()
                            //.padding(.bottom, 20)
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
                        
                        Text(" This app uses Apple health's flights climbed data to calculate calories consumed through stair climbing and CO2 emission reductions through stair climbing. To use these features, please allow permission to access Apple health data. This app only uses data related to stair climbing. The settings for permissions can be modified in the Settings app -> apple health -> Data access.\n")
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
                            //.buttonStyle()
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

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
