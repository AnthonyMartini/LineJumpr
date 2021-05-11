//
//  GameScene.swift
//  Line Jumpr
//
//  Created by Tony Martini on 3/5/21.
//

import Foundation
import SpriteKit


class GameScene : CScene{
    
    var colors : [String: UIColor] = [
        "Red" : .red,
        "Blue" : .blue,
        "Green" : .green,
        "Yellow" : .yellow,
        "Orange" : .orange,
        "Purple" : .magenta,
        "Magenta" : .magenta,
        "Cyan" : .cyan,
        "Black" : .black,
        "Bronze" : UIColor(red: 170/255, green: 112/255, blue: 66/255, alpha: 1.0),
        "Silver" : UIColor(red: 191/255, green: 196/255, blue: 199/255, alpha: 1.0),
        "Gold" : UIColor(red: 190/255, green: 148/255, blue: 46/255, alpha: 1.0)
    ]
    
    var line = SKSpriteNode()
    var area = SKSpriteNode()
    var theo = SKSpriteNode()
    var theosmaller = SKSpriteNode()
    var smallerArea = SKSpriteNode()
    var scorelabel = SKLabelNode(text: "0")
    var multiplierLabel = SKLabelNode()
    
    var score = 0
    var speedv = 900.0
    var firstTouch = ""
    
    var areamult = 1.0
    var linemult = 1.0
    var scoremult = 2
    var LifeBought = false
    
    var gamesPlayed = 0
    var overflow = 0
  
    var gameover = false
    
    enum CategoryMask : UInt32 {
        case line = 0b00000001
        case clone = 0b00000010
        case Border = 0b00000100
    }
    
