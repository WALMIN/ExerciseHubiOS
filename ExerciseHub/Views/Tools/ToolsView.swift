//
//  ToolsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct ToolsView: View {
    
    private let userDefaults = UserDefaults.standard
    
    @State private var currentPage = UserDefaults.standard.integer(forKey: UserDefaultsUtils().toolsPageKey)
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                // Stopwatch page
                VStack {
                    ToolsTitleView(title: "Stopwatch")
                    StopwatchView()
                    Spacer()
                    
                }.tabItem {
                    Image(systemName: "timer")
                    
                }.tag(0)
                .onAppear { saveCurrentPage(0) }
                
                // Timer page
                VStack {
                    ToolsTitleView(title: "Timer")
                    TimerView()
                    Spacer()
                    
                }.tabItem {
                    Image(systemName: "hourglass")
                    
                }.tag(1)
                .onAppear { saveCurrentPage(1) }
                
                // Interval timer page
                VStack {
                    ToolsTitleView(title: "Interval timer")
                    IntervalTimerView()
                    Spacer()
                    
                }.tabItem {
                    Image("interval_timer")
                    
                }.tag(2)
                .onAppear { saveCurrentPage(2) }
                
                // Plate calculator page
                VStack {
                    ToolsTitleView(title: "Plate calculator")
                    PlateCalculatorView()
                    Spacer()
                    
                }.tabItem {
                    Image("plate_calculator")
                    
                }.tag(3)
                .onAppear { saveCurrentPage(3) }
                
                // Count page
                VStack {
                    ToolsTitleView(title: "Count")
                    CountView()
                    Spacer()
                    
                }.tabItem {
                    Image("count")
                    
                }.tag(4)
                .onAppear { saveCurrentPage(4) }
                    
            }
            
        }
        
    }
    
    func saveCurrentPage(_ page: Int){
        userDefaults.set(page, forKey: UserDefaultsUtils().toolsPageKey)
        
    }
    
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
        
    }
    
}
