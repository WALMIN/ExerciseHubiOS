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
                
                TimerView()
                    .tabItem {
                        Image(systemName: "hourglass")
                    }
                
                IntervalTimerView()
                    .tabItem {
                        Image("interval_timer")
                    }
                
                PlateCalculatorView()
                    .tabItem {
                        Image("plate_calculator")
                    }
                
                CountView()
                    .tabItem {
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