    var playagain = SKSpriteNode(imageNamed: "PlayAgain")
    var mainmenu = SKSpriteNode(imageNamed: "MainMenu")
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        speedv = Double(900.0 * heightmultiplier)
        gamesPlayed = UserDefaults.standard.integer(forKey: "GamesPlayed")
        gamesPlayed += 1
        UserDefaults.standard.setValue(gamesPlayed, forKey: "GamesPlayed")
        
        
        print(Cont.size.height)
        let border1 = SKSpriteNode()
        border1.size = CGSize(width: screenWidth, height: 100 * multiplier)
        border1.color = .red
        border1.position = CGPoint(x: 0, y: (screenHeight / 2) + (50 * multiplier))
        border1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: 100 * multiplier))
        border1.physicsBody?.isDynamic = false
        border1.physicsBody?.categoryBitMask = CategoryMask.Border.rawValue
        
        Cont.addChild(border1)
        
        let border2 = SKSpriteNode()
        border2.size = CGSize(width: screenWidth, height: 100 * multiplier)
        border2.color = .blue
        border2.position = CGPoint(x: 0, y: (-50 * multiplier) - (screenHeight / 2))
        border2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: 100 * multiplier))
        border2.physicsBody?.isDynamic = false
        border2.physicsBody?.categoryBitMask = CategoryMask.Border.rawValue
        
        Cont.addChild(border2)
        
        //Powerup Stuff Goes Here
        
        let AreaBought = UserDefaults.standard.bool(forKey: "BiggerZoneBought")
        let TimeBought = UserDefaults.standard.bool(forKey: "SlowerLineBought")
        LifeBought = UserDefaults.standard.bool(forKey: "ExtraLifeBought")
               
        if AreaBought == true{
            areamult = 1.2
        }
        if TimeBought == true{
            linemult = 0.75
        }
        UserDefaults.standard.setValue(false, forKey: "BiggerZoneBought")
        UserDefaults.standard.setValue(false, forKey: "SlowerLineBought")
        UserDefaults.standard.setValue(false, forKey: "ExtraLifeBought")
        
        createLabel(scorelabel, 100 * multiplier, CGPoint(x: 0, y: 415 * multiplier),font: "Verdana-Bold")
        
        let lineColor = UserDefaults.standard.string(forKey: "LineColor") ?? "Red"
        let areaColor = UserDefaults.standard.string(forKey: "AreaColor") ?? "Red"
        
        if lineColor == "Rainbow"{
            RainbowColorFuncTwo()
        }
        line.color = colors[lineColor] ?? .red
        area.color = colors[areaColor] ?? .red
        area.alpha = 0.6
        area.position = CGPoint(x: 0, y: 0)
        area.size = CGSize(width: screenWidth, height: 250 * multiplier * CGFloat(areamult))
        Cont.addChild(area)
        theo.alpha = 0.0
        theo.size = CGSize(width: screenWidth, height: area.size.height + (12 * multiplier))
        theo.position = area.position
        Cont.addChild(theo)

        line.size = CGSize(width: screenWidth, height: 12 * multiplier)
        line.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: 12 * multiplier))
        line.physicsBody?.allowsRotation = false
        line.physicsBody?.affectedByGravity = false
        line.physicsBody?.linearDamping = 0.0
        line.physicsBody?.collisionBitMask = CategoryMask.Border.rawValue
        line.physicsBody?.categoryBitMask = CategoryMask.line.rawValue
        line.physicsBody?.usesPreciseCollisionDetection = true
        line.position = CGPoint(x: 0, y: 0)
        Cont.addChild(line)
        line.physicsBody?.restitution = 1
        line.physicsBody?.velocity = CGVector(dx: 0, dy: speedv * linemult)
        
    }
    
    func gameOver(){
        AdCounter()
        line.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        //Updates Stash with points from this game
        var stash = UserDefaults.standard.integer(forKey: "Stash")
        stash += score
        UserDefaults.standard.setValue(stash, forKey: "Stash")
        
        //If three games have been played, asks for a review
        if gamesPlayed == 4{
            AppStoreReviewManager.requestReviewIfAppropriate()
        }
        //Turn off user interaction while animation is playing
        self.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500), execute: {
            self.isUserInteractionEnabled = true
        })
        
        //creates two pillers that move inward, UI fades in afterwards.
        let left = SKSpriteNode()
        left.color = .white
        createObject(object: left, size: CGSize(width: screenWidth / 2, height:  screenHeight), zpos: 2, alpha: 1,pos: CGPoint(x: -0.75 * screenWidth, y: 0))
        left.run(SKAction.move(to: CGPoint(x: -0.25 * screenWidth, y: 0), duration: 1))
        
        let right = SKSpriteNode()
        right.color = .white
        createObject(object: right, size: CGSize(width: screenWidth / 2, height:  screenHeight), zpos: 2, alpha: 1,pos: CGPoint(x: 0.75 * screenWidth, y: 0))
        right.run(SKAction.move(to: CGPoint(x: 0.25 * screenWidth, y: 0), duration: 1))
        
        
        //Labels

        let TitleOne = SKLabelNode(text: "Game Over")
        createLabel(TitleOne, 70 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold",color: .red,zpos: 3,alpha: 0)
        TitleOne.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),SKAction.fadeAlpha(to: 1, duration: 1)
        ]))
        
        //Final Score Label
        let ScoreFinal = SKLabelNode(text: String(score))
        createLabel(ScoreFinal, 200 * multiplier, CGPoint(x: 0, y: 250 * multiplier),font: "Verdana-Bold",color: .black,zpos: 3,alpha: 0)
        ScoreFinal.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.1),SKAction.fadeAlpha(to: 1, duration: 1)
        ]))
        
        //Checks if highscore has been beaten
        var highscore = UserDefaults.standard.integer(forKey: "HighScore")
        if score > highscore{
            highscore = score
            UserDefaults.standard.setValue(highscore, forKey: "HighScore")
        }
        
        //High score label
        let highscoreLabel = SKLabelNode(text: "Best Score : \(highscore)")
        createLabel(highscoreLabel, 33 * multiplier, CGPoint(x: 0, y: 170 * multiplier),font: "Verdana-Bold",color: .darkGray,zpos: 3,alpha: 0)
        highscoreLabel.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.2),SKAction.fadeAlpha(to: 1, duration: 1)
        ]))
        
        //Play Again Button
        createObject(object: playagain, size: CGSize(width: 375 * multiplier, height: 125 * multiplier), zpos: 3, alpha: 1, pos: CGPoint(x: screenWidth, y: 0 * multiplier))
        playagain.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.3),
            SKAction.moveTo(x: 0, duration: 1),
            SKAction.repeatForever(SKAction.sequence([
                SKAction.moveBy(x: -50 * multiplier, y: 0, duration: 0.6),
                SKAction.moveBy(x: 100 * multiplier, y: 0, duration: 1.2),
                SKAction.moveBy(x: -50 * multiplier, y: 0, duration: 0.6)
            ]))
        ]))
        
        //Main Menu Button
        createObject(object: mainmenu, size: CGSize(width: 375 * multiplier, height: 125 * multiplier), zpos: 3, alpha: 1, pos: CGPoint(x: -1 * screenWidth, y: -200 * multiplier))
        mainmenu.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.3),
            SKAction.moveTo(x: 0, duration: 1),
            SKAction.repeatForever(SKAction.sequence([
                SKAction.moveBy(x: 50 * multiplier, y: 0, duration: 0.6),
                SKAction.moveBy(x: -100 * multiplier, y: 0, duration: 1.2),
                SKAction.moveBy(x: 50 * multiplier, y: 0, duration: 0.6)
            ]))
        ]))
        
  
    }
    
    func scoreUpdate(){
        //If score is in any of these brackets, makes game harder accordingly
        if score <= 30{
            area.size.height *= 0.96
            linemult += 0.05
        }
        if score > 30 && score <= 75{
            linemult += 0.04
            area.size.height *= 0.98
        }
        if score > 75 && score <= 105{
            linemult += 0.03
        }
        if score > 145 && score <= 250{
            //shadow line
            let clone = SKSpriteNode()
            clone.alpha = 0.3
            clone.color = line.color
            clone.size = CGSize(width: screenWidth, height: 12 * multiplier)
            clone.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: 12 * multiplier))
            clone.physicsBody?.allowsRotation = false
            clone.physicsBody?.affectedByGravity = false
            clone.physicsBody?.linearDamping = 0.0
            clone.physicsBody?.collisionBitMask = CategoryMask.Border.rawValue
            clone.physicsBody?.categoryBitMask = CategoryMask.clone.rawValue
            clone.position = CGPoint(x: 0, y: 0)
            Cont.addChild(clone)
            clone.physicsBody?.restitution = 1
            clone.physicsBody?.velocity = CGVector(dx: 0, dy: speedv)
        }

        if score == 50{
            //Creates the smaller area, multiplier label and its theo area
            smallerArea.color = area.color
            smallerArea.alpha = 0.7
            smallerArea.size = CGSize(width: screenWidth, height: area.size.height / 4)
            smallerArea.position = area.position
            Cont.addChild(smallerArea)
            
            theosmaller.alpha = 0.0

            theosmaller.position = smallerArea.position
            theosmaller.size = CGSize(width: screenWidth, height: smallerArea.size.height + (12 * multiplier))
            Cont.addChild(theosmaller)
            
            multiplierLabel = SKLabelNode(text: "x2")
            multiplierLabel.horizontalAlignmentMode = .left
            multiplierLabel.verticalAlignmentMode = .center
            createLabel(multiplierLabel, 35 * multiplier, CGPoint(x: -280 * multiplier, y: smallerArea.position.y),font: "Verdana-Bold",color: .black)
           
        }
        
        
        theo.size.height = (12 * multiplier) + area.size.height
        smallerArea.size.height = area.size.height / 4
        theosmaller.size.height = (12 * multiplier) + smallerArea.size.height
        
        if (line.physicsBody?.velocity.dy)! > 0{
            line.physicsBody?.velocity.dy = CGFloat(speedv * linemult)
        }else{
            line.physicsBody?.velocity.dy = CGFloat(-1 * speedv * linemult)
        }
        
    }
    func createObject(object:SKSpriteNode,size:CGSize,zpos : CGFloat, alpha : CGFloat,pos : CGPoint){
        object.size = size
        object.zPosition = zpos
        object.alpha = alpha
        object.position = pos
        Cont.addChild(object)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
   
            //If main area contains position
            if gameover == false{
                
                
                if (theo.contains(line.position)) {
                    
                    if theosmaller.contains(line.position){
                        score += scoremult
                        overflow += scoremult
                        if scoremult < 4{
                            scoremult += 1
                        }
                        
                        multiplierLabel.text = "x\(scoremult)"
                    }else{
                        scoremult = 2
                        multiplierLabel.text = "x\(scoremult)"
                        score += 1
                        overflow += 1
                    }
                    
                    if overflow >= 5{
                        overflow -= 5
                        scoreUpdate()
                    }
                    
                    scorelabel.text = String(score)
                    let acceptable = (950 * multiplier) - (area.size.height/2)
                    let newpostion = CGFloat(arc4random_uniform(UInt32(acceptable)))
                    area.run(SKAction.move(to: CGPoint(x: 0, y: newpostion - (acceptable / 2)), duration: 0.25))
                    theo.run(SKAction.move(to: CGPoint(x: 0, y: newpostion - (acceptable / 2)), duration: 0.25))
                    
                    smallerArea.run(SKAction.move(to: CGPoint(x: 0, y: newpostion - (acceptable / 2)), duration: 0.25))
                    theosmaller.run(SKAction.move(to: CGPoint(x: 0, y: newpostion - (acceptable / 2)), duration: 0.25))
                    multiplierLabel.run(SKAction.move(to: CGPoint(x: -280 * multiplier, y: newpostion - (acceptable / 2)), duration: 0.25))
                    
                }else if score > 0{
                    
                    if LifeBought == true{
                        LifeBought = false
                        let warninglabel = SKLabelNode(text: "Extra Life Used")
                        createLabel(warninglabel, 30 * multiplier, CGPoint(x: 0, y: 350 * multiplier),font: "Verdana-Bold",color: .red, alpha: 0)
                        warninglabel.run(SKAction.sequence([
                            SKAction.fadeIn(withDuration: 0.4),
                            SKAction.fadeOut(withDuration: 0.4)
                        ]))
                    }else{
                        gameover = true
                        gameOver()
                    }
                    
                }
            }else{
                if playagain.contains(pos){
                    firstTouch = "PlayAgain"
                    playagain.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
                }
                if mainmenu.contains(pos){
                    firstTouch = "MainMenu"
                    mainmenu.run(SKAction.fadeAlpha(to: 0.4, duration: 0.3))
                }
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if playagain.contains(pos) && firstTouch == "PlayAgain"{
                moveScenes(GameScene())
            }
            if mainmenu.contains(pos) && firstTouch == "MainMenu"{
                moveScenes(MainMenu())
            }
            playagain.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
            mainmenu.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
        }
    }
    
    func RainbowColorFuncTwo(){
        let rainbowAnimation = SKAction.repeatForever(SKAction.sequence([ SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.25), SKAction.wait(forDuration: 0.25),SKAction.colorize(with: UIColor.orange, colorBlendFactor: 1.0, duration: 0.25), SKAction.wait(forDuration: 0.25), SKAction.colorize(with: UIColor.green, colorBlendFactor: 1.0, duration: 0.25),  SKAction.wait(forDuration: 0.25), SKAction.colorize(with: UIColor.blue, colorBlendFactor: 1.0, duration: 0.25), SKAction.wait(forDuration: 0.25), SKAction.colorize(with: UIColor.cyan, colorBlendFactor: 1.0, duration: 0.25), SKAction.wait(forDuration: 0.25) ]))
        line.run(rainbowAnimation)
        
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        playagain.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
        mainmenu.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
    }
    
    
    
    
}
