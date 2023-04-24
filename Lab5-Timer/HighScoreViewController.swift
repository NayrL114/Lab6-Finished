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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return DataStore.shared.players.count
        return readGameResults().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        
        let gameResultArray = readGameResults()
        let player = gameResultArray[indexPath.row]
        
//        let player = DataStore.shared.players[indexPath.row]

        if let nameLabel = cell.viewWithTag(nameTag) as? UILabel{
            nameLabel.text = player.name
        }

        if let scoreLabel = cell.viewWithTag(scoreTag) as? UILabel{
            scoreLabel.text = String(player.score)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
