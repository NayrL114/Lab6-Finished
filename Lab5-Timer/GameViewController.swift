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
    var name: String = ""
    
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
        
        if (DataStore.shared.storedResults.count != 0){
            // retrieve the current high score from gameResultArray[0] and put it out on view
            historyHighScoreName.text = DataStore.shared.storedResults[0].name
            
//            historyHighScoreLabel.text = String(DataStore.shared.storedResults[0].score)
//            historyHighScoreTime.text = String(DataStore.shared.storedResults[0].time)
            
            historyHighScoreLabel.text = "\(DataStore.shared.storedResults[0].score) pts"
            historyHighScoreTime.text = "\(DataStore.shared.storedResults[0].time) secs"
            
        } else {
            historyHighScoreName.text = "N/A"
            historyHighScoreLabel.text = "0 Points"
            historyHighScoreTime.text = "N/A"
        }
        
        self.time = DataStore.shared.currentPlayerTime
        self.name = DataStore.shared.currentPlayerName
        self.maxBubbleNumbers = DataStore.shared.configuredMaxBubbleNumber
        
        playerNameLabel.text = String(name)
        playerScoreLabel.text = "0"
        playerTimeLabel.text = String(time)
        
        DataStore.shared.streakCounter = 0
        DataStore.shared.previousColour = Bubble.BubbleColour.White
        DataStore.shared.storedBubbles = []
        
        totalBubbleNumbers = 0
        bubbleID = 0
        
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
        })// end of timer declaration
    }
    
    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.time = self.time - 1
            self.playerTimeLabel.text = String(self.time)
            
            print("Before Removing, \(self.totalBubbleNumbers)  \(DataStore.shared.storedBubbles.count)  \(self.maxBubbleNumbers)")
            self.removeRandomBubbles()
            print("After Removing, \(self.totalBubbleNumbers)  \(DataStore.shared.storedBubbles.count)  \(self.maxBubbleNumbers)")
            self.generateBubble()
            print("After Generating, \(self.totalBubbleNumbers)  \(DataStore.shared.storedBubbles.count)  \(self.maxBubbleNumbers)")
            print("---")
            
            if self.time == -1 {
                
                // Stored the data into DataStore class for next screen to process
                DataStore.shared.currentPlayerName = self.name
                DataStore.shared.currentPlayerScore = Int(self.playerScoreLabel.text ?? "0")!
                
                // Below code goes to game end view
                let GameEndViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameEndViewController") as! GameEndViewController
                self.navigationController?.pushViewController(GameEndViewController, animated: true)
                
                timer.invalidate()
                
            }
        })// end of timer declaration
    }// end of startGame()
    
    @IBAction func bubbleButtonPressed(_ sender: Bubble) { //Bubble is a subclass of UIButton
        if var score = Int(playerScoreLabel.text ?? "0") {
            
            // If two or more bubbles of the same colour are popped in a consecutive sequence,
            // the bubbles after the first one will get 1.5 times their original game points.
            if sender.colour == DataStore.shared.previousColour {
                DataStore.shared.streakCounter += 1
            } else {
                DataStore.shared.streakCounter = 0
                DataStore.shared.previousColour = sender.colour!
            }
            
            var multiplier: Double = 1.0
            if DataStore.shared.streakCounter > 0 {
                multiplier = 1.5
            }
            
//            print("multiplier is \(multiplier)")
//            print("bubble base score is \(sender.score!)")
//            print("This bubble is worth double score \((Double(sender.score!) * pow(multiplier, Double(DataStore.shared.streakCounter))))")
//            print("After rounding the int score should be \(round((Double(sender.score!) * pow(multiplier, Double(DataStore.shared.streakCounter)))))")
            
            //score = Int(Double(score) + round((Double(sender.score!) * pow(multiplier, Double(DataStore.shared.streakCounter)))))
            score = Int(Double(score) + round((Double(sender.score!) * multiplier)))
            
            playerScoreLabel.text = "\(score)"
            sender.flash()
            sender.removeFromSuperview()
            
            // Remove this bubble from storedBubble array
            for index in (0...DataStore.shared.storedBubbles.count - 1) {
                if DataStore.shared.storedBubbles[index].bubbleID == sender.bubbleID {
                    DataStore.shared.removeBubbleFromArrayAt(position: index)
                    totalBubbleNumbers -= 1
                    return
                }
            }// end of for loop
        }
    } // end of bubbleButtonPressed()
    
    func generateBubble(){
        guard totalBubbleNumbers < maxBubbleNumbers else {
            return
        }
        
        print("There should be \(DataStore.shared.storedBubbles.count) bubbles present in the screen")
        
        let generateNumberThisTime: Int = Int.random(in: 1...maxBubbleNumbers-totalBubbleNumbers)
        for _ in (1...generateNumberThisTime){
            // generate a new bubble object here, assign colour and id, place in view
            
            // This do...while loop should generate non-overlapping bubbles
            var overlapping: Bool
            //var bubble: Bubble = nil
            repeat{
                let probability = Int.random(in: 1...100)
                let bubble: Bubble
                switch probability {
                case 1...40:
                    bubble = Bubble(colour: Bubble.BubbleColour.Red, ID: bubbleID, yCon: Int(playerScoreLabel.frame.origin.y))
                case 41...70:
                    bubble = Bubble(colour: Bubble.BubbleColour.Pink, ID: bubbleID, yCon: Int(playerScoreLabel.frame.origin.y))
                case 71...85:
                    bubble = Bubble(colour: Bubble.BubbleColour.Green, ID: bubbleID, yCon: Int(playerScoreLabel.frame.origin.y))
                case 86...95:
                    bubble = Bubble(colour: Bubble.BubbleColour.Blue, ID: bubbleID, yCon: Int(playerScoreLabel.frame.origin.y))
                default:
                    bubble = Bubble(colour: Bubble.BubbleColour.Black, ID: bubbleID, yCon: Int(playerScoreLabel.frame.origin.y))
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
            } while (overlapping) // if this bubble overlaps, create another one
        }// end of for loop
        
        totalBubbleNumbers += generateNumberThisTime
        
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
    
    func removeRandomBubbles() { // remove random number of bubbles every second
        guard DataStore.shared.storedBubbles.count > 0 else {
            return
        }
        
        print(" ------ ")
        print("There should be \(DataStore.shared.storedBubbles.count) bubbles present in the screen")
        
        let totalRemoveNumber = Int.random(in: 1...DataStore.shared.storedBubbles.count)
        print("lets remove \(totalRemoveNumber) bubbles this time")
        var counter: Int = 0
        //print("This time we are suppose to remove \(totalRemoveNumber) bubbles")
        while(counter < totalRemoveNumber){
            print("counter is \(counter)")
            //print("length of storedBubble array is \(DataStore.shared.storedBubbles.count)")
            let removePosition = Int.random(in: 0...DataStore.shared.storedBubbles.count - 1)
            DataStore.shared.storedBubbles[removePosition].removeBubble()
            DataStore.shared.storedBubbles.remove(at: removePosition)
            
            counter += 1
            totalBubbleNumbers -= 1
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}// end of class
