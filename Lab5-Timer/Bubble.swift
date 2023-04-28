//
//  Bubble.swift
//  Lab5-Timer
//
//  Created by Pan Li on 28/4/2023.
//

import Foundation
import UIKit

class Bubble: UIButton {
    
    enum BubbleColour {
        case Red
        case Pink
        case Green
        case Blue
        case Black
        
        var score: Int {
            switch self {
            case .Red:
                return 1
            case .Pink:
                return 2
            case .Green:
                return 5
            case .Blue:
                return 8
            case .Black:
                return 10
            }
        }
        
        var colour: UIColor {
            switch self {
            case .Red:
                return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            case .Pink:
                return UIColor(red: 1, green: 192/255, blue: 203/55, alpha: 1)
            case .Green:
                return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            case .Blue:
                return UIColor(red: 0, green: 0, blue: 1, alpha: 1)
            case .Black:
                return UIColor.black
            }
        }
    }// end of enum
    
    var score: Int
    var colour: BubbleColour
    var isClicked = false
    var gameViewController: ViewController?
    
    var configuredMaxBubbleNo: Int = DataStore.shared.configuredMaxBubbleNumber
    
    var bubbleStore: [Bubble] = []
    
    init(colour: BubbleColour) {
        self.colour = colour
        self.score = colour.score
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        super.init(frame: frame)
        self.layer.cornerRadius = frame.width / 2
        self.clipsToBounds = true
        self.backgroundColor = colour.colour
        
        bubbleStore.append(self)
    }
    
    func removeBubbleOnClick() {
        //bubbleStore.remove(self)
//        if isClicked == true {
//            self.removeFromSuperview()
//        }
        self.removeFromSuperview()
        
    }
    
    func generateBubble() {
        //let probability = int.random(in: 1...100)
        
    }
    
    func removeRandomBubbles() {
        let totalRemoveNumber = Int.random(in: 1...configuredMaxBubbleNo)
        var counter: Int = 0
        while(counter <= totalRemoveNumber){
            let removePosition = Int.random(in: 0...bubbleStore.count)
            bubbleStore.remove(at: removePosition)
        }
    }
    
    func removeBubbleFromArrayAt(position: Int) {
        bubbleStore.remove(at: position)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}// end of class
