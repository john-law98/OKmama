//
//  ContentView.swift
//  OKmamaNovember
//
//  Created by John Lawrence on 10/24/20.
//

import SwiftUI
import AVFoundation
import AVKit

struct ContentView: View {
//    var body: some View {
//        Text("Hello, world!")
    //            .padding()
    //
    @State var audioPlayer:AVAudioPlayer?
    
    @State var isPlaying : Bool = false
    
    var body: some View {
        VStack {
            
        
        Button(action: {
            if let path = Bundle.main.path(forResource: "1_3_", ofType: ".mp3"){
                self.audioPlayer = AVAudioPlayer()
                self.isPlaying.toggle()
                
                let url = URL(fileURLWithPath: path)
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    self.audioPlayer?.prepareToPlay()
                    self.audioPlayer?.play()
                    
                } catch {
                    print("Error")
                }
            
            }
        }, label: {
            if isPlaying {
                Image(systemName: "pause").font(Font.system(.largeTitle).bold())
				// isPlaying = false;
				
            } else {
                Image(systemName: "play.fill").font(Font.system(.largeTitle).bold())
                
            }
            
        }) // end button
		.padding()
            Text("Welcome to OK mama!")
                .font(Font.custom("FredokaOne-Regular", size: 20))
			
		} // end VStack
		
        } // end View
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
