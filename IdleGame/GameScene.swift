//
//  GameScene.swift
//  IdleGame
//
//  Created by Garrett Moody on 4/27/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var background:SKSpriteNode?
    var tapButton:SKSpriteNode?
    var upgrade1:SKSpriteNode?
    var upgrade2:SKSpriteNode?
    
    var scoreLB:SKLabelNode?
    var tapcostLB:SKLabelNode?
    var autocostLB:SKLabelNode?
    
    var touchpoints = 1
    var autopoints = 0
    var upgrade1cost = 100
    var upgrade2cost = 15

    func restoreUserData() {
        let defaults = UserDefaults.standard
        if defaults.array(forKey: "previousSave") != nil {
            let savedVariables = defaults.array(forKey: "previousSave") as! Array<Int>
            touchpoints = savedVariables[0]
            autopoints = savedVariables[1]
            upgrade1cost = savedVariables[2]
            upgrade2cost = savedVariables[3]
            let savedScore = savedVariables[4]
            
            print(savedVariables)
            
            scoreLB?.attributedText = NSAttributedString(string: String(savedScore), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 100.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
            
            tapcostLB?.attributedText = NSAttributedString(string: String(upgrade1cost), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 32.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
            
            autocostLB?.attributedText = NSAttributedString(string: String(upgrade2cost), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 32.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
            
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        background = self.childNode(withName: "background") as? SKSpriteNode
        tapButton = self.childNode(withName: "tapButton") as? SKSpriteNode
        upgrade1 = self.childNode(withName: "upgrade1") as? SKSpriteNode
        upgrade2 = self.childNode(withName: "upgrade2") as? SKSpriteNode
        
        scoreLB = self.childNode(withName: "scoreLB") as? SKLabelNode
        tapcostLB = self.childNode(withName: "tapcostLB") as? SKLabelNode
        autocostLB = self.childNode(withName: "autocostLB") as? SKLabelNode
        
        restoreUserData()
        
        let defaults = UserDefaults.standard
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            scoreLB?.attributedText = NSAttributedString(string: String(Int((scoreLB?.attributedText?.string)!)! + autopoints), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 100.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
            defaults.set([touchpoints, autopoints, upgrade1cost, upgrade2cost, Int((scoreLB?.attributedText?.string)!)!], forKey:"previousSave")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if((tapButton?.contains(location)) == true) {
                scoreLB?.attributedText = NSAttributedString(string: String(Int((scoreLB?.attributedText?.string)!)! + touchpoints), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 100.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
            }
            
            if((upgrade1?.contains(location)) == true) {
                if(Int((scoreLB?.attributedText?.string)!)! >= upgrade1cost) {
                    touchpoints *= 2
                    scoreLB?.attributedText = NSAttributedString(string: String(Int((scoreLB?.attributedText?.string)!)! - upgrade1cost), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 100.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
                    upgrade1cost = Int(Float(upgrade1cost) * 2.5)
                    tapcostLB?.attributedText = NSAttributedString(string: String(upgrade1cost), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 32.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
                }
            }
                
            if((upgrade2?.contains(location)) == true) {
                if(Int((scoreLB?.attributedText?.string)!)! >= upgrade2cost) {
                    autopoints += 1
//                    let moveAction = SKAction.move(to: CGPoint(x: Int.random(in: -), y: 50), duration: 2.0)
                    
                    scoreLB?.attributedText = NSAttributedString(string: String(Int((scoreLB?.attributedText?.string)!)! - upgrade2cost), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 100.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
                    upgrade2cost = Int(Float(upgrade2cost) + 5)
                    autocostLB?.attributedText = NSAttributedString(string: String(upgrade2cost), attributes: [NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-Bold", size: 32.0) as Any, NSAttributedString.Key.foregroundColor: UIColor.white])
                    
                    
                    
                    
                    
                    }
                
            }
            
            }
        }
    
}

