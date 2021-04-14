//
//  HistoryView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-25.
//

import SwiftUI

struct HistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \History.timestamp, ascending: false)], animation: .default)
    private var history: FetchedResults<History>
    
    var body: some View {
        NavigationView {
            VStack {
                // Show no history text if the list is empty
                if history.count == 0 {
                    HStack {
                        VStack {
                            Text("No workout history yet, get moving!").padding()
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                // Show history list
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(Array(history.enumerated()), id: \.1) { index, item in
                                HistoryItemView(history: item)
                                    .contextMenu {
                                        // Delete workout
                                        Button(action: { deleteHistory(index: index) }) {
                                            Text("Delete")
                                            Image(systemName: "trash")
                                            
                                        }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            .navigationTitle("Workout history")
            .navigationBarItems(trailing:
                // Close
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                
                }
                                
            )
            
        }
        
    }
    
    // Alert to delete a history item
    private func deleteHistory(index: Int) {
        let alert = UIAlertController(title: "Delete history", message: "Are you really sure you want to delete this history item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { _ in
            withAnimation {
                let item = history[index]
                viewContext.delete(item)
                
                do {
                    try viewContext.save()
                    
                } catch {
                    fatalError("Unresolved error \(error as NSError), \((error as NSError).userInfo)")
                    
                }
                
            }
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        
        Alert().show(alert)
        
    }
    
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
        
    }
    
}
