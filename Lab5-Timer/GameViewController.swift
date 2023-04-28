//
//  GameViewController.swift
//  Lab5-Timer
//
//  Created by Pan Li on 18/4/2023.
//

import UIKit
//import Bubble

class GameViewController: UIViewController {
    
    var timer = Timer()
    var time: Int = 0
    var name: String = ""
    
    //let bubble = Bubble()
    
    let KEY_GAME_RESULT = "gameResult"
    var gameResultArray: [PlayerData] = []

    @IBOutlet weak var historyHighScoreName: UILabel!
    @IBOutlet weak var historyHighScoreLabel: UILabel!
    @IBOutlet weak var historyHighScoreTime: UILabel!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerTimeLabel: UILabel!
    
    var countdownTime: Int = 3
    
    var totalBubbleNumbers: Int = 0
    var maxBubbleNumbers: Int = 0
    var bubbleID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //print(playerNameLabel.frame.origin.x) 16
        //print(playerNameLabel.frame.origin.y) 190
        
        //gameResultArray = readGameResults()
        if (DataStore.shared.storedResults.count != 0){
//            // retrieve the current high score from gameResultArray[0] and put it out on view
//            //print(gameResultArray)
            historyHighScoreName.text = DataStore.shared.storedResults[0].name
            historyHighScoreLabel.text = String(DataStore.shared.storedResults[0].score)
            historyHighScoreTime.text = String(DataStore.shared.storedResults[0].time)
        } else {
            historyHighScoreName.text = "N/A"
            historyHighScoreLabel.text = "0"
            historyHighScoreTime.text = "N/A"
        }
        
        //time = Int(playerTimeLabel.text!)!
        //print(time)
        
//        DataStore.shared.clearStoredBubbleArray()
//        self.totalBubbleNumbers = 0
//        playerTimeLabel.text = String(time)
//        playerNameLabel.text = name
        
        //DataStore.shared.currentPlayerTime = self.time
        
        self.time = DataStore.shared.currentPlayerTime
        self.name = DataStore.shared.currentPlayerName
        self.maxBubbleNumbers = DataStore.shared.configuredMaxBubbleNumber
        
        playerNameLabel.text = String(name)
        playerScoreLabel.text = "0"
        playerTimeLabel.text = String(time)
        
        DataStore.shared.streakCounter = 0
        DataStore.shared.previousColour = Bubble.BubbleColour.White
        
        //startGame()
        countDown()

