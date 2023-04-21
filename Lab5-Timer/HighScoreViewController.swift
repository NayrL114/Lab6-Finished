//
//  HighScoreViewController.swift
//  Lab5-Timer
//
//  Created by Hayden Fang on 14/4/2023.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let nameTag = 100
    let scoreTag = 101
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.shared.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        
        let player = DataStore.shared.players[indexPath.row]
                
        if let nameLabel = cell.viewWithTag(nameTag) as? UILabel{
            nameLabel.text = player.name
        }
              
        if let scoreLabel = cell.viewWithTag(scoreTag) as? UILabel{
            scoreLabel.text = player.score
        }
                
        return cell
    }
    

//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScoreTableView.delegate = self
        highScoreTableView.dataSource = self
        
        // At this stage, calling DataStore will cause the app to crash
        //nameLabel.text = DataStore.shared.name
        //scoreLabel.text = DataStore.shared.score

        // Do any additional setup after loading the view.
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
