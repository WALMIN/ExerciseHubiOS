//
//  ToolsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct ToolsView: View {
    
    var body: some View {
        VStack {
            TabView {
                // Stopwatch page
                VStack {
                    ToolsTitleView(title: "Stopwatch")
                    StopwatchView()
                    Spacer()
                    
                }.tabItem {
                    Image(systemName: "timer")
                }
                
                // Timer page
                VStack {
                    ToolsTitleView(title: "Timer")
                    TimerView()
                    Spacer()
                    
                }.tabItem {
                    Image(systemName: "hourglass")
                }
                
                // Interval timer page
                VStack {
                    ToolsTitleView(title: "Interval timer")
                    IntervalTimerView()
                    Spacer()
                    
                }.tabItem {
                    Image("interval_timer")
                }
                
                // Plate calculator page
                VStack {
                    ToolsTitleView(title: "Plate calculator")
                    PlateCalculatorView()
                    Spacer()
                    
                }.tabItem {
                    Image("plate_calculator")
                }
                
                // Count page
                VStack {
                    ToolsTitleView(title: "Count")
                    CountView()
                    Spacer()
                    
                }.tabItem {
                    Image("count")
                }
                    
            }
            
        }
        
    }
    
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
        
    }
    
}
