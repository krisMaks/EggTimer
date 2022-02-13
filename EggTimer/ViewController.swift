//
//  ViewController.swift
//  EggTimer
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggsTime = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle else { return }
        timer.invalidate()
        self.progressBar.progress = 0
        self.titleLabel.text = hardness
        var time = eggsTime[hardness]! * 60
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: { timer in
            self.progressBar.setProgress(Float(time), animated: true)
            print("\(time) seconds")
            time -= Int(timer.timeInterval)
            if time == 0 {
                self.titleLabel.text = "Done!"
                self.playSound()
                timer.invalidate()
            }
        })
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
