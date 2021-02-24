//
//  HeaderView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-23.
//

import SwiftUI

struct HeaderView: View {
    
    var workout: Workout
    var roundIndex: Int
    var round: Round
    
    @FetchRequest(entity: Round.entity(), sortDescriptors: [], animation: .default)
    private var rounds: FetchedResults<Round>
    
    var body: some View {
        Text("Round \(roundIndex + 1)/\(workout.roundsArray.count) - \(round.cycles) \(round.cycles > 1 ? "cycles" : "cycle")")
            .frame(maxWidth: .infinity, alignment: .leading)
            
    }
    
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(workout: Workout(), roundIndex: 0, round: Round())
        
    }
    
}
