//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Kautilya Save on 16/09/16.
//  Copyright © 2016 Kautilya Save. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    @IBOutlet weak var recordLabel: UILabel!
    
    //@IBOutlet weak var progressLabel: UILabel!
    
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audiotime : AVAudioPlayer!
    var audioRecorder : AVAudioRecorder!
    var buttonPressed = 0                           //For tracking Record Button Pressed
    var stopButtonPressed = 0                       //For tracking Stop Record Button Pressed
    var recordTime : TimeInterval = 0.0           //For tracking time for Start Record Button Pressed
    var stopTime : TimeInterval = 0.0             //For tracking time for Stop Record Button Pressed
    var recordTimeInt : Int = 0                     //For converting NSInterval to Int
    var deviceCurrentTime : TimeInterval = 0.0    //Current Device Time

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View did appear")
        stopRecordingButton.isEnabled = false
        
    }
    
    
    
    
    
    @IBAction func recordAudio(_ sender: AnyObject)
    {
        buttonPressed += 1             //Tracking how many times Record Button pressed in an app instance
        
        // progressLabel.text = "Recording Button Pressed \(buttonPressed)"
        configureView(true)
        
        /* recordLabel.text = "Recording in Progress \(buttonPressed)"
        print("Record Button Pressed \(buttonPressed)")  //Just for console feedback.
      
        
        stopRecordingButton.enabled = true
        recordButton.enabled = false
         */
        
        
        //Directory path & file attributes
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        // let filePath = URL.FileURL(withPathComponents: pathArray)
        
        let filePath = URL(fileURLWithPath:pathArray)
        print(filePath)
        
        //Creating audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
       
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        //Extra method for determining how much time did the recording went on for.
        
        try!  audiotime = AVAudioPlayer(contentsOf: filePath!)
        
        
        audiotime.prepareToPlay()
        
        deviceCurrentTime = audiotime.deviceCurrentTime //Getting current Time on the press of a record Button
        // Start Point A of Recording
        
        print("Device Current Duration \(deviceCurrentTime)")       //Prints out Starting Time
        let intCurrentTime = Int(deviceCurrentTime)                 //Conversion
        
        print(intCurrentTime)                                       //Printing on console Starting Time
        
        
        //infinite loop
        //while((stopRecordingButton.enabled) == true){print(deviceCurrentTime)}
        
    }
    
    func configureView(_ recording:Bool){
        recordLabel.text = recording ? "Recording in Progress \(buttonPressed)" : "Tap to Record"
        stopRecordingButton.isEnabled = recording
        recordButton.isEnabled = !recording
    }
    
    
    @IBAction func stopRecording(_ sender: AnyObject)
    {
        // Recording Time Calculation
        stopTime = audiotime.deviceCurrentTime          //Stop Point B of Recording Finishes
        recordTime = stopTime - deviceCurrentTime       //Subtraction gives out the Recording Time
        print("Device Current Duration \(stopTime)")    //Prints out Stopping Time
        print("Record Time \(recordTime)")              // Subtracted Record time
        
        
        //Converted to just Seconds in Integer format
        
      recordTimeInt = Int(recordTime)                   //Conversion
        print("Record Time Int \(recordTimeInt)" )      //Console Print
        
        //normal program
        
        configureView(false)
        /*
        print("Recording  Stopped")
        stopButtonPressed++
        recordLabel.text = "Tap to Record"
        print("Stop Record Button Pressed \(stopButtonPressed)")
        stopRecordingButton.enabled = false
        recordButton.enabled = true
        */
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Recording did Finish")
        
        if (flag)
        {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            
            print("Recording been saved to storage")
        }
        else
        {
            //print(Alerts.AudioFileError)
            //showAlert(Alerts.AudioFileError, message: String(error))
            print("Saving to the recording failed ")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "stopRecording")
        {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
            //sending Record Time to PlaysViewController for Displaying the total Record Time in Integer Value
            playSoundsVC.stopTimer2 = recordTimeInt
        }
    }
    
}

