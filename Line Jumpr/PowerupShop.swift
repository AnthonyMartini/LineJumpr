//
//  PowerupShop.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/12/21.
//

import Foundation
import SpriteKit
class PowerupShop: ShopScene {
    
    var BackButton = MenuButton(imageNamed: "Back")
    
    var VideoButton = MenuButton(imageNamed: "Video")
    
    var AreaIcon = SKSpriteNode()
    var TimeIcon = SKSpriteNode()
    var LifeIcon = SKSpriteNode()
    
    //vars
    var AreaBought = false
    var TimeBought = false
    var LifeBought = false
    
    fileprivate func Content() {
        //Titles
        
        let BiggerAreaTitle = SKLabelNode(text: "Bigger Zone")
        BiggerAreaTitle.horizontalAlignmentMode = .left
        BiggerAreaTitle.verticalAlignmentMode = .top
        createLabel(BiggerAreaTitle, 30 * multiplier, CGPoint(x: -55 * multiplier, y: 320 * multiplier),font: "Verdana-Bold",color: .black)
        
        
        let SlowerLineTitle = SKLabelNode(text: "Slower Line")
        SlowerLineTitle.horizontalAlignmentMode = .left
        SlowerLineTitle.verticalAlignmentMode = .top
        createLabel(SlowerLineTitle, 30 * multiplier, CGPoint(x: -55 * multiplier, y: 90 * multiplier),font: "Verdana-Bold",color: .black)
        
        let ExtraLifeTitle = SKLabelNode(text: "Extra Life")
        ExtraLifeTitle.horizontalAlignmentMode = .left
        ExtraLifeTitle.verticalAlignmentMode = .top
        createLabel(ExtraLifeTitle, 30 * multiplier, CGPoint(x: -55 * multiplier, y: -140 * multiplier),font: "Verdana-Bold",color: .black)
        
        
        
        //Cost Labels
        
        let BiggerAreaCost = SKLabelNode(text: "Cost: 50")
        BiggerAreaCost.horizontalAlignmentMode = .left
        BiggerAreaCost.verticalAlignmentMode = .top
        createLabel(BiggerAreaCost, 25 * multiplier, CGPoint(x: -55 * multiplier, y: 285 * multiplier),font: "Verdana-Bold",color: .darkGray)
        
        
        let SlowerLineCost = SKLabelNode(text: "Cost: 100")
        SlowerLineCost.horizontalAlignmentMode = .left
        SlowerLineCost.verticalAlignmentMode = .top
        createLabel(SlowerLineCost, 25 * multiplier, CGPoint(x: -55 * multiplier, y: 55 * multiplier),font: "Verdana-Bold",color: .darkGray)
        
        let ExtraLifeCost = SKLabelNode(text: "Cost: 150")
        ExtraLifeCost.horizontalAlignmentMode = .left
        ExtraLifeCost.verticalAlignmentMode = .top
        createLabel(ExtraLifeCost, 25 * multiplier, CGPoint(x: -55 * multiplier, y: -175 * multiplier),font: "Verdana-Bold",color: .darkGray)
        
        
        //Description Labels
        
        let BiggerAreaDesc = SKLabelNode(text: "Makes Point Zone Larger For Entire Game")
        BiggerAreaDesc.horizontalAlignmentMode = .left
        BiggerAreaDesc.verticalAlignmentMode = .top
        createLabel(BiggerAreaDesc, 22 * multiplier, CGPoint(x: -55 * multiplier, y: 260 * multiplier),font: "Verdana-Bold",color: .darkGray,prefW: 305 * multiplier, numLine: 2)
        
        
        let SlowerLineDesc = SKLabelNode(text: "Makes Line Slower For Entire Game")
        SlowerLineDesc.horizontalAlignmentMode = .left
        SlowerLineDesc.verticalAlignmentMode = .top
        createLabel(SlowerLineDesc, 22 * multiplier, CGPoint(x: -55 * multiplier, y: 30 * multiplier),font: "Verdana-Bold",color: .darkGray,prefW: 305 * multiplier, numLine: 2)
        
        let ExtraLifeDesc = SKLabelNode(text: "Gives You Another Chance")
        ExtraLifeDesc.horizontalAlignmentMode = .left
        ExtraLifeDesc.verticalAlignmentMode = .top
        createLabel(ExtraLifeDesc, 22 * multiplier, CGPoint(x: -55 * multiplier, y: -200 * multiplier),font: "Verdana-Bold",color: .darkGray,prefW: 305 * multiplier, numLine: 2)
        
        
        //Buy Buttons
        
        let AreaButton = ShopButton(imageNamed: "Buy")
        AreaButton.Create(CGSize(width: 100 * multiplier, height: 50 * multiplier), CGPoint(x: 82.5 * multiplier, y: 175 * multiplier), "BiggerZoneBought", 50, AreaBought, "AreaIcon")
        ShopButtons.append(AreaButton)
        Cont.addChild(AreaButton)
        
        let LineButton = ShopButton(imageNamed: "Buy")
        LineButton.Create(CGSize(width: 100 * multiplier, height: 50 * multiplier), CGPoint(x: 82.5 * multiplier, y: -50 * multiplier), "SlowerLineBought", 50, TimeBought, "TimeIcon")
        ShopButtons.append(LineButton)
        Cont.addChild(LineButton)
        
        
        let LifeButton = ShopButton(imageNamed: "Buy")
        LifeButton.Create(CGSize(width: 100 * multiplier, height: 50 * multiplier), CGPoint(x: 82.5 * multiplier, y: -280 * multiplier), "ExtraLifeBought", 50, LifeBought, "LifeIcon")
        ShopButtons.append(LifeButton)
        Cont.addChild(LifeButton)
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Powerups")
        createLabel(Title, 50 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold")
        
        stash = UserDefaults.standard.integer(forKey: "Stash")
        stashLabel = SKLabelNode(text: "Stash : \(stash)")
        createLabel(stashLabel, 35 * multiplier, CGPoint(x: 0, y: 390 * multiplier),font: "Verdana-Bold",color: .darkGray)
        
        
        
        //Main UI
        
        BackButton.Create(CGSize(width: 120 * multiplier, height: 40 * multiplier), CGPoint(x: -210 * multiplier, y: 470 * multiplier), name: "Back")
        Cont.addChild(BackButton)
        
        VideoButton.Create(CGSize(width: 225 * multiplier, height: 90 * multiplier), CGPoint(x: 0, y: multiplier * -450), name: "Video")
        Cont.addChild(VideoButton)
        
        
        //Icons
        
        AreaIcon = SKSpriteNode(imageNamed: "BiggerArea")
        createObject(object: AreaIcon, size: CGSize(width: 180 * multiplier, height: 180 * multiplier), zpos: 1, alpha: 1, pos: CGPoint(x: -160 * multiplier, y: 240 * multiplier), name: "AreaIcon")
        
        TimeIcon = SKSpriteNode(imageNamed: "SlowerLine")
        
        createObject(object: TimeIcon, size: CGSize(width: 180 * multiplier, height: 180 * multiplier), zpos: 1, alpha: 1, pos: CGPoint(x: -160 * multiplier, y: 10 * multiplier), name: "TimeIcon")
        
        LifeIcon = SKSpriteNode(imageNamed: "ExtraLife")
        
        createObject(object: LifeIcon, size: CGSize(width: 180 * multiplier, height: 180 * multiplier), zpos: 1, alpha: 1, pos: CGPoint(x: -160 * multiplier, y: -220 * multiplier), name: "LifeIcon")
        

        // Checks if powerups have been bought
        AreaBought = UserDefaults.standard.bool(forKey: "BiggerZoneBought")
        TimeBought = UserDefaults.standard.bool(forKey: "SlowerLineBought")
        LifeBought = UserDefaults.standard.bool(forKey: "ExtraLifeBought")
               
        if AreaBought == true{
            AreaIcon.texture = SKTexture(image: UIImage(named: "BiggerZoneBought")!)
        }
        
        if TimeBought == true{
          TimeIcon.texture = SKTexture(image: UIImage(named: "SlowerLineBought")!)
        }
        
        if LifeBought == true{
            LifeIcon.texture = SKTexture(image: UIImage(named: "ExtraLifeBought")!)
        }
        
        
        Content()
        
        
    }
    
    
    override func buySomething(_ button: ShopButton) {
        
        AdCounter()
        if stash <= button.cost{
            stash -= button.cost
            updateStash()
            button.bought = true
            UserDefaults.standard.setValue(true, forKey: button.name!)
            print(button.imagename)
            
            if button.name == "BiggerZoneBought"{
                AreaIcon.texture = SKTexture(imageNamed: "BiggerZoneBought")
            }
            if button.name == "SlowerLineBought"{
                TimeIcon.texture = SKTexture(imageNamed: "SlowerLineBought")
            }
            if button.name == "ExtraLifeBought"{
                LifeIcon.texture = SKTexture(imageNamed: "ExtraLifeBought")
            }
            
            
        }else{
            stashLabel.run(SKAction.sequence([
                SKAction.scale(by: 1.5, duration: 0.5),
                SKAction.scale(by: 0.666666666667, duration: 0.5)
            ]))
        }
    }
    
    
    func createObject(object:SKSpriteNode,size:CGSize,zpos : CGFloat, alpha : CGFloat,pos : CGPoint,name : String){
        object.size = size
        object.zPosition = zpos
        object.alpha = alpha
        object.position = pos
        object.name = name
        Cont.addChild(object)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if BackButton.contains(pos){
                firstTouch = "Back"
                BackButton.fadeOut()
            }
            if VideoButton.contains(pos){
                firstTouch = "Video"
                VideoButton.fadeOut()
            }
            for button in ShopButtons{
                if button.contains(pos){
                    button.fadeOut()
                    
                    firstTouch = button.name ?? "Back"
                    
                }
            }
            
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if BackButton.contains(pos) && firstTouch == "Back"{
                
                moveScenes(ShopMenu(size: self.size))
            }
            
            if VideoButton.contains(pos) && firstTouch == "Video"{
                NotificationCenter.default.post(name: NSNotification.Name("video"), object: nil)
            }
            
            for button in ShopButtons{
                if button.contains(pos) && firstTouch == button.name && button.bought == false{
                    
                    buySomething(button)
                }
                button.fadeIn()
            }
            
            BackButton.fadeIn()
            VideoButton.fadeIn()
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for button in ShopButtons{
            button.fadeIn()
        }
        BackButton.fadeIn()
        VideoButton.fadeIn()
    }
}
