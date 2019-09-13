//
//  ViewController.swift
//  CardMatchGame
//
//  Created by Rupika on 2019-09-10.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit
import Nuke

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet var collectionView : UICollectionView!
    
    var dataSource : [Card]?
    
    //used to track the cards selected by used. At any time, there shall be only 2 cards in this array. For a 2 pair mode, store only 2 cards.
    var selectedCards = [Card]()
    
    //Used to track if a flip is in progress or not. So we can avoid user clicking cards quickly .
    var flipInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadGameMode()
        if CardManager.shared.gameMode == CardManager.GameMode.Easy {
            dataSource = CardManager.shared.getEasyMode()
        }
        collectionView.reloadData()
        
}
    
    func loadGameMode(){
        
        if CardManager.shared.gameMode == CardManager.GameMode.Easy {
            dataSource = CardManager.shared.getEasyMode()
        }
        if CardManager.shared.gameMode == CardManager.GameMode.Medium {
            dataSource = CardManager.shared.getMediumMode()
        }
        if CardManager.shared.gameMode == CardManager.GameMode.Hard {
            dataSource = CardManager.shared.getHardMode()
        }
        if CardManager.shared.gameMode == CardManager.GameMode.Insane {
            dataSource = CardManager.shared.getInsaneMode()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardcell", for: indexPath) as! CardsCollectionViewCell
        if let card = dataSource?[indexPath.item]{
            if let  url = URL(string: (card.cardImage ?? "")){
                Nuke.loadImage(with: url, into: cell.cardIcon)
            }
            cell.cardCoverIcon.isHidden = card.isFlipped
        }
        cell.cardBackView.layer.borderColor = UIColor.lightGray.cgColor
        cell.cardBackView.layer.borderWidth = 2
        cell.cardBackView.layer.cornerRadius = 5

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //getting cell here the cell is option in collection view so  we are unwrapping cell
        if  let cell = collectionView.cellForItem(at: indexPath)  as? CardsCollectionViewCell {
             //getting cell reference
            if var card = dataSource?[indexPath.item]{
                if card.isFlipped == false{
                    card.isFlipped = true
                    card.cardIndexPath = indexPath
                    //in cell for row at we didn't have index path here we have cardindexpath  so we need to update it back to card so again we are assigned back datasource value to card.
                      self.dataSource?[indexPath.item] = card
                    if selectedCards.count < 2{
                        selectedCards.append(card)
                    }else{
                        print("cards exceeded")
                    }
                    flipView(cell.cardBackView, card) { (flipcompleted) in
                        if card.isFlipped{
                            cell.cardCoverIcon.isHidden = true
                            cell.cardIcon.transform = CGAffineTransform(scaleX: 1, y: -1)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                self.flipInProgress = false
                                self.checkMtachedCard()
                            }
                        }else{
                            print("card is turned back")
                        }
                        
                    }
                }
                
            }
        }
    
    }
    //to check whether card matched or not
    
    func checkMtachedCard(){
        if self.selectedCards.count == 2{
            let card1 = selectedCards[0]
            let card2 = selectedCards[1]
            if card1.cardName == card2.cardName{
                 removeMatchedPairs([card1.cardIndexPath!,card2.cardIndexPath!])
            }else{
                print("no match")
                //close previous cards
                var flipCount = 0
                for card in selectedCards{
                    let cell = collectionView.cellForItem(at: card.cardIndexPath!) as! CardsCollectionViewCell
                    var tempCard = card
                    tempCard.isFlipped = false
                    flipView(cell.cardBackView, tempCard, flipCompleted: { completed in
                        flipCount += 1
                        if flipCount == 2{
                            self.flipInProgress = false
                        }else{
                            self.flipInProgress = true
                        }
                    })
                    cell.cardCoverIcon.isHidden = false
                    dataSource?[card.cardIndexPath!.item] = tempCard
                    
                }
                //clear the array
                selectedCards.removeAll()
               }
        }
    }
    
   //to remove matched card
    // We need to remove selected cards in 1.datasource 2.selectedcardsarray 3.collectionview
    //This method has one param indexPaths which is an array of index paths
    // This methd is called when two cards are matched from the method "checkMtachedCard()"
    func removeMatchedPairs(_ indexPaths : [IndexPath] ){
        //perform batch update will be used to remove elemts in collection view
        collectionView.performBatchUpdates({
          //to remove indexpath in  data source.
            let indexesToRemove: Set = [indexPaths[0].item, indexPaths[1].item]
                       dataSource =  dataSource!
                            .enumerated()
                            .filter { !indexesToRemove.contains($0.offset) }
                            .map { $0.element }
            //removing selected cards from selected array
             selectedCards.removeAll()
            //to remove collection view 
            collectionView.deleteItems(at: indexPaths)
        
    }, completion:nil)
    }
    //to flip the card
    
    func flipView(_ viewToFlip : UIView,_ card : Card, flipCompleted : ((Bool)->Void)?){
        
      self.flipInProgress = true
        DispatchQueue.main.async {
            if  card.isFlipped {
                //intially to flip view
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    viewToFlip.transform = CGAffineTransform(scaleX: 1, y: -1)
                }, completion: { (completed) in
                    if let completed = flipCompleted{
                        completed(true)
                    }
                })
            }else{
                
                //Turn back the card
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                    viewToFlip.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { completed in
                    if let completed = flipCompleted{
                        completed(true)
                    }
                })
            }
        }
}
      
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    }
   
    
}



