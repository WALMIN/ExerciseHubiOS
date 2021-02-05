//
//  ToolsView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import SwiftUI

struct ToolsView: View {
    
    @State var title = "Stopwatch"
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 12))
                .textCase(.uppercase)
            
            TabView {
                StopwatchView()
                    .tabItem {
                        Image(systemName: "timer")
                    }
                    .onAppear(){
                        title = "Stopwatch"
                    
                    }
                
                TimerView()
                    .tabItem {
                        Image(systemName: "hourglass")
                    }
                    .onAppear(){
                        title = "Timer"
                    
                    }
                
                IntervalTimerView()
                    .tabItem {
                        Image("interval_timer")
                    }
                    .onAppear(){
                        title = "Interval Timer"
                    
                    }
                
                PlateCalculatorView()
                    .tabItem {
                        Image("plate_calculator")
                    }
                    .onAppear(){
                        title = "Plate calculator"
                    
                    }
                
                CountView()
                    .tabItem {
                        Image("count")
                    }
                    .onAppear(){
                        title = "Count"
                    
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
