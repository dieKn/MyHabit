//
//  ViewController.swift
//  myHabit
//
//  Created by 加藤大 on 2019/04/21.
//  Copyright © 2019 加藤大. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let titles = ["月","火","水","木","金","土","日"]
        
        
        let tabLabelWidth:CGFloat = 70
        let tabLabelHeight:CGFloat = collectionView.frame.height
        
        var originX:CGFloat = 0
        for title in titles {
            let label = UILabel()
            label.textAlignment = .center
            label.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
            label.text = title
            collectionView.addSubview(label)
            originX += tabLabelWidth
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as UICollectionViewCell
        
        // 分かりやすいように背景色を青に
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }


}

