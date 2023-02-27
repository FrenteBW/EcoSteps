//
//  SecondView.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/07.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    
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
                             
                         VStack(alignment: .leading){
                         Text("Daily step count")
                         .bold()
                         .foregroundColor(.gray)
                         Text(" ")
                         .bold()
                         Text("\(vm.userStepCount) floors")
                         .font(.title2)
                         .foregroundColor(.blue)
                         .bold()
                         }
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .padding()
                         .foregroundColor(.white)
                         .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                         //.background(.white)
                         .cornerRadius(20, corners: [.allCorners])
                         
                         VStack(alignment: .leading){
                         Text("Daily calorie consumption")
                         .bold()
                         .foregroundColor(.gray)
                         Text(" ")
                         .bold()
                         Text("\(Int((Double(vm.userStepCount) ?? 0.0)*2.4)) Kcal")
                         .font(.title2)
                         .bold()
                         .foregroundColor(.red)
                         }
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .padding()
                         .foregroundColor(.white)
                         .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                         //.background(.white)
                         .cornerRadius(20, corners: [.allCorners])
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
                            //Text("1 week ago ~ Today")
                                .fontWeight(.regular)
                                .bold()
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .leading){
                                Text("Weekly step count")
                                    .bold()
                                    .foregroundColor(.gray)
                                Text(" ")
                                    .bold()
                                Text("\(vm.weekuserStepCount) floors")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.blue)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            //.background(.white)
                            .cornerRadius(20, corners: [.allCorners])
                            
                            VStack(alignment: .leading){
                                Text("Weekly calorie consumption")
                                    .bold()
                                    .foregroundColor(.gray)
                                Text(" ")
                                    .bold()
                                Text("\(Int((Double(vm.weekuserStepCount) ?? 0.0)*2.4)) Kcal")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            //.background(.white)
                            .cornerRadius(20, corners: [.allCorners])
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
                            //Text("1 month ago ~ Today")
                                .fontWeight(.regular)
                                .bold()
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack(alignment: .leading){
                                Text("Monthly step count")
                                    .bold()
                                    .foregroundColor(.gray)
                                Text(" ")
                                    .bold()
                                Text("\(vm.monthuserStepCount) floors")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.blue)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            //.background(.white)
                            .cornerRadius(20, corners: [.allCorners])
                            
                            VStack(alignment: .leading){
                                Text("Monthly calorie consumption")
                                    .bold()
                                    .foregroundColor(.gray)
                                Text(" ")
                                    .bold()
                                Text("\(Int((Double(vm.monthuserStepCount) ?? 0.0)*2.4)) Kcal")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.1))
                            //.background(.white)
                            .cornerRadius(20, corners: [.allCorners])
                        }
                    }
            }
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
            vm.readStepsTakenToday()
            vm.weekreadStepsTakenToday()
            vm.monthreadStepsTakenToday()
        }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
