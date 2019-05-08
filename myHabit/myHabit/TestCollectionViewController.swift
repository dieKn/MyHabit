//
//  TestCollectionViewController.swift
//  myHabit
//
//  Created by 加藤大 on 2019/05/03.
//  Copyright © 2019 加藤大. All rights reserved.
//

import UIKit

class TestCollectionViewController: UIViewController,UICollectionViewDelegate,  UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subView.frame.origin = CGPoint(x: 50.0, y: 100.0)
        subView.layer.borderColor = UIColor.black.cgColor
        subView.layer.borderWidth = 2.0
        let rectView = UIView(frame: CGRect(x: 10.0, y: 10.0, width: 50.0, height: 50.0))
        rectView.backgroundColor = .lightGray
        rectView.layer.cornerRadius = 8.0
        subView.addSubview(rectView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as UICollectionViewCell
        
        // 分かりやすいように背景色を青に
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    

}
