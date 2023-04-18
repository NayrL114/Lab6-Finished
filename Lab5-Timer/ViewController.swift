//
//  ViewController.swift
//  Lab5-Timer
//
//  Created by Hayden Fang on 27/3/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    var timer = Timer()
    var time: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func bubblePressed(_ sender: UIButton) {
        if var score = Int(scoreLabel.text ?? "0") {
            score = score + 1
            scoreLabel.text = "\(score)"
        }
    }
    
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if let name = nameTextField.text, name != "" {
            nameLabel.text = name
            textFieldLabel.isHidden = true
            nameTextField.isHidden = true
            sender.isHidden = true
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                self.time = self.time - 1
                self.timeLabel.text = String(self.time)
                if self.time == 0 {
                    // we want to save the name & score to somethere
                    
                    // At this stage, calling DataStore will cause the app to crash
                    //DataStore.shared.name = self.nameLabel.text ?? ""
                    //DataStore.shared.score = self.scoreLabel.text ?? "00"
                    
                    timer.invalidate()
                }
            })
        }
    }
    
}

