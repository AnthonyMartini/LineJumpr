//
//  GameViewController.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/4/21.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit
import GoogleMobileAds
import UserNotifications
class GameViewController: UIViewController, GKGameCenterControllerDelegate, GADFullScreenContentDelegate{
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    var score = 0
    var interstitial: GADInterstitialAd?
    var rewardedAd: GADRewardedAd?
    
    
      
    
    fileprivate func loadInterstitial() {
      let request = GADRequest()
      GADInterstitialAd.load(
        withAdUnitID: "ca-app-pub-3343126174384559/7308554354", request: request
      ) { (ad, error) in
        if let error = error {
          print("Failed to load interstitial ad with error: \(error.localizedDescription)")
          return
        }
        self.interstitial = ad
        self.interstitial?.fullScreenContentDelegate = self
      }
    }
    
    
    
     func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Rewarded ad presented.")
    }

     func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Rewarded ad dismissed.")
    }

     func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error
    ) {
      print("Rewarded ad failed to present with error: \(error.localizedDescription).")
    }
    
    func loadVideo(){
        GADRewardedAd.load(
          withAdUnitID: "ca-app-pub-3343126174384559/3425197396", request: GADRequest()
        ) { (ad, error) in
          if let error = error {
            print("Rewarded ad failed to load with error: \(error.localizedDescription)")
            return
          }
          print("Loading Succeeded")
          self.rewardedAd = ad
          self.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        authplayer()
        loadInterstitial()
        loadVideo()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
        }
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.sendScore), name: NSNotification.Name("SendScore"), object: nil)
 
        
         NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.checkScore), name: NSNotification.Name("CheckScore"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.InterAd), name: NSNotification.Name("Inter"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.presentvideoad), name: NSNotification.Name("video"), object: nil)
    }
    
    
    @objc func InterAd(){
        if let ad = self.interstitial {
            ad.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
        loadInterstitial()
        
    }
    
    
    
    @objc func presentvideoad(){
        if let ad = rewardedAd {
          ad.present(fromRootViewController: self) {
            let reward = ad.adReward
            print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
            var stash = UserDefaults.standard.integer(forKey: "Stash")
            stash += 50
            UserDefaults.standard.setValue(stash, forKey: "Stash")
            NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
          }
        } else {
            print("Not Ready")
        
    }
        loadVideo()
        
        
    }

    
    
    
    //Game Center Stuff
    func authplayer(){
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            }else{
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
    }
    func savescore(_ number : Int){
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "HighScore")
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
    
    @objc func sendScore(){
        score = UserDefaults.standard.integer(forKey: "HighScore")
        savescore(score)
    }
    @objc func checkScore(){
        OpenGameCenter()
    }
    
    
    func OpenGameCenter(){
        let VC = self.view.window?.rootViewController
        let GCVC = GKGameCenterViewController()

        GCVC.gameCenterDelegate = self
        VC?.present(GCVC, animated: true, completion: nil)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
   
    
    
    
}
