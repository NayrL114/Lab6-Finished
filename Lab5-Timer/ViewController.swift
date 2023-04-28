import UIKit

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
    
    
    //var GVC = GameViewController()
    
    var timer = Timer()
    var time: Int = 0
    var name: String?
    
    //var countdownTimer = Timer()
    var countdownTime: Int = 3
    
    let KEY_GAME_SETTINGS = "gameSettings"
    let KEY_GAME_RESULT = "gameResult"
    
    var gameSettingsArray: [Int] = []
    var gameResultArray: [PlayerData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownTime = 3
        
        gameSettingsArray = readGameSettings()// retrieve game setting data from UserDefault
        //gameResultArray = readGameResults()
        
        if (gameSettingsArray.count != 0){// make sure empty array is not accessed.
            // update view elements with game settings stored in UserDefault
            gameTimeSlider.value = Float(gameSettingsArray[0])
            gameBubbleSlider.value = Float(gameSettingsArray[1])
        }
        gameTimeSliderLabel.text = "\(Int(gameTimeSlider.value)) Seconds"
        gameBubbleSliderLabel.text = "\(Int(gameBubbleSlider.value)) Bubbles"
        
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        name = nameTextField.text ?? ""
        
        // pass the player input data through DataStore for next screen to handle
        DataStore.shared.currentPlayerName = nameTextField.text ?? ""
        DataStore.shared.currentPlayerTime = Int(gameTimeSlider.value)
        DataStore.shared.configuredMaxBubbleNumber = Int(gameBubbleSlider.value)
        
        saveGameSettings()
        
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

