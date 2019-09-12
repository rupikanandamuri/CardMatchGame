//
//  CardManager.swift
//  CardMatchGame
//
//  Created by Rupika on 2019-09-11.
//  Copyright © 2019 Rupika. All rights reserved.
//

import Foundation
class CardManager {
    
    var cards : [Card]?
    func getCards(){
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
struct Card {
    var cardName : String?
    var cardId : Int?
    var cardImage : String?
}
