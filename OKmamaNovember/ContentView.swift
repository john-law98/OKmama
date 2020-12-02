//
//  ContentView.swift
//  OKmamaNovember
//
//  Created by John Lawrence on 10/24/20.
//

import SwiftUI
import AVFoundation
import AVKit

//import SwiftAudioPlayer

struct ContentView: View {
	
	@State private var timer = Timer.publish(every: 1, tolerance: 0.1, on: .main, in: .common).autoconnect()
	
//    var body: some View {
//        Text("Hello, world!")
    //            .padding()
    //
    @State var audioPlayer:AVAudioPlayer?
    
    @State var isPlaying : Bool = false
    
    var body: some View {
		
		var time : TimeInterval = 0.0
		
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
				.onReceive(timer){ _ in
					if let currentTime = self.audioPlayer?.currentTime {
						if abs(currentTime - time) < 0.1 { // only explicitly
						   self.isPlaying = false
						}
					}
				}
		} // end VStack
		
		.onAppear(perform: {
			time = self.audioPlayer?.duration ?? 0.0
		})
		
        } // end View
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
