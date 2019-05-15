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
    
    let items: [CGFloat] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
    let reuseIdentifier = "reuseIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // 分かりやすいように背景色を青に
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = items[indexPath.row]
        let bgView = UIView()
        bgView.backgroundColor = .lightGray
        cell.selectedBackgroundView = bgView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(
            title: nil,
            message: "ボーダーの太さは\(items[indexPath.row])です",
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        present(alertController, animated: true, completion: nil)
    }

}
