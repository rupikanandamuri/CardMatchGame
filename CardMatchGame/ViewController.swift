//
//  ViewController.swift
//  CardMatchGame
//
//  Created by Rupika on 2019-09-10.
//  Copyright © 2019 Rupika. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardcell", for: indexPath) as! CardsCollectionViewCell
        cell.cardView.layer.backgroundColor = getRandomColor().cgColor
        return cell
    }
    //MARK - Randome color generator.
    
    func random() -> CGFloat{
        
        return CGFloat(arc4random()) /  CGFloat(UInt32.max)
    }
    func getRandomColor() -> UIColor {
        return UIColor(red: random(), green: random(), blue: random(), alpha: 1)
    }
    
}

