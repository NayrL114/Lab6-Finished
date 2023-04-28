//
//  GameEndViewController.swift
//  Lab5-Timer
//
//  Created by Pan Li on 26/4/2023.
//

import UIKit

class GameEndViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let nameTag = 200
    let scoreTag = 201
    let timeTag = 202
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.shared.storedResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCellEnd", for: indexPath)
        
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
    

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerTimeLabel: UILabel!
    
    @IBOutlet weak var historyNameLabel: UILabel!
    @IBOutlet weak var historyScoreLabel: UILabel!
    
    @IBOutlet weak var congratMsg: UILabel!
    
    @IBOutlet weak var endgameHighScoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endgameHighScoreTableView.delegate = self
        endgameHighScoreTableView.dataSource = self
        
        congratMsg.isHidden = true
        
        playerNameLabel.text = DataStore.shared.currentPlayerName
        playerScoreLabel.text = String(DataStore.shared.currentPlayerScore)
        playerTimeLabel.text = String(DataStore.shared.currentPlayerTime)
        
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//            label.center = CGPoint(x: 160, y: 285)
//            label.textAlignment = .center
//            label.text = "I'm a test label"
//
//            self.view.addSubview(label)
        
        //print(DataStore.shared.storedResults)
//        if (DataStore.shared.getStoredArraySize() > 0){// ensuring the array in DataStore is not empty
//            historyNameLabel.text = DataStore.shared.storedResults[0].name
//            historyScoreLabel.text = String(DataStore.shared.storedResults[0].score)
//        }
//        else{
//            historyNameLabel.text = "N/A"
//            historyScoreLabel.isHidden = true
//        }
        
        print("before")
        print(DataStore.shared.storedResults)
                
        if (DataStore.shared.compareWithStoredHighScore() == true) {
            congratMsg.isHidden = false
        }
        
        DataStore.shared.saveGameResults()
        
        print("after")
        print(DataStore.shared.storedResults)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func returnToMainButtonPressed(_ sender: UIButton) {
        print("return to main button is pressed")
        self.navigationController?.popToRootViewController(animated: true)
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
