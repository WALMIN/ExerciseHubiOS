//
//  PlateCalculatorView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct PlateCalculatorView: View {
    
    @State var totalWeight: Double = 20.0
    @State var barbellWeight: Double = 20.0
    
    var body: some View {
        VStack {
            // Weight titles
            HStack {
                VStack {
                    Text("Total weight")
                        .font(.caption)
                        .padding(2)
                    
                    Text("\(String(format: "%.1f", totalWeight)) KG")
                        .foregroundColor(.accentColor)
                        .font(.title)
                    
                }
                
                Color(UIColor.label)
                    .frame(width: 1, height: 48)
                    .padding()
                
                VStack {
                    Text("Barbell weight")
                        .font(.caption)
                        .padding(2)
                    
                    Text("\(String(format: "%.1f", barbellWeight)) KG")
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .font(.title)
                    
                }
                
            }
            
            HStack {
                PlateView(title: "0.25")
                PlateView(title: "0.5")
                PlateView(title: "1")
                PlateView(title: "1.25")
                
            }
            
            HStack {
                PlateView(title: "2")
                PlateView(title: "2.25")
                PlateView(title: "2.5")
                PlateView(title: "5")
                
            }
            
            HStack {
                PlateView(title: "7.5")
                PlateView(title: "10")
                PlateView(title: "12.5")
                PlateView(title: "15")
                
            }
            
            HStack {
                PlateView(title: "20")
                PlateView(title: "25")
                PlateView(title: "50")
                
            }
            
        }
        
    }
    
}

struct PlateCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        PlateCalculatorView()
    
    }

}
