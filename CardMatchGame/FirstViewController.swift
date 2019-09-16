//
//  FirstViewController.swift
//  CardMatchGame
//
//  Created by Rupika on 2019-09-11.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var easyViewHolder : UIView!
     @IBOutlet var mediumViewHolder : UIView!
     @IBOutlet var hardViewHolder : UIView!
     @IBOutlet var insaneViewHolder : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadCards()
        
        //for default even thought it will go see
         CardManager.shared.gameMode = CardManager.GameMode.Easy
    }
    
    //when selected type of mode
    @IBAction func gameModeClicked(_ sender : UIButton){
        clearBorders()
        sender.superview?.layer.borderWidth = 2.0
        sender.superview?.layer.cornerRadius = 5.0
        sender.superview?.layer.borderColor = UIColor(red: 105/255, green: 141/255, blue: 72/255, alpha: 1.0).cgColor
        if sender.tag == 1{
            CardManager.shared.gameMode = CardManager.GameMode.Easy
        }
        if sender.tag == 2{
            CardManager.shared.gameMode = CardManager.GameMode.Medium
        }
        if sender.tag == 3{
            CardManager.shared.gameMode = CardManager.GameMode.Hard
        }
        if sender.tag == 4{
            CardManager.shared.gameMode = CardManager.GameMode.Insane
        }
    }
    //when paly button clicked()
    @IBAction func playButtonClicked(){
        
        performSegue(withIdentifier: "play", sender: nil)
    }
    
    //to clear borders
    func clearBorders(){
        easyViewHolder.layer.borderWidth = 0
        mediumViewHolder.layer.borderWidth = 0
         hardViewHolder.layer.borderWidth = 0
         insaneViewHolder.layer.borderWidth = 0
    }
    
    func loadCards(){
        //here we are getting cards from card manger class get card function.
     CardManager.shared.getCards()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
