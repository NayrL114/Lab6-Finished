//
//  GameViewController.swift
//  Lab5-Timer
//
//  Created by Pan Li on 18/4/2023.
//

import UIKit

class GameViewController: UIViewController {
    
    var timer = Timer()
    var time: Int = 0
    
    let KEY_GAME_RESULT = "gameResult"
    var gameResultArray: [PlayerData] = []

    @IBOutlet weak var historyHighScoreName: UILabel!
    @IBOutlet weak var historyHighScoreLabel: UILabel!
    @IBOutlet weak var historyHighScoreTime: UILabel!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameResultArray = readGameResults()
        if (gameResultArray.count != 0){
            // retrieve the current high score from gameResultArray[0] and put it out on view
        }
        
        startGame()

        // Do any additional setup after loading the view.
    }
    
    func startGame(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.time = self.time - 1
            self.playerTimeLabel.text = String(self.time)
            if self.time == -1 {
                
                self.gameResultArray.append(PlayerData(name: self.playerNameLabel.text ?? "", score: self.playerScoreLabel.text ?? ""))
                self.saveGameResults()
                
                // Storing data in DataStore class
//                DataStore.shared.players.append(PlayerData(name: self.playerNameLabel.text ?? "", score: self.playerScoreLabel.text ?? ""))
//                DataStore.shared.players.sort {$0.score > $1.score}
                
                timer.invalidate()
            }
        })
    }
    
    @IBAction func bubbleButtonPressed(_ sender: UIButton) {
        if var score = Int(playerScoreLabel.text ?? "0") {
            score = score + 1
            playerScoreLabel.text = "\(score)"
        }
    }
    
    func saveGameResults(){
        let defaults = UserDefaults.standard
        defaults.set(self.gameResultArray, forKey: KEY_GAME_RESULT)
    }
    
    func readGameResults() -> [PlayerData] {
        let defaults = UserDefaults.standard
        guard let array = defaults.array(forKey: KEY_GAME_RESULT) as? [PlayerData] else {
            return []
        }
        return array
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
