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
	
	func changeSliderValue() {
		self.audioPlayer?.currentTime = playValue
	}


    @State var audioPlayer:AVAudioPlayer?
    @State var isPlaying : Bool = false
	@State var playValue: TimeInterval = 0.0
	@State private var timer = Timer.publish(every: 1, tolerance: 0.1, on: .main, in: .common).autoconnect()
	@State private var playerDuration: TimeInterval = 120

    var body: some View {

		var time : TimeInterval = 0.0

		VStack {
			Text("Welcome to OK mama!")
				.font(Font.custom("FredokaOne-Regular", size: 20))
				.padding()
		HStack {


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
				.onReceive(timer){ _ in
					if let currentTime = self.audioPlayer?.currentTime {
						if abs(currentTime - time) < 0.1 { // only explicitly
						   self.isPlaying = false
						}
					}
				}
			
//		Text(String(playValue))
//			.font(Font.custom("FredokaOne-Regular", size: 14))
//			.onReceive(timer, perform: { _ in
//				if self.isPlaying {
//					if let currentTime = self.audioPlayer?.currentTime {
//						self.playValue = currentTime;
//					}
//				}
//			})
			
		
			Slider(value: $playValue, in: TimeInterval(0.0)...playerDuration, onEditingChanged: { _ in
				self.changeSliderValue()
			})
			.frame(width: 150, height: 10, alignment: Alignment.center)
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





////
//
//struct BubbleAudio: View {
//
//let text: String
//var unzipPath: URL
//
//@State private var playValue: TimeInterval = 0.0
//@State private var isPlaying: Bool = false
//
//@State private var playerDuration: TimeInterval = 120
//
//@State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//
//var body: some View {
//	VStack {
//		Text(playValue.stringFromTimeInterval())
//		.font(.system(size: 11, weight: .light))
//		.offset(y: +10)
//		.onReceive(timer) { _ in
//			if self.isPlaying {
//				if let currentTime = Sounds.audioPlayer?.currentTime {
//					self.playValue = currentTime
//				}
//			}
//			else {
//				self.isPlaying = false
//				self.timer.upstream.connect().cancel()
//			}
//		}
//		HStack {
//			Button(action: {
//				if self.isPlaying {
//					self.isPlaying.toggle()
//					Sounds.audioPlayer?.pause()
//				}
//				else {
//					self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//					if Sounds.playWAAudio(text: self.text, unzipPath: self.unzipPath) {
//						self.isPlaying.toggle()
//					}
//				}
//			}, label: {
//				  if isPlaying {
//					Image(systemName: "pause")
//					.font(Font.system(.title).bold())
//				  }
//				  else {
//					Image(systemName: "play.fill")
//					.font(Font.system(.title).bold())
//				  }
//			})
//			.frame(width: 35)
//			.fixedSize()
//			Slider(value: $playValue, in: TimeInterval(0.0)...playerDuration, onEditingChanged: { _ in
//				self.changeSliderValue()
//			})
//			.frame(width: 200, height: 10, alignment: Alignment.center)
//			Text(playerDuration.stringFromTimeInterval())
//			.font(.system(size: 11, weight: .light))
//		}
//	}
//	.onAppear() {
//		self.playerDuration = Sounds.getDuration(text: self.text, unzipPath: self.unzipPath)
//		print(self.playerDuration)
//	}
//}
//
//func changeSliderValue() {
//	Sounds.audioPlayer?.currentTime = playValue
//}
//}
