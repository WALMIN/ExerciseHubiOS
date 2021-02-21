//
//  PlateCalculatorView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct PlateCalculatorView: View {
    
    @State var kgShowing = true
    
    @State var totalWeight: Double = 0.0
    @State var barbellWeight: Double = 20.0
    
    @State var kgList = [[0.25, 0.5, 1, 1.25], [2, 2.25, 2.5, 5], [7.5, 10, 12.5, 15], [20, 25, 50]]
    @State var lbList = [[1.25, 2.5, 5, 7.5], [10, 12.5, 15, 20], [25, 30, 35, 40], [45, 50, 55, 100]]
    
    @State var weightAmountList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    @State var popoverBarbellWeightShowing = false
    
    var body: some View {
        VStack {
            // Weight titles
            HStack {
                VStack {
                    Text("Total weight")
                        .font(.caption)
                        .padding(2)
                    
                    Text("\(String(format: "%.2f", (barbellWeight + totalWeight))) \(kgShowing ? "KG" : "LB")")
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
                    
                    // Show barbell weight popover on iPad
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Button(action: { popoverBarbellWeightShowing = true }) {
                            Text("\(String(format: "%.2f", barbellWeight)) \(kgShowing ? "KG" : "LB")")
                                .foregroundColor(.accentColor)
                                .fontWeight(.bold)
                                .font(.title)
                            
                        }.popover(isPresented: $popoverBarbellWeightShowing) {
                            VStack {
                                // Show the title
                                Text("Barbell weight").font(.title2)
                                Spacer()
                                
                                // Enter barbell weight
                                VStack {
                                    Stepper(value: $barbellWeight, in: 0...100, step: 0.10) {
                                        Text("\(String(format: "%.2f", barbellWeight))")
                                            .font(.largeTitle)
                                            
                                    }.padding()
                                }.padding()
                                
                                Spacer()
                                
                                // Close
                                Button(action: { popoverBarbellWeightShowing = false }) {
                                    Text("Close")
                                    
                                }
                                
                            }
                            .padding()
                        }
                        
                    // Show barbell weight sheet on iPhone
                    } else {
                        Button(action: { popoverBarbellWeightShowing = true }) {
                            Text("\(String(format: "%.2f", barbellWeight)) \(kgShowing ? "KG" : "LB")")
                                .foregroundColor(.accentColor)
                                .fontWeight(.bold)
                                .font(.title)
                            
                        }.sheet(isPresented: $popoverBarbellWeightShowing) {
                            VStack {
                                // Show the title
                                Text("Barbell weight").font(.title2)
                                Spacer()
                                
                                // Enter barbell weight
                                VStack {
                                    Stepper(value: $barbellWeight, in: 0...100, step: 0.10) {
                                        Text("\(String(format: "%.2f", barbellWeight))")
                                            .font(.largeTitle)
                                            
                                    }.padding()
                                }.padding()
                                
                                Spacer()
                                
                                // Close
                                Button(action: { popoverBarbellWeightShowing = false }) {
                                    Text("Close")
                                    
                                }
                                
                            }
                            .padding()
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            
            // Plates
            ForEach(0...3, id: \.self) { i in
                HStack {
                    ForEach(Array(kgShowing ? kgList[i].enumerated() : lbList[i].enumerated()), id: \.1) { index, item in
                        PlateView(title: "\(item)", amount: weightAmountList[index])
                            .simultaneousGesture(LongPressGesture().onEnded { _ in
                                if weightAmountList[index] > 0 {
                                    weightAmountList[index] -= 1
                                    totalWeight -= item
                                }
                                
                            })
                            .simultaneousGesture(TapGesture().onEnded {
                                weightAmountList[index] += 1
                                totalWeight += item
                                
                            })
                        
                    }
                    
                }
                
            }

            Text("Long press on a plate to remove it")
                .font(.caption)
                .padding()
            
            HStack {
                Text("KG").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
                Toggle("", isOn: $kgShowing)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    .frame(width: 0)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                    .onChange(of: kgShowing) { value in
                        barbellWeight = value ? 20.0 : 45.0
                        
                    }
                
            }
            
        }
        
    }
    
}

struct PlateCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        PlateCalculatorView()
    
    }

}
