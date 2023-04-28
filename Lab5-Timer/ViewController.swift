//
//  ViewController.swift
//  Lab5-Timer
//
//  Created by Hayden Fang on 27/3/2023.
//

import UIKit

struct PlayerData: Codable {
    let name: String
    let score: Int
}

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    @IBOutlet weak var gameTimeSlider: UISlider!
    @IBOutlet weak var gameBubbleSlider: UISlider!
    
    @IBOutlet weak var gameTimeSliderLabel: UILabel!
    @IBOutlet weak var gameBubbleSliderLabel: UILabel!
    
    @IBOutlet weak var testBubbleButton: UIButton!
    
    //var GVC = GameViewController()
    
    var timer = Timer()
    var time: Int = 0
    var name: String?
    
    let KEY_GAME_SETTINGS = "gameSettings"
    let KEY_GAME_RESULT = "gameResult"
    
    var gameSettingsArray: [Int] = []
    var gameResultArray: [PlayerData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testBubbleButton.isHidden = true
        
        gameSettingsArray = readGameSettings()// retrieve game setting data from UserDefault
        //gameResultArray = readGameResults()
        
        if (gameSettingsArray.count != 0){// make sure empty array is not accessed.
            // update view elements with game settings stored in UserDefault
            gameTimeSlider.value = Float(gameSettingsArray[0])
            gameBubbleSlider.value = Float(gameSettingsArray[1])
//            gameTimeSliderLabel.text = "\(Int(gameTimeSlider.value)) Seconds"
//            gameBubbleSliderLabel.text = "\(Int(gameBubbleSlider.value)) Bubbles"
        }
        gameTimeSliderLabel.text = "\(Int(gameTimeSlider.value)) Seconds"
        gameBubbleSliderLabel.text = "\(Int(gameBubbleSlider.value)) Bubbles"
        //print(Int(gameSettingsArray[0]))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            VC.time = Int(gameTimeSlider.value)
            //VC.playerNameLabel.text = nameTextField.text ?? ""
            VC.name = nameTextField.text ?? ""
        }
    }

    @IBAction func bubblePressed(_ sender: UIButton) {
        if var score = Int(scoreLabel.text ?? "0") {
            score = score + 1
            scoreLabel.text = "\(score)"
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        name = nameTextField.text ?? ""
        saveGameSettings()
//        if let name = nameTextField.text, name != "" {
//
//            saveGameSettings()
//
//            nameLabel.text = name
//            textFieldLabel.isHidden = true
//            nameTextField.isHidden = true
//            sender.isHidden = true
//
//            //time = Int(gameTimeSlider.value)
//
//            //GVC.time = Int(gameTimeSlider.value)
//            //GVC.setTime(passedTime: Int(gameTimeSlider.value))
//
//
//             // displaying the bubble button
//            //testBubbleButton.isHidden = false
//
////            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
////                self.time = self.time - 1
////                self.timeLabel.text = String(self.time)
////                if self.time == 0 {
////                    // we want to save the name & score to somethere
////
////                    // At this stage, calling DataStore will cause the app to crash
////                    //DataStore.shared.name = self.nameLabel.text ?? ""
////                    //DataStore.shared.score = self.scoreLabel.text ?? "00"
////
////                    self.gameResultArray.append(PlayerData(name: self.nameLabel.text ?? "", score: self.scoreLabel.text ?? ""))
////                    print("Before sorting array is \(self.gameResultArray)")
////                    self.gameResultArray.sort {$0.score > $1.score}
////                    print("After sorting array is \(self.gameResultArray)")
////                    self.saveGameResults()
////
//////                    DataStore.shared.players.append(PlayerData(name: self.nameLabel.text ?? "", score: self.scoreLabel.text ?? ""))
//////                    DataStore.shared.players.sort {$0.score > $1.score}
////
////                    timer.invalidate()
////                }
////            })// end of timer declaration
//        }
    }
    
    @IBAction func timeSliderMoved(_ sender: UISlider) {
        gameTimeSliderLabel.text = "\(Int(gameTimeSlider.value)) Seconds"
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        // This IBAction function is used to update the bubble slider text
        gameBubbleSliderLabel.text = "\(Int(gameBubbleSlider.value)) Bubbles"
    }
    
    func saveGameSettings(){
        let defaults = UserDefaults.standard
        defaults.set([Int(gameTimeSlider.value), Int(gameBubbleSlider.value)], forKey: KEY_GAME_SETTINGS)
    }
    
    func readGameSettings() -> [Int] {
        let defaults = UserDefaults.standard
        guard let array = defaults.array(forKey: KEY_GAME_SETTINGS) as? [Int] else {
            return []
        }
        return array
    }
    
    func saveGameResults(){
        let defaults = UserDefaults.standard
        //defaults.set(gameResultArray, forKey: KEY_GAME_RESULT)
        defaults.set(try? PropertyListEncoder().encode(gameResultArray), forKey: KEY_GAME_RESULT)
    }
        
    func readGameResults() -> [PlayerData] {
        let defaults = UserDefaults.standard
//        guard let array = defaults.array(forKey: KEY_GAME_RESULT) as? [PlayerData] else {
//            return []
//        }
        if let savedArrayData = defaults.value(forKey: KEY_GAME_RESULT) as? Data {
            if let array = try? PropertyListDecoder().decode(Array<PlayerData>.self, from: savedArrayData){
                return array
            } else {
                return []
            }
        } else {
            return []
        }
        //return array
    }
    
}

