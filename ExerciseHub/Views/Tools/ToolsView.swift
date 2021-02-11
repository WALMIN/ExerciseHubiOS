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
                    TitleView(title: "Stopwatch")
                    StopwatchView()
                    Spacer()
                    
                }.tabItem {
                    Image(systemName: "timer")
                }
                
                // Timer page
                VStack {
                    TitleView(title: "Timer")
                    TimerView()
                    Spacer()
                    
                }.tabItem {
                    Image(systemName: "hourglass")
                }
                
                // Interval timer page
                VStack {
                    TitleView(title: "Interval timer")
                    IntervalTimerView()
                    Spacer()
                    
                }.tabItem {
                    Image("interval_timer")
                }
                
                // Plate calculator page
                VStack {
                    TitleView(title: "Plate calculator")
                    PlateCalculatorView()
                    Spacer()
                    
                }.tabItem {
                    Image("plate_calculator")
                }
                
                // Count page
                VStack {
                    TitleView(title: "Count")
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

struct TitleView: View {
    
    var title = ""
    
    var body: some View {
        Text(title)
            .font(.caption)
            .textCase(.uppercase)
        
        Spacer()
        
    }
    
}
