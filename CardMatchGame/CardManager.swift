//
//  CardManager.swift
//  CardMatchGame
//
//  Created by Rupika on 2019-09-11.
//  Copyright © 2019 Rupika. All rights reserved.
//

import Foundation
class CardManager {
    
    static let shared = CardManager()
    
    var easyModeProducts = ["Clock","Keyboard"]
    var mediumModeProduts = ["Plate","Computer","Shoes","Table"]
    var hardModeProdutcs = ["Bag","Watch","Chair","Pants","Knife", "Lamp"]
    var insaneModeProducts = ["Coat","Hat","Wallet","Car","Bench","Bottle","Gloves"]
    
    var cards : [Card]?
    
    enum GameMode : Int{
        case Easy = 1 , Medium,Hard,Insane
    }
    
    var gameMode : GameMode?
    
   //for easy mode
    func getEasyMode() -> [Card]{
       var easyArray = [Card]()
        //here cards contain all the data from joson
        if let cards = cards{
            
            let clockArray = cards.filter({$0.cardName == "Clock"})
            if let clockCard = clockArray.first{
                for _ in 0...5{
                    easyArray.append(clockCard)
                }
            }
            
            let keyboardArray = cards.filter({$0.cardName == "Keyboard"})
            if let keyboardCard = keyboardArray.first{
                for _ in 0...5{
                    easyArray.append(keyboardCard)
                }
            }
        }
        return easyArray.shuffled()
    }
    
    //for Medium mode
    func getMediumMode() -> [Card]{
         var mediumArray = [Card]()
        if let cards = cards{
            for card in cards{
                if card.cardName == "Plate" || card.cardName == "Computer" || card.cardName == "Shoes" || card.cardName == "Table"{
                       mediumArray.append(card)
                }
            }
        }
        return mediumArray
    }
    //for hard mode
    func getHardMode() -> [Card]{
        var hardArray = [Card]()
        if let cards = cards{
            for card in cards{
                if card.cardName == "Bag" || card.cardName == "Watch" || card.cardName == "Chair" || card.cardName == "Pants" || card.cardName == "Knife" || card.cardName == "Lamp"{
                    hardArray.append(card)
                }
            }
        }
        return hardArray
    }
    //for insance mode
    func getInsaneMode()-> [Card]{
        var insaneArray = [Card]()
        if let cards = cards{
            for card in cards{
                if card.cardName == "Coat" || card.cardName == "Hat" || card.cardName == "Wallet" || card.cardName == "Bench" || card.cardName == "Car" || card.cardName == "Bottle" || card.cardName == "Gloves"{
                    insaneArray.append(card)
                }
            }
        }
        return insaneArray
    }
    
    func getCards(){
        
        cards = [Card]()
        
        for i in 1...3{
            let link = "https://shopicruit.myshopify.com/admin/products.json?page=\(i)&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
            if let url = URL(string: link){
                URLSession.shared.dataTask(with:  url) { (data, response, error) in
                   if error != nil {
                            print("error")
                    }else{
                            print(data ?? "data is not downloaded")
                            print(response ?? "server not connected")
                            do{
                                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String : Any]{
                                    if let products = json["products"] as? [[String : Any]] {
                                        for product in products{
                                            var card = Card()
                                            card.cardName = product["product_type"] as? String
                                            if let imgsrc = product["image"] as? [String : Any]{
                                                  card.cardImage = imgsrc["src"] as? String
                                            }
                                            self.cards?.append(card)
                                        }
                                    }
                                    
                                }
                            }catch {
                                print("error")
                           }
                        }
                     }.resume()
                 }
             }
       }
    
}
struct Card : Hashable {
    var isFlipped = false
    var cardName : String?
    var cardId : Int?
    var cardImage : String?
    var cardIndexPath : IndexPath?
}
