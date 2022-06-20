//
//  SoundPlayer.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 18.06.2022.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound : String,type : String) {
    //çalmak isteğimiz ses çalara gerekli ses dosyasını ekleriz
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Could not file and the play sound file.")
        }   
    }
}
