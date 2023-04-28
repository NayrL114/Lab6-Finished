//
//  HighScoreViewController.swift
//  Lab5-Timer
//
//  Created by Hayden Fang on 14/4/2023.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let KEY_GAME_RESULT = "gameResult"
    //var gameResultArray: [PlayerData] = []
    
    let nameTag = 100
    let scoreTag = 101
    let timeTag = 102
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.shared.storedResults.count
        //return readGameResults().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        
        let gameResultArray = DataStore.shared.storedResults
        let player = gameResultArray[indexPath.row]
        
//        let player = DataStore.shared.players[indexPath.row]

        if let nameLabel = cell.viewWithTag(nameTag) as? UILabel{
            nameLabel.text = player.name
        }

        if let scoreLabel = cell.viewWithTag(scoreTag) as? UILabel{
            scoreLabel.text = String(player.score)
        }
        
        if let timeLabel = cell.viewWithTag(timeTag) as? UILabel{
            timeLabel.text = String(player.time)
        }
                
        return cell
    }
    

//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gameResultArray = readGameResults()
        //print(gameResultArray[0].name)
//        if (gameResultArray.count != 0){
//            // retrieve the current high score from gameResultArray[0] and put it out on view
//        }
        
        highScoreTableView.delegate = self
        highScoreTableView.dataSource = self
        
        // At this stage, calling DataStore will cause the app to crash
        //nameLabel.text = DataStore.shared.name
        //scoreLabel.text = DataStore.shared.score

        // Do any additional setup after loading the view.
    }
    
//    func saveGameResults(){
//        let defaults = UserDefaults.standard
//        defaults.set(self.gameResultArray, forKey: KEY_GAME_RESULT)
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
    
    func clearGameResults() {
        let defaults = UserDefaults.standard
        //defaults.set(gameResultArray, forKey: KEY_GAME_RESULT)
        let emptyArray: [PlayerData] = []
        defaults.set(try? PropertyListEncoder().encode(emptyArray), forKey: KEY_GAME_RESULT)
    }
    
//    func saveGameResults(){
//        let defaults = UserDefaults.standard
//        //defaults.set(gameResultArray, forKey: KEY_GAME_RESULT)
//        defaults.set(try? PropertyListEncoder().encode(gameResultArray), forKey: KEY_GAME_RESULT)
//    }
    
    @IBAction func clearDataButtonPressed(_ sender: UIButton) {
        // Following code for creating alert window is from an online tutorial,
        // Link: www.appsdeveloperblog.com/how-to-show-an-alert-in-swift
        
        // Create Alert
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            //print("Ok button tapped")
            self.clearGameResults()
            // Go back to previous screen, which should be the main menu in current context
            self.navigationController?.popViewController(animated: true)
            // Update UI here to make the table display with empty results
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            //print("Cancel button tapped")
        }
        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Present alert message to user
        self.present(dialogMessage, animated: true, completion: nil)
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
