//
//  ContentView.swift
//  Eco-friendlyStep
//
//  Created by 안병욱의 mac on 2023/02/06.
//

import SwiftUI

 struct ContentView: View {
     var body: some View {
         TabView {
             FirstView()
                 .tabItem {
                     Label("Today's record", systemImage: "figure.stairs")
                 }
             
             SecondView()
                 .tabItem {
                     Label("Weekly & Monthly", systemImage: "calendar")
                 }
             
             ThirdView()
                 .tabItem {
                     Label("CO2", systemImage: "leaf")
                 }
         }
     }
 }
