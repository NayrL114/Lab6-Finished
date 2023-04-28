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
        case White
        
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
            case .White:
                return 0
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
            case .White:
                return UIColor.white
            }
        }
    }// end of enum
    
    var score: Int?
    var colour: BubbleColour?
    var bubbleID: Int?
    
    var distanceToScreenBound: Int = 60
    
    var configuredMaxBubbleNo: Int = DataStore.shared.configuredMaxBubbleNumber
    
    let yTopConstraint: Int
    
    init(colour: BubbleColour, ID: Int, yCon: Int) {
        self.colour = colour
        self.score = colour.score
        self.bubbleID = ID
        self.yTopConstraint = yCon
        
        // dynamically allocate area for bubble generation
        // var distanceToScreenBound: Int = 60
        let xPosition = Int.random(in: distanceToScreenBound...Int(UIScreen.main.bounds.width) - distanceToScreenBound)
        let yPosition = Int.random(in: yTopConstraint + distanceToScreenBound...Int(UIScreen.main.bounds.height) - distanceToScreenBound)
        
        let frame = CGRect(x: xPosition, y: yPosition, width: 50, height: 50)
        super.init(frame: frame)
        self.layer.cornerRadius = frame.width / 2
        self.clipsToBounds = true
        self.backgroundColor = colour.colour

        //bubbleStore.append(self)
    }
    
    func removeBubble() {
        self.removeFromSuperview()
    }
    
    // animatio code from week 7 lab recording
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}// end of class