        // Do any additional setup after loading the view.
    }
    
    func countDown() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let CountDownViewController = storyBoard.instantiateViewController(withIdentifier: "CountDownViewController") as! CountDownViewController
                self.present(CountDownViewController, animated: true, completion: nil)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.countdownTime = self.countdownTime - 1
            
            if self.countdownTime == 0 {
                self.startGame()
                
                timer.invalidate()
                
                
            }
        })
    }
    
    func startGame() {
        
        
        
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
//            self.countdownTime = self.countdownTime - 1
//
//            if self.countdownTime == 0 {
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let GameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
//                        self.present(GameViewController, animated: false, completion: nil)
//
//                timer.invalidate()
//
//
//            }
//        })
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.time = self.time - 1
            self.playerTimeLabel.text = String(self.time)
            
            self.removeRandomBubbles()
            //print("Before, \(self.totalBubbleNumbers)  \(DataStore.shared.storedBubbles.count)  \(self.maxBubbleNumbers)")
            self.generateBubble()
            //print("aFTER, \(self.totalBubbleNumbers)  \(DataStore.shared.storedBubbles.count)  \(self.maxBubbleNumbers)")
            
            
            if self.time == -1 {
                
//                self.gameResultArray.append(PlayerData(name: self.playerNameLabel.text ?? "", score: Int(self.playerScoreLabel.text ?? "0")! ))
//                self.gameResultArray.sort {$0.score > $1.score}
                
                DataStore.shared.currentPlayerName = self.name
                DataStore.shared.currentPlayerScore = Int(self.playerScoreLabel.text ?? "0")!
//                DataStore.shared.currentPlayerTime = self.time
                DataStore.shared.storedResults = self.gameResultArray
                
                
                
                //self.saveGameResults()
                
                // Below code goes to game end view
                let GameEndViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameEndViewController") as! GameEndViewController
                self.navigationController?.pushViewController(GameEndViewController, animated: true)
                
                // Storing data in DataStore class
//                DataStore.shared.players.append(PlayerData(name: self.playerNameLabel.text ?? "", score: self.playerScoreLabel.text ?? ""))
//                DataStore.shared.players.sort {$0.score > $1.score}
                
                //self.navigationController?.popToRootViewController(animated: true)
                
                timer.invalidate()
                
                
            }
        })
    }
    
    @IBAction func bubbleButtonPressed(_ sender: Bubble) { //Bubble is a subclass of UIButton
        if var score = Int(playerScoreLabel.text ?? "0") {
            //score = score + 1
            
            print("sender colour should be \(sender.colour!)")
            print("previous colour should be \(DataStore.shared.previousColour)")
            
            if sender.colour == DataStore.shared.previousColour {
                
                DataStore.shared.streakCounter += 1
                print("same colour as previous, combo is \(DataStore.shared.streakCounter)")
            } else {
                DataStore.shared.streakCounter = 0
                DataStore.shared.previousColour = sender.colour!
                print("new colour, reset combo back to \(DataStore.shared.streakCounter)")
            }
            
            var multiplier: Double = 1.0
            if DataStore.shared.streakCounter > 0 {
                multiplier = 1.5
            }
            
            print("multiplier is \(multiplier)")
            print("bubble base score is \(sender.score!)")
            print("This bubble is worth double score \((Double(sender.score!) * pow(multiplier, Double(DataStore.shared.streakCounter))))")
            print("After rounding the int score should be \(round((Double(sender.score!) * pow(multiplier, Double(DataStore.shared.streakCounter)))))")
            
            //if (DataStore.shared.streakCounter > 0){
            score = Int(Double(score) + round((Double(sender.score!) * pow(multiplier, Double(DataStore.shared.streakCounter)))))
            //} else {
            //    score = Int(score + sender.score!)
            //}
            
            
            playerScoreLabel.text = "\(score)"
            sender.flash()
            sender.removeFromSuperview()
            
            for index in (0...DataStore.shared.storedBubbles.count - 1) {
                if DataStore.shared.storedBubbles[index].bubbleID == sender.bubbleID {
                    DataStore.shared.removeBubbleFromArrayAt(position: index)
                    totalBubbleNumbers -= 1
                    print("Remove, \(self.totalBubbleNumbers)  \(DataStore.shared.storedBubbles.count)  \(self.maxBubbleNumbers)")
                    return
                }
            }// end of for loop
        }
    }
    
    func generateBubble(){
        guard totalBubbleNumbers < maxBubbleNumbers else {
            return
        }
        
        let generateNumberThisTime: Int = Int.random(in: 1...maxBubbleNumbers-totalBubbleNumbers)
        for _ in (1...generateNumberThisTime){
            // generate a new bubble object here, assign colour and id, place in view
            //bubble = Bubble(colour: .Black, ID: bubbleID)
            
            // This do...while loop should generate non-overlapping bubbles
            var overlapping: Bool
            //var bubble: Bubble = nil
            repeat{
                let probability = Int.random(in: 1...100)
                let bubble: Bubble
                switch probability {
                case 1...40:
                    bubble = Bubble(colour: Bubble.BubbleColour.Red, ID: bubbleID)
                case 41...70:
                    bubble = Bubble(colour: Bubble.BubbleColour.Pink, ID: bubbleID)
                case 71...85:
                    bubble = Bubble(colour: Bubble.BubbleColour.Green, ID: bubbleID)
                case 86...95:
                    bubble = Bubble(colour: Bubble.BubbleColour.Blue, ID: bubbleID)
                default:
                    bubble = Bubble(colour: Bubble.BubbleColour.Black, ID: bubbleID)
                }
                overlapping = checkBubbleOverlapping(bubble: bubble)
                
                if (!overlapping) {
                    bubble.animation()
                    //bubble.addTarget(self, action: #selector(bubble.removeBubbleOnClick()), for: .touchUpInside)
                    bubble.addTarget(self, action: #selector(bubbleButtonPressed), for: .touchUpInside)
                    self.view.addSubview(bubble)
                    
                    bubbleID += 1
                    DataStore.shared.storedBubbles.append(bubble)
                }
            } while (overlapping)
            
            //let bubble = Bubble()
            //let bubble = Bubble(colour: Bubble.BubbleColour.Red, ID: bubbleID)
            
//            bubble.animation()
//            //bubble.addTarget(self, action: #selector(bubble.removeBubbleOnClick()), for: .touchUpInside)
//            bubble.addTarget(self, action: #selector(bubbleButtonPressed), for: .touchUpInside)
//            self.view.addSubview(bubble)
//
//            bubbleID += 1
//            DataStore.shared.storedBubbles.append(bubble)
        }
        
        totalBubbleNumbers += generateNumberThisTime
        
//        bubble.animation()
//        //bubble.addTarget(self, action: #selector(bubble.removeBubbleOnClick()), for: .touchUpInside)
//        bubble.addTarget(self, action: #selector(bubbleButtonPressed), for: .touchUpInside)
//        self.view.addSubview(bubble)
    }// end of generateBubble()
            
    func checkBubbleOverlapping(bubble: Bubble) -> Bool {
        guard DataStore.shared.storedBubbles.count > 0 else {
            return false
        }
        for index in (0...DataStore.shared.storedBubbles.count - 1){
            if (CGRectIntersectsRect(bubble.frame, DataStore.shared.storedBubbles[index].frame)) {
                return true
             }
        }
        return false
    }
    
    func removeRandomBubbles() {
        guard DataStore.shared.storedBubbles.count > 1 else {
            return
        }
        
        let totalRemoveNumber = Int.random(in: 1...DataStore.shared.storedBubbles.count)
        var counter: Int = 0
        //print("This time we are suppose to remove \(totalRemoveNumber) bubbles")
        while(counter < totalRemoveNumber){
            
            //print("length of storedBubble array is \(DataStore.shared.storedBubbles.count)")
            let removePosition = Int.random(in: 0...DataStore.shared.storedBubbles.count - 1)
            DataStore.shared.storedBubbles[removePosition].removeBubble()
            DataStore.shared.storedBubbles.remove(at: removePosition)
            
            counter += 1
            totalBubbleNumbers -= 1
        }
    }
    
//    func saveGameResults(){
//        let defaults = UserDefaults.standard
//        //defaults.set(gameResultArray, forKey: KEY_GAME_RESULT)
//        defaults.set(try? PropertyListEncoder().encode(gameResultArray), forKey: KEY_GAME_RESULT)
//    }
    
//    func readGameResults() -> [PlayerData] {
//        let defaults = UserDefaults.standard
//        guard let array = defaults.array(forKey: KEY_GAME_RESULT) as? [PlayerData] else {
//            return []
//        }
//        return array
//    }
    
//    func readGameResults() -> [PlayerData] {
//        let defaults = UserDefaults.standard
////        guard let array = defaults.array(forKey: KEY_GAME_RESULT) as? [PlayerData] else {
////            return []
////        }
//        if let savedArrayData = defaults.value(forKey: KEY_GAME_RESULT) as? Data {
//            if let array = try? PropertyListDecoder().decode(Array<PlayerData>.self, from: savedArrayData){
//                return array
//            } else {
//                return []
//            }
//        } else {
//            return []
//        }
//        //return array
//    }
    
//    func setTime(passedTime: Int){
//        time = passedTime
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
