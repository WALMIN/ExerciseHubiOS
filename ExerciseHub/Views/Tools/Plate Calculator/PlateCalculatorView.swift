//
//  PlateCalculatorView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct PlateCalculatorView: View {
    
    @State var totalWeight: Double = 0.0
    @State var barbellWeight: Double = 20.0
    
    @State var weightAmountList = [0, 0, 0, 0,
                                   0, 0, 0, 0,
                                   0, 0, 0, 0,
                                   0, 0, 0, 0,
                                   0, 0, 0]
    
    var body: some View {
        VStack {
            // Weight titles
            HStack {
                VStack {
                    Text("Total weight")
                        .font(.caption)
                        .padding(2)
                    
                    Text("\(String(format: "%.2f", (barbellWeight + totalWeight))) KG")
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
                    
                    Text("\(String(format: "%.2f", barbellWeight)) KG")
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .font(.title)
                    
                }
                
            }
            
            // Plates
            HStack {
                // 0.25
                PlateView(title: "0.25", amount: weightAmountList[0]).simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[0] > 0 {
                        weightAmountList[0] -= 1
                        totalWeight -= 0.25
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[0] += 1
                    totalWeight += 0.25
                })

                // 0.5
                PlateView(title: "0.5").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[1] > 0 {
                        weightAmountList[1] -= 1
                        totalWeight -= 0.5
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[1] += 1
                    totalWeight += 0.5
                })

                // 1.0
                PlateView(title: "1.0").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[2] > 0 {
                        weightAmountList[2] -= 1
                        totalWeight -= 1.0
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[2] += 1
                    totalWeight += 1.0
                })

                // 1.25
                PlateView(title: "1.25").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[3] > 0 {
                        weightAmountList[3] -= 1
                        totalWeight -= 1.25
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[3] += 1
                    totalWeight += 1.25
                })
                
            }
            
            HStack {
                // 2.0
                PlateView(title: "2.0").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[4] > 0 {
                        weightAmountList[4] -= 1
                        totalWeight -= 2.0
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[4] += 1
                    totalWeight += 2.0
                })

                // 2.25
                PlateView(title: "2.25").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[5] > 0 {
                        weightAmountList[5] -= 1
                        totalWeight -= 2.25
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[5] += 1
                    totalWeight += 2.25
                })

                // 2.5
                PlateView(title: "2.5").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[6] > 0 {
                        weightAmountList[6] -= 1
                        totalWeight -= 2.5
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[6] += 1
                    totalWeight += 2.5
                })

                // 5.0
                PlateView(title: "5.0").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[7] > 0 {
                        weightAmountList[7] -= 1
                        totalWeight -= 5.0
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[7] += 1
                    totalWeight += 5.0
                })

            }
            
            HStack {
                // 7.5
                PlateView(title: "7.5").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[8] > 0 {
                        weightAmountList[8] -= 1
                        totalWeight -= 7.5
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[8] += 1
                    totalWeight += 7.5
                })

                // 10
                PlateView(title: "10").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[9] > 0 {
                        weightAmountList[9] -= 1
                        totalWeight -= 10
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[9] += 1
                    totalWeight += 10
                })

                // 12.5
                PlateView(title: "12.5").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[10] > 0 {
                        weightAmountList[10] -= 1
                        totalWeight -= 12.5
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[10] += 1
                    totalWeight += 12.5
                })

                // 15
                PlateView(title: "15").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[12] > 0 {
                        weightAmountList[12] -= 1
                        totalWeight -= 15
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[12] += 1
                    totalWeight += 15
                })
                
            }
            
            HStack {
                // 20
                PlateView(title: "20").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[13] > 0 {
                        weightAmountList[13] -= 1
                        totalWeight -= 20

                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[13] += 1
                    totalWeight += 20
                })

                // 25
                PlateView(title: "25").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[14] > 0 {
                        weightAmountList[14] -= 1
                        totalWeight -= 25

                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[14] += 1
                    totalWeight += 25
                })

                // 50
                PlateView(title: "50").simultaneousGesture(LongPressGesture().onEnded { _ in
                    if weightAmountList[15] > 0 {
                        weightAmountList[15] -= 1
                        totalWeight -= 50
                    }
                }).simultaneousGesture(TapGesture().onEnded {
                    weightAmountList[15] += 1
                    totalWeight += 50
                })
                
            }

            Text("Long press on a plate to remove it")
                .font(.caption)
                .padding()
            
        }
        
    }
    
}

struct PlateCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        PlateCalculatorView()
    
    }

}
