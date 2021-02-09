//
//  VideoView.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-02.
//

import SwiftUI
import AVKit

struct PopoverVideo: View {
    
    let name: String
    
    var body: some View {
        VStack {
            let videoPlayer = AVPlayer(url: URL(string: "https://walmin.com/exercisehub/resources/library/vid/\(name.lowercased().replacingOccurrences(of: " ", with: "_")).mp4")!)
            
            VideoPlayer(player: videoPlayer){
                VStack {
                    Text("\(name)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    
                }
                
            }
            .ignoresSafeArea()
            .onAppear() {
                videoPlayer.play()
                
            }
            .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
                videoPlayer.seek(to: .zero)
                videoPlayer.play()
                
            }
            
        }
        .frame(width: 512, height: 512)
        
    }
    
}

struct PopoverVideo_Previews: PreviewProvider {
    static var previews: some View {
        PopoverVideo(name: "Push ups")
    }
}
