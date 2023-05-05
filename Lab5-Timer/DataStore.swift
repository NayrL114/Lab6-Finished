import Foundation

struct PlayerData: Codable {
    let name: String
    let score: Int
    let time: Int
}

class DataStore {
    
    let KEY_GAME_RESULT = "gameResult"
    
    var currentPlayerName: String = ""
    var currentPlayerScore: Int = 0
    var currentPlayerTime: Int = 0    
    var configuredMaxBubbleNumber: Int = 0
    
    var storedResults: [PlayerData] = []
    
    var storedBubbles: [Bubble] = []
    
    var streakCounter: Int = 0
    var previousColour: Bubble.BubbleColour = Bubble.BubbleColour.White
    
    static let shared = DataStore()
    
    private init() {
        // initialise the result array
        storedResults = readGameResults()
    }
    
    // remove bubble from storedBubble array at desinated location
    func removeBubbleFromArrayAt(position: Int) {
        storedBubbles.remove(at: position)
    }
    
    // reset the storedBubble array
    func clearStoredBubbleArray() {
        storedBubbles = []
    }
    
    // compared the high score with passed in score
    func compareWithStoredHighScore() -> Bool {
        guard storedResults.count > 0 else{
            return true
        }
        return (currentPlayerScore > storedResults[0].score)
    }
    
    // append new player's score into stored array
    func storeNewDataIntoHighScore() {
        storedResults.append(PlayerData(name: currentPlayerName, score: currentPlayerScore, time: currentPlayerTime))
    }
    
    // sort the score array
    func sortStoredHighScore() {
        storedResults.sort { $0.score > $1.score }
    }
    
    // get the size for score array
    func getStoredArraySize() -> Int {
        return storedResults.count
    }
    
    // save the result array into user default
    func saveGameResults(){
        storeNewDataIntoHighScore()
        sortStoredHighScore()
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(storedResults), forKey: KEY_GAME_RESULT)
    }
    
    // retrieve previous result from user default
    func readGameResults() -> [PlayerData] {
        let defaults = UserDefaults.standard
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
    
    func clearGameResults(){
        let defaults = UserDefaults.standard
        //defaults.set(gameResultArray, forKey: KEY_GAME_RESULT)
        let emptyArray: [PlayerData] = []
        //DataStore.shared.gameResultArray
        storedResults = emptyArray
        defaults.set(try? PropertyListEncoder().encode(emptyArray), forKey: KEY_GAME_RESULT)
    }
}
