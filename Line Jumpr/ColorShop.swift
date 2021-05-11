//
//  ColorShop.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/12/21.
//

import Foundation
import SpriteKit

class ColorShop: ShopScene {
    
    var BackButton = MenuButton(imageNamed: "Back")
    var VideoButton = MenuButton(imageNamed: "Video")
    var ChosenLine = ""
    var ChosenArea = ""
    
    var chosenNode = SKSpriteNode()
    var chosenNodeA = SKSpriteNode()
    
    
    
    var Special = ShopButton(imageNamed: "Locked")
    
    var bobtime :TimeInterval = 0.5
    var LineButtons = [
        ["Blue", 150,CGFloat(-150),CGFloat(270)],
        ["Green",150,CGFloat(-50),CGFloat(270)],
        ["Yellow", 150,CGFloat(50),CGFloat(270)],
        ["Orange",150,CGFloat(150),CGFloat(270)],
        ["Purple", 150,CGFloat(250),CGFloat(270)],
        ["Magenta",250,CGFloat(-250),CGFloat(140)],
        ["Cyan", 250,CGFloat(-150),CGFloat(140)],
        ["Black",250,CGFloat(-50),CGFloat(140)],
        ["Bronze", 300,CGFloat(50),CGFloat(140)],
        ["Silver",300,CGFloat(150),CGFloat(140)],
        ["Gold", 300,CGFloat(250),CGFloat(140)],
    ]
    var AreaButtons = [
        ["Blue", 250,CGFloat(-150),CGFloat(-50)],
        ["Green",250,CGFloat(-50),CGFloat(-50)],
        ["Yellow", 250,CGFloat(50),CGFloat(-50)],
        ["Orange",250,CGFloat(150),CGFloat(-50)],
        ["Purple", 250,CGFloat(250),CGFloat(-50)],
        ["Magenta",350,CGFloat(-250),CGFloat(-180)],
        ["Cyan", 350,CGFloat(-150),CGFloat(-180)],
        ["Black",350,CGFloat(-50),CGFloat(-180)],
        ["Bronze", 400,CGFloat(50),CGFloat(-180)],
        ["Silver",400,CGFloat(150),CGFloat(-180)],
        ["Gold", 400,CGFloat(250),CGFloat(-180)],
    ]
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Colors")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold")
        //Main UI
        
        BackButton.Create(CGSize(width: 120 * multiplier, height: 40 * multiplier), CGPoint(x: -210 * multiplier, y: 470 * multiplier), name: "Back")
        Cont.addChild(BackButton)
        
        //Labels
        stash = UserDefaults.standard.integer(forKey: "Stash")
        stashLabel = SKLabelNode(text: "Stash : \(stash)")
        createLabel(stashLabel, 35 * multiplier, CGPoint(x: 0, y: 390 * multiplier),font: "Verdana-Bold",color: .darkGray)
        
        let LineLabel = SKLabelNode(text: "Line Colors")
        createLabel(LineLabel, 35 * multiplier, CGPoint(x: 0, y: 335 * multiplier),font: "Verdana-Bold")
        
        let AreaLabel = SKLabelNode(text: "Area Colors")
        createLabel(AreaLabel, 35 * multiplier, CGPoint(x: 0, y: 15 * multiplier),font: "Verdana-Bold")
        
        
        
        //Special Line Color
        
       
        var SpecialEarned = false
        let highscore = UserDefaults.standard.integer(forKey: "HighScore")
        let SpecialLabel = SKLabelNode(text: "Reach 1000 score in single game to unlock special line.")
        
        
        Special.Create(CGSize(width: 80 * multiplier, height: 80 * multiplier), CGPoint(x: 0, y: -310 * multiplier), "Rainbow", 999999999, SpecialEarned,"Rainbow")
        Cont.addChild(Special)
        ShopButtons.append(Special)
        
        
        
        createLabel(SpecialLabel, 17 * multiplier, CGPoint(x: 0, y: -380 * multiplier),font: "Verdana-Bold",color: .darkGray)
        if highscore >= 1000{
            SpecialEarned = true
            Special.texture = SKTexture(imageNamed: "Rainbow")
            SpecialLabel.alpha = 0
            
        }
        
        
        //Watch Video Button
        
        
        VideoButton.Create(CGSize(width: 225 * multiplier, height: 90 * multiplier), CGPoint(x: 0, y: multiplier * -450), name: "Video")
        Cont.addChild(VideoButton)
        
        
        
        //Chosen Nodes
        
        chosenNode = SKSpriteNode(imageNamed: "Chosen")
        chosenNode.size = CGSize(width: 30 * multiplier, height: 30 * multiplier)
        chosenNode.zPosition = -1
        
        chosenNodeA = SKSpriteNode(imageNamed: "Chosen")
        chosenNodeA.size = CGSize(width: 30 * multiplier, height: 30 * multiplier)
        chosenNodeA.zPosition = -1
        
        
        //Red Line
        
        let redLine = ShopButton(imageNamed: "Red")
        redLine.Create(CGSize(width: 80 * multiplier, height: 80 * multiplier), CGPoint(x: -250 * multiplier, y: 270 * multiplier), "Red", 0, true,"Red")
        Cont.addChild(redLine)
        ShopButtons.append(redLine)
        redLine.Bob(0.2)
        
        let chosenLine = UserDefaults.standard.string(forKey: "LineColor") ?? "Red"
        if chosenLine == "Red"{
            ChosenLine = "Red"
            chosenNode.position = CGPoint(x: redLine.position.x, y: redLine.position.y - (multiplier * 60))
        }
        if chosenLine == "Rainbow"{
            ChosenLine = "Rainbow"
            chosenNode.position = CGPoint(x: Special.position.x, y: Special.position.y - (multiplier * 60))
        }
        
        //Red Area
        
        
        let redArea = ShopButton(imageNamed: "Red")
        redArea.Create(CGSize(width: 80 * multiplier, height: 80 * multiplier), CGPoint(x: -250 * multiplier, y: -50 * multiplier), "RedA", 0, true,"Red")
        Cont.addChild(redArea)
        ShopButtons.append(redArea)
        redArea.Bob(2.8)
        
        let chosenArea = UserDefaults.standard.string(forKey: "AreaColor") ?? "Red"
        if chosenArea == "Red"{
            ChosenArea = "Red"
            chosenNodeA.position = CGPoint(x: redArea.position.x, y: redArea.position.y - (multiplier * 60))
        }
        
        
        
        
        //Creates All Line Buttons
        for Object in LineButtons{
            
            bobtime += 0.2
            let name = Object[0] as! String
            let cost = Object[1] as! Int
            let xpos = Object[2] as! CGFloat
            let ypos = Object[3] as! CGFloat
            
            
            
            let bought = UserDefaults.standard.bool(forKey: "\(name)Bought")
            let chosen = UserDefaults.standard.string(forKey: "LineColor") ?? "Red"
            let ShopLabel = SKLabelNode(text: String(cost))
            //Create Shop Item and check to see if it's bought already
            var ShopItem = ShopButton()
            
            if bought == true{
                ShopItem = ShopButton(imageNamed: name)
            }else{
                ShopItem = ShopButton(imageNamed: "Locked")
                //Create Shop Label
                
                createLabel(ShopLabel, 20 * multiplier, CGPoint(x: xpos * multiplier, y: (ypos - 70) * multiplier),font: "Verdana-Bold")
            }
            
            //Creates it using array
            ShopItem.Create(CGSize(width: 80 * multiplier, height: 80 * multiplier), CGPoint(x: xpos * multiplier, y: ypos * multiplier), name, cost, bought, name,label: ShopLabel)
            Cont.addChild(ShopItem)
            ShopButtons.append(ShopItem)
            ShopItem.Bob(bobtime)
            
            if chosen == name{
                ChosenLine = chosen
                chosenNode.position = CGPoint(x: ShopItem.position.x, y: ShopItem.position.y - (multiplier * 60))
            }
            
        }
        //Creates All Area Buttons
        for Object in AreaButtons{
            
            bobtime += 0.2
            let name = Object[0] as! String
            let cost = Object[1] as! Int
            let xpos = Object[2] as! CGFloat
            let ypos = Object[3] as! CGFloat
            
           
            
            let bought = UserDefaults.standard.bool(forKey: "\(name)BoughtA")
            let chosen = UserDefaults.standard.string(forKey: "AreaColor") ?? "Red"
            let ShopLabel = SKLabelNode(text: String(cost))
            //Create Shop Item and check to see if it's bought already
            var ShopItem = ShopButton()
            
            if bought == true{
                ShopItem = ShopButton(imageNamed: name)
            }else{
                ShopItem = ShopButton(imageNamed: "Locked")
                //Create Shop Label
                
                createLabel(ShopLabel, 20 * multiplier, CGPoint(x: xpos * multiplier, y: (ypos - 70) * multiplier),font: "Verdana-Bold")
            }
            
            //Creates it using array
            ShopItem.Create(CGSize(width: 80 * multiplier, height: 80 * multiplier), CGPoint(x: xpos * multiplier, y: ypos * multiplier), "\(name)A", cost, bought, name,label: ShopLabel)
            Cont.addChild(ShopItem)
            ShopButtons.append(ShopItem)
            ShopItem.Bob(bobtime)
            
            if chosen == name{
                ChosenArea = chosen
                chosenNodeA.position = CGPoint(x: ShopItem.position.x, y: ShopItem.position.y - (multiplier * 60))
            }
            
        }
        
        //adds chosen nodes
        Cont.addChild(chosenNode)
        Cont.addChild(chosenNodeA)
    }
    
    
    override func buySomething(_ button: ShopButton) {
        AdCounter()
        
        if stash >= button.cost{
            print("Bought")
            stash -= button.cost
            updateStash()
            button.costLabel.removeFromParent()
            button.bought = true
            UserDefaults.standard.setValue(stash, forKey: "Stash")
            //Areas
            if button.name?.last! == "A"{
                ChosenArea = button.imagename
                UserDefaults.standard.setValue(ChosenArea, forKey: "AreaColor")
                UserDefaults.standard.setValue(true, forKey: "\(button.imagename)BoughtA")
                chosenNodeA.run(SKAction.move(to: CGPoint(x: button.position.x, y: button.position.y - (multiplier * 60)), duration: 0.4))
                //lines
            }else{
                ChosenLine = button.imagename
                UserDefaults.standard.setValue(ChosenLine, forKey: "LineColor")
                UserDefaults.standard.setValue(true, forKey: "\(button.imagename)Bought")
                chosenNode.run(SKAction.move(to: CGPoint(x: button.position.x, y: button.position.y - (multiplier * 60)), duration: 0.4))
            }
            
            button.texture = SKTexture(imageNamed: button.imagename)
            
        }else{
            stashLabel.run(SKAction.sequence([
                SKAction.scale(by: 1.5, duration: 0.5),
                SKAction.scale(by: 0.666666666667, duration: 0.5)
            ]))
        }
        
        
        
        
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
                    firstTouch = button.name ?? "Red"
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
                if button.contains(pos) && firstTouch == button.name{
                    //Checks to see if button has been bought, if not, selects button
                    if button.bought == false{
                        buySomething(button)
                    }else{
                        if button.name?.last! == "A"{
                            ChosenArea = button.imagename
                            UserDefaults.standard.setValue(ChosenArea, forKey: "AreaColor")
                            chosenNodeA.run(SKAction.move(to: CGPoint(x: button.position.x, y: button.position.y - (multiplier * 60)), duration: 0.4))
                            //lines
                        }else{
                            ChosenLine = button.imagename
                            UserDefaults.standard.setValue(ChosenLine, forKey: "LineColor")
                            chosenNode.run(SKAction.move(to: CGPoint(x: button.position.x, y: button.position.y - (multiplier * 60)), duration: 0.4))
                        }
                    }
                    
                    
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
