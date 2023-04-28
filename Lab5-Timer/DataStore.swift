//
//  DataStore.swift
//  Lab5-Timer
//
//  Created by Hayden Fang on 14/4/2023.
//

import Foundation

//struct PlayerData{
//    let name: String
//    let score: String
//}

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
        //fatalError()
    }
    
//    func removeRandomBubbles() {
//        let totalRemoveNumber = Int.random(in: 1...storedBubbles.count)
//        var counter: Int = 0
//        while(counter <= totalRemoveNumber){
//            let removePosition = Int.random(in: 0...storedBubbles.count)
//            storedBubbles.remove(at: removePosition)
//        }
//    }
    
    func removeBubbleFromArrayAt(position: Int) {
        storedBubbles.remove(at: position)
    }
    
    func clearStoredBubbleArray() {
        storedBubbles = []
    }
    
    func compareWithStoredHighScore() -> Bool {
        guard storedResults.count > 0 else{
            return true
        }
        return (currentPlayerScore > storedResults[0].score)
    }
    
    func storeNewDataIntoHighScore() {
        storedResults.append(PlayerData(name: currentPlayerName, score: currentPlayerScore))
    }
    
    func sortStoredHighScore() {
        storedResults.sort { $0.score > $1.score }
    }
    
    func getStoredArraySize() -> Int {
        return storedResults.count
    }
    
    func saveGameResults(){
        storeNewDataIntoHighScore()
        sortStoredHighScore()
        let defaults = UserDefaults.standard
        //defaults.set(gameResultArray, forKey: KEY_GAME_RESULT)
        defaults.set(try? PropertyListEncoder().encode(storedResults), forKey: KEY_GAME_RESULT)
    }
    
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
}
