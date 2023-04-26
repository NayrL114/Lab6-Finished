//
//  GameEndViewController.swift
//  Lab5-Timer
//
//  Created by Pan Li on 26/4/2023.
//

import UIKit

class GameEndViewController: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    @IBOutlet weak var historyNameLabel: UILabel!
    @IBOutlet weak var historyScoreLabel: UILabel!
    
    @IBOutlet weak var congratMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congratMsg.isHidden = true
        
        playerNameLabel.text = DataStore.shared.currentPlayerName
        playerScoreLabel.text = String(DataStore.shared.currentPlayerScore)
        
        //print(DataStore.shared.storedResults)
        if (DataStore.shared.getStoredArraySize() > 0){// ensuring the array in DataStore is not empty
            historyNameLabel.text = DataStore.shared.storedResults[0].name
            historyScoreLabel.text = String(DataStore.shared.storedResults[0].score)
        }
        else{
            historyNameLabel.text = "N/A"
            historyScoreLabel.isHidden = true
        }
                
        if (DataStore.shared.compareWithStoredHighScore() == true) {
            congratMsg.isHidden = false
        }
        
        DataStore.shared.saveGameResults()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        print("play again button is pressed")
        
        // Below line simply goes back to the game view
        //self.navigationController?.popViewController(animated: true)
        
        // Below lines will first try to go to main menu without animation and transition to pre-game setting view
        let PreGameSettingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreGameSettingViewController") as! ViewController
        //self.navigationController?.popToRootViewController(animated: false)
        self.navigationController?.pushViewController(PreGameSettingViewController, animated: true)
        
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
