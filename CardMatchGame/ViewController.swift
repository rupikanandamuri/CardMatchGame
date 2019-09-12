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
        if let product = products?[indexPath.item] {
              cell.cardImage.downloaded(from: product)
        }
        return cell
    }
   
    
}



