//
//  ContentView.swift
//  OKmamaNovember
//
//  Created by John Lawrence on 10/24/20.
//
import SwiftUI

// these import statments allow me to use audio
import AVFoundation
import AVKit
import SoundAnalysis


// This structure represents the "view" that the user sees when opening the app
// Launch screen is specified in info.plist
struct ContentView: View {
	
	// AudioPlayer variable
    @State var audioPlayer:AVAudioPlayer?
	@State var isPlaying : Bool = false

	// Initialization of a slider variable -- not used
	@State var sliderr: UISlider!
	
	// Need a timer to help determine when play/pause button changes state
	@State var playValue: TimeInterval = 0.0
	@State private var timer = Timer.publish(every: 1, tolerance: 0.1, on: .main, in: .common).autoconnect() // Timer established with refresh rate
	@State private var playerDuration: TimeInterval = 120

    var body: some View {

		var time : TimeInterval = 0.0

		// Vertical and horizontal stacks (VStack, HStack) are for organization of objects
		VStack {
			Text("Welcome to OK mama!")
				.font(Font.custom("FredokaOne-Regular", size: 20))
				.padding()
		HStack {
			
			// Progress bar goes here. See below for code to use to implement

			
			// This button object is linked to the audio file "1_3_", which is stored in this project
        Button(action: {
            if let path = Bundle.main.path(forResource: "1_3_", ofType: ".mp3"){
                self.audioPlayer = AVAudioPlayer()
                self.isPlaying.toggle()

                let url = URL(fileURLWithPath: path)
                do {
                    self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    self.audioPlayer?.prepareToPlay()
                    self.audioPlayer?.play()

                } catch  {
                    print("Error")
                }
            }
			
			// "label" modifies the button's image
        }, label: {
            if isPlaying {
                Image(systemName: "pause").font(Font.system(.largeTitle).bold()) // pause button
            } else {
                Image(systemName: "play.fill").font(Font.system(.largeTitle).bold()) // play button

            }

        }) // end button, reset timer
		.padding()
				.onReceive(timer){ _ in
					if let currentTime = self.audioPlayer?.currentTime { // creates currentTime variable
						
						// Checks for equality between currentTIme and time.
						// Use of inequality for comparison of floating point values
						if abs(currentTime - time) < 0.1 {
						   self.isPlaying = false
						}
					}
				}
		
		} // end HStack
			
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

/**
		CODE TO BE USED IF SLIDER/PROGRESS BAR IS IMPLEMENTED
*/
//				if audioPlayer == nil {
//					print("Error: \(String(describing: error))")
//				}
//				sliderr.maximumValue = Float(CMTimeGetSeconds(audioPlayer!.duration))
//				sliderr.value = Float(CMTimeGetSeconds(audioPlayer!.currentTime))
//
//			Slider(value: $playValue, in: TimeInterval(0.0)...playerDuration, onEditingChanged: { _ in
//				self.changeSliderValue()
//			})
//			.frame(width: 150, height: 10, alignment: Alignment.center)

//func changeSliderValue() {
//	self.audioPlayer?.currentTime = playValue
//}

