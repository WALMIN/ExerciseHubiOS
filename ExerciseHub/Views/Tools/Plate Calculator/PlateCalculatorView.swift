//
//  PlateCalculatorView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-04.
//

import SwiftUI

struct PlateCalculatorView: View {
    
    private let userDefaults = UserDefaults.standard
    
    @State var kgShowing = UserDefaults.standard.bool(forKey: UserDefaultsUtils().kgShowingKey)
    
    @State var totalWeight = 0.0
    @State var barbellWeight = 0.0
    
    @State var kgList = [[0.25, 0.5, 1, 1.25], [2, 2.25, 2.5, 5], [7.5, 10, 12.5, 15], [20, 25, 50]]
    @State var lbList = [[1.25, 2.5, 5, 7.5], [10, 12.5, 15, 20], [25, 30, 35, 40], [45, 50, 55, 100]]
    @State var weightAmountList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    @State var popoverBarbellWeightShowing = false
    @State var sheetBarbellWeightShowing = false
    
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
                    
                    // Show barbell weight popover or sheet
                    Button(action: {
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            popoverBarbellWeightShowing = true
                            
                        } else {
                            sheetBarbellWeightShowing = true
                            
                        }
                        
                    }) {
                        Text("\(String(format: "%.2f", barbellWeight)) \(kgShowing ? "KG" : "LB")")
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                            .font(.title)
                        
                    }
                    .popover(isPresented: $popoverBarbellWeightShowing) { PopoverBarbellWeight() }
                    .sheet(isPresented: $sheetBarbellWeightShowing) { SheetBarbellWeight() }
                        
                }
                
            }
            
            // Plates list
            ForEach(0...3, id: \.self) { row in
                HStack {
                    ForEach(Array(kgShowing ? kgList[row].enumerated() : lbList[row].enumerated()), id: \.1) { index, item in
                        PlateItemView(title: "\(item)", amount: weightAmountList[index])
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
            
            // Toggle to switch between kg & lb
            HStack {
                Text("KG").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
                Toggle("", isOn: $kgShowing)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                    .frame(width: 0)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                    .onChange(of: kgShowing) { value in
                        barbellWeight = value ? userDefaults.double(forKey: UserDefaultsUtils().kgBarbellWeightKey) : userDefaults.double(forKey: UserDefaultsUtils().lbBarbellWeightKey)
                        userDefaults.set(value, forKey: UserDefaultsUtils().kgShowingKey)
                        
                        totalWeight = 0.0
                        weightAmountList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                        
                    }
                
            }
            
        }.onAppear {
            barbellWeight = kgShowing ? userDefaults.double(forKey: UserDefaultsUtils().kgBarbellWeightKey) : userDefaults.double(forKey: UserDefaultsUtils().lbBarbellWeightKey)
            
            if barbellWeight == 0 {
                userDefaults.set(20, forKey: UserDefaultsUtils().kgBarbellWeightKey)
                userDefaults.set(45, forKey: UserDefaultsUtils().lbBarbellWeightKey)
                
                if kgShowing {
                    barbellWeight = 20
                    
                } else {
                    barbellWeight = 45
                    
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
