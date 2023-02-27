//
//  FirstView.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/07.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    @State private var isShowingPopover = false
    //add
    @State private var isShownSheet = false
    @State private var presentAlert = false
    @AppStorage("climbstair") var climbstair: Int = 15
    @AppStorage("calories") var calories: Int = 100
    @AppStorage("CO2") var CO2: Int = 50
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("background")
            .edgesIgnoringSafeArea(.all)
            VStack {
                if vm.isAuthorized {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Eco steps")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        Text("Today, \(Date().formatted(.dateTime.month().day()))")
                            .fontWeight(.regular)
                            .bold()
                            .foregroundColor(.gray)
                            VStack{
                                Text("Today's Step count")
                                    .bold()
                                    .foregroundColor(.blue)
                                PercentageRing(ringWidth: 20, percent: ((Double(vm.userStepCount) ?? 0.0)/Double((climbstair)))*100, backgroundColor: Color("bluebackgroundcolor"), foregroundColors: [.blue])
                                    
                                Text("\(vm.userStepCount) / \(climbstair) floors")
                                    .foregroundColor(.blue)
                                    .bold()
                                    
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            
                            .foregroundColor(.white)
                            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            .cornerRadius(20, corners: [.allCorners])
                            
                            VStack{
                                HStack{
                                    VStack{
                                        Text("Calorie")
                                            .bold()
                                            .foregroundColor(.red)
                                        PercentageRing(ringWidth: 20, percent: ((Double(vm.userStepCount) ?? 0.0)/Double((calories)))*100*2.4, backgroundColor: Color("redbackgroundcolor"), foregroundColors: [.red])
                                     
                                        Text("\(Int((Double(vm.userStepCount) ?? 0.0)*2.4)) / \(calories) Kcal")
                                            .foregroundColor(.red)
                                            .bold()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                 
                                    
                                    .foregroundColor(.white)
                                    .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            
                                    .cornerRadius(20, corners: [.allCorners])
                                    
                                    VStack{
                                        Text("CO2 save")
                                          
                                            .bold()
                                            .foregroundColor(.green)
                                        PercentageRing(ringWidth: 20, percent: ((Double(vm.userStepCountPerform) ?? 0.0)/Double((CO2)))*100*12.7, backgroundColor: Color("greenbackgroundcolor"), foregroundColors: [.green])
                                        Text("\(Int((Double(vm.userStepCountPerform) ?? 0.0)*12.7)) / \(CO2) g")
                                            .foregroundColor(.green)
                                            .bold()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                
                                    
                                    .foregroundColor(.white)
                                    .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))

                                    .cornerRadius(20, corners: [.allCorners])
                                }
                            }
                            VStack{

                                Button("Setting goals") {
                                            self.isShownSheet = true
                                }
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .sheet(isPresented: $isShownSheet) {
                                    ZStack {
                                        Color("background")
                                        .scaleEffect(1.5)
                                        VStack{
                                            Text("Set goals")
                                                .foregroundColor(.black)
                                                .bold()
                                                .font(.title)
                                                .padding()
                                                
                                            
                                            Text("Stair")
                                                .foregroundColor(.black)
                                                .bold()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            TextField("climbstair(Default : 15th floor)", value: $climbstair, format:.number)
                                                .keyboardType(.numberPad)
                                                .foregroundColor(.black)
                                                .padding()
                                                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                                                .cornerRadius(15, corners: [.allCorners])
                                            
                                            Text("Calorie")
                                                .foregroundColor(.black)
                                                .bold()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            TextField("calorie(Default : 100kcal)", value: $calories, format:.number)
                                                .keyboardType(.numberPad)
                                                .foregroundColor(.black)
                                                .padding()
                                                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                                                .cornerRadius(15, corners: [.allCorners])
                                            
                                            Text("CO2")
                                                .foregroundColor(.black)
                                                .bold()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            TextField("CO2(Default : 50g)", value: $CO2, format:.number)
                                                .keyboardType(.numberPad)
                                                .foregroundColor(.black)
                                                .padding()
                                                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                                                .cornerRadius(15, corners: [.allCorners])

                                            
                                            Button("Done") {
                                                hideKeyboard()
                                                self.isShownSheet = false
                                                    }
                                            .foregroundColor(.blue)
                                            }
                                        .padding()
                                        }
                                    .presentationDetents([.medium])
                                    }
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            //.padding(.bottom, 20)
                            .foregroundColor(.white)
                            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            //.background(.white)
                            .cornerRadius(15, corners: [.allCorners])
                            
                        VStack{
                                Button("Description of measures") {
                                            self.isShowingPopover = true
                                }
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .popover(isPresented: $isShowingPopover) {
                                    ZStack {
                                        Color("background")
                                        .scaleEffect(1.5)
                                        VStack{
                                            Text("Description")
                                                .foregroundColor(.black)
                                                .font(.title)
                                                .bold()
                                            Text(" 1. The app calculates that about 2.4 kcal is consumed every time a user goes up one stair.\n\n 2. The amount of CO2 reduction is calculated by assuming that user used stair climbing instead of elevator. It is calculated that there is a 12.7g CO2 reduction effect per number of stair climbing performances.\n\n 3.  Data is based on the same data source as Apple's health app.\n\n 4.  If you want to set data access rights, you can access and control health apps -> flights climbed -> data sources and access.\n\n 5.  This app's stair climbing data is recorded only when you move with an iPhone. Not recognized if only Apple Watch is worn and moved.\n\n 6. The above results may differ slightly from the actual results.\n")
                                                .foregroundColor(.black)
                                                .padding()
                                             }
                                        }
                                    }
                            }
                        .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            //.padding(.bottom, 20)
                            .foregroundColor(.white)
                            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            //.background(.white)
                            .cornerRadius(15, corners: [.allCorners])
                        }
                    //}
                    } else {
                        VStack(alignment: .leading) {
                            Image("HealthKitImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:100, height:100)
                            
                            Text(" To use the app, you need to synchronize with your health data.\n")
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                            
                            Text(" This app uses Apple health's flights climbed data to calculate calories consumed through stair climbing and CO2 emission reductions through stair climbing. To use these features, please allow permission to access Apple health data. This app only uses data related to stair climbing. The settings for permissions can be modified in the Settings app -> Apple health -> Data access.\n")
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
                        vm.readStepsTakenToday()
                        vm.readStepsperformTakenToday()
            }
        }
    }
}