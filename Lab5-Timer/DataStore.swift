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
    var name: String = ""
    var score: String = "0"
    
    var players: [PlayerData] = []
    
    static let shared = DataStore()
    
    private init() {
        //fatalError()
    }
}
