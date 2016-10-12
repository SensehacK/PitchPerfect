//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Kautilya Save on 18/09/16.
//  Copyright © 2016 Kautilya Save. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    @IBOutlet weak var snailButton : UIButton!
    @IBOutlet weak var vaderButton : UIButton!
    @IBOutlet weak var echoButton : UIButton!
    @IBOutlet weak var rabbitButton : UIButton!
    @IBOutlet weak var chipmunkButton : UIButton!
    @IBOutlet weak var reverbButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    
    
    //@IBOutlet weak var recordTimeIntLabel: UIButton!
    //button.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    
    
    @IBOutlet weak var recordTimeIntLabel: UILabel!
    var recordedAudioURL: URL!
    var stopTimer2: Int!
    var audioFile: AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer : Timer!
    
    enum ButtonType :Int { case slow = 0 , fast, chipmunk,vader , echo, reverb }
    
    @IBAction func playSoundForButton (_ sender : UIButton)
    {
        print("Play sound button pressed")
        switch(ButtonType(rawValue: sender.tag)!)  //Couldnt understand Optionals ! , is it that optional will be available at runtime for sure confirmation, explicit optionals ? but if it doesn't reproduce it will crash the system right ?
        {
        case .slow :
            print("Slow option")
            playSound(rate: 0.5)
            
        case .fast :
            print("Fast option")
            playSound(rate : 1.5)
            
        case .chipmunk:
            print("Chipmunk option")
            playSound(pitch : 1000)
            
        case .vader:
            print("Darth Vader option")
            playSound(pitch: -1000)
            
        case .echo :
            print("Echo option")
            playSound(echo : true)
            
        case .reverb :
            print("Reverb option")
            playSound(reverb : true)
        }
        
        configureUI(.playing) // Enable Buttons "Record = false " , "Stop = True"
    }
    
    @IBAction func stopButton (_ sender : UIButton) {
        print("Stop button pressed")
        stopAudio()
    }

    
    var recordedAudio: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Play sound view controller loaded")
      recordTimeIntLabel.text = "Time : \(stopTimer2) secs"
        print(stopTimer2)
        print("Initializing Audio engine from other Swift Class")
        vaderButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        snailButton.imageView?.contentMode = .scaleAspectFit
setupAudio()  //Call to other class

        /*

        //snailButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit

        vaderButton.contentMode = UIViewContentMode.ScaleAspectFit
        snailButton.contentMode = UIViewContentMode.ScaleAspectFit
        reverbButton.contentMode = UIViewContentMode.ScaleAspectFit
        rabbitButton.contentMode = UIViewContentMode.ScaleAspectFit
        echoButton.contentMode = UIViewContentMode.ScaleAspectFit
        chipmunkButton.contentMode = UIViewContentMode.ScaleAspectFit
        // Do any additional setup after loading the view.
        
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)  //Not playing configuration loaded "Record = True" , "Stop = False"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
