//
//  GenreHomeScreen.swift
//  musicPlayerApp
//
//  Created by Daniel Carrera on 12/28/20.
//  Copyright © 2020 Daniel Carrera. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreHomeScreen: UIViewController {
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //
    // plays song of selected genre
    //
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        
        // request authorization to access media
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.playSong(genre: sender.currentTitle!)
                }
            }
        }
    }
    
    //
    // stop the current song being played.
    //
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    //
    // advance to next song in queue.
    //
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    
    //
    // plays a random song from given genre
    //
    func playSong(genre:String){
        
        // stop if song is currently playing
        // avoids multiple songs playing at once
        musicPlayer.stop()
        
        
        // generate a query and a predicate
        let genreQuery = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        // apply the predicate to the query
        genreQuery.addFilterPredicate(predicate)
        
        // get songs by genre query
        musicPlayer.setQueue(with: genreQuery)
        musicPlayer.shuffleMode = .songs
        
        // play the song
        musicPlayer.play()
    }
}
