//
//  InfoPage.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/12/21.
//


import Foundation
import SpriteKit

class InfoPage : CScene{
    
    var firstTouch = ""
    let BackButton = MenuButton(imageNamed: "Back")
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        let Title = SKLabelNode(text: "Info")
        createLabel(Title, 70 * multiplier, CGPoint(x: 0, y: 440 * multiplier),font: "Verdana-Bold")
        
        let HowTitle = SKLabelNode(text: "How To Play")
        createLabel(HowTitle, 45 * multiplier, CGPoint(x: 0, y: 350 * multiplier),font: "Verdana-Bold")
        
        let lineOne = SKSpriteNode(imageNamed: "Blk")
        lineOne.size = CGSize(width: 550 * multiplier, height: 3 * multiplier)
        lineOne.position = CGPoint(x: 0, y: 325 * multiplier)
        Cont.addChild(lineOne)
        
        
        let HowToPlayOne = SKSpriteNode(imageNamed: "HowPlay1")
        HowToPlayOne.size = CGSize(width: 500 * multiplier, height: 200 * multiplier)
        HowToPlayOne.position = CGPoint(x: 0, y: 200 * multiplier)
        Cont.addChild(HowToPlayOne)
        
        let LineTwo = SKSpriteNode(imageNamed: "Blk")
        LineTwo.size = CGSize(width: 550 * multiplier, height: 3 * multiplier)
        LineTwo.position = CGPoint(x: 0, y: 75 * multiplier)
        Cont.addChild(LineTwo)
        
        
        let HowToPlayTwo = SKSpriteNode(imageNamed: "HowPlay2")
        HowToPlayTwo.size = CGSize(width: 500 * multiplier, height: 200 * multiplier)
        HowToPlayTwo.position = CGPoint(x: 0, y: -50 * multiplier)
        Cont.addChild(HowToPlayTwo)
        
        
        let LineThree = SKSpriteNode(imageNamed: "Blk")
        LineThree.size = CGSize(width: 550 * multiplier, height: 3 * multiplier)
        LineThree.position = CGPoint(x: 0, y: -175 * multiplier)
        Cont.addChild(LineThree)
        
        
        
        let Contact = SKLabelNode(text: "Contact Email: 1thenerdherd@gmail.com")
        createLabel(Contact, 22 * multiplier, CGPoint(x: 0, y: -350 * multiplier),font: "Verdana-Bold")
        
        BackButton.Create(CGSize(width: 225 * multiplier, height: 75 * multiplier), CGPoint(x: 0, y: -425 * multiplier), name: "Back")
        Cont.addChild(BackButton)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
           
            if BackButton.contains(pos){
                BackButton.fadeOut()
                firstTouch = "Back"
                
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let pos = touch.location(in: Cont)
            if BackButton.contains(pos) && firstTouch == "Back"{
                
                moveScenes(MainMenu(size: self.size))
            }
            BackButton.fadeIn()
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        BackButton.fadeIn()
    }
}
