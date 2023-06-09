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
    @State private var isShownSheet = false
    @State private var presentAlert = false
    @AppStorage("climbstair") var climbstair: Int = 15
    @AppStorage("calories") var calories: Int = 100
    @AppStorage("CO2") var CO2: Int = 50
    let description: Descriptions
    
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
                                            Text(description.firstViewDescroption)
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
                    } else {
                        AuthView(description: description)
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
