//
//  GameScene.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/4/21.
//

import SpriteKit
import GameplayKit

class MainMenu: MenuScene{
    
    
    let LeaderBoard = MenuButton(imageNamed: "Leaderboard")
    
    var fakeline = SKSpriteNode()
    var highScore = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Labels
        let Title = SKLabelNode(text: "Line Jumpr")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold")
        
        highScore = UserDefaults.standard.integer(forKey: "HighScore")
        let HighScoreLabel = SKLabelNode(text: "Best Score : \(highScore)")
        createLabel(HighScoreLabel, 35 * multiplier, CGPoint(x: 0, y: 300 * multiplier),font: "Verdana-Bold",color: .darkGray)
        
        // maybe stash label:
        
        
        //Buttons
        let playButton = MenuButton(imageNamed: "Play")
        playButton.Create(CGSize(width: 375 * multiplier, height: 125 * multiplier), CGPoint(x: 0, y: 150 * multiplier),name: "Play", trgt: GameScene(size: self.size))
        MenuButtons.append(playButton)
        playButton.float(0)
        Cont.addChild(playButton)
        
        let ShopButton = MenuButton(imageNamed: "Shop")
        ShopButton.Create(CGSize(width: 375 * multiplier, height: 125 * multiplier), CGPoint(x: 0, y: -50 * multiplier), name: "Shop", trgt: ShopMenu(size: self.size))
        MenuButtons.append(ShopButton)
        ShopButton.float(0.3)
        Cont.addChild(ShopButton)
        
        
        LeaderBoard.Create(CGSize(width: 375 * multiplier, height: 125 * multiplier), CGPoint(x: 0, y: -250 * multiplier), name: "Leaderboard")
        LeaderBoard.float(0.6)
        Cont.addChild(LeaderBoard)
        
        let InfoButton = MenuButton(imageNamed: "Info")
        InfoButton.Create(CGSize(width: 75 * multiplier, height: 75 * multiplier), CGPoint(x: -250 * multiplier, y: -450 * multiplier), name: "Info", trgt: InfoPage(size: self.size))
        MenuButtons.append(InfoButton)
        Cont.addChild(InfoButton)
        
        
        //bouncing line
        
        fakeline = SKSpriteNode()
        
        fakeline.color = .red
        fakeline.alpha = 0.3
        fakeline.size = CGSize(width: screenWidth, height: 14 * multiplier)
        fakeline.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: screenWidth, height: 14 * multiplier))
        fakeline.physicsBody?.allowsRotation = false
        fakeline.physicsBody?.affectedByGravity = false
        fakeline.position = CGPoint(x: 0, y: 200 * multiplier)
        fakeline.physicsBody?.linearDamping = 0.0
        Cont.addChild(fakeline)
        fakeline.physicsBody?.restitution = 1
        fakeline.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        
    }
    
    //Special case for main menu becuase of leaderboard button
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let pos = touch.location(in: Cont)
            if LeaderBoard.contains(pos){
                firstTouch = "LeaderBoard"
                LeaderBoard.fadeOut()
            }
        }
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if LeaderBoard.contains(pos) && firstTouch == "LeaderBoard"{
                //Leader board request goes here
                NotificationCenter.default.post(name: NSNotification.Name("CheckScore"), object: nil)
            }
            LeaderBoard.fadeIn()
        }
        
        super.touchesEnded(touches, with: event)
        
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for button in MenuButtons{
            button.fadeIn()
        }
        
    }
    
}
