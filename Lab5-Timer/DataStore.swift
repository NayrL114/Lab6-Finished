//
//  DataStore.swift
//  Lab5-Timer
//
//  Created by Hayden Fang on 14/4/2023.
//

import Foundation

class DataStore {
    var name: String = ""
    var score: String = "0"
    
    static let shared = DataStore()
    
    init() {
        fatalError()
    }
}
