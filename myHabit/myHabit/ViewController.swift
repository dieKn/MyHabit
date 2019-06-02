//
//  ViewController.swift
//  myHabit
//
//  Created by 加藤大 on 2019/04/21.
//  Copyright © 2019 加藤大. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    var didPrepareMenu = false
    let tabLabelWidth:CGFloat = 100
    
    var calendarCollection : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:50, height:50)
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 32, 16)
        
        layout.scrollDirection = .horizontal
        calendarCollection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        calendarCollection.frame = CGRect(x:0, y:screenHeight/2, width:screenWidth, height:50)
        
    calendarCollection.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        calendarCollection.backgroundColor = UIColor.clear
        
        calendarCollection.delegate = self
        calendarCollection.dataSource = self
        
        self.view.addSubview(calendarCollection)
    }
    
    /*
     Cellが選択された際に呼び出される
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = .blue
            
            print("Num: \(indexPath.row)")
        }
        print("Num: \(indexPath.row)")
        
    }
    
    
    /*
     Cellの総数を返す
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    /*
     Cellに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomUICollectionViewCell
        cell.textLabel?.text = indexPath.row.description
        return cell
    }

    
    override func viewDidLayoutSubviews() {
        if didPrepareMenu { return }
        didPrepareMenu = true
        
        scrollView.delegate = self
        let titles = ["月","火","水","木","金","土","日"]
        let tabLabelHeight:CGFloat = scrollView.frame.height
        
        let dummyLabelWidth = scrollView.frame.size.width/2 - tabLabelWidth/2
        let headDummyLabel = UILabel()
        headDummyLabel.frame = CGRect(x:0, y:0, width:dummyLabelWidth, height:tabLabelHeight)
        scrollView.addSubview(headDummyLabel)
        
        var originX:CGFloat = dummyLabelWidth
        for title in titles {
            //タブになるUILabelを作る
            let label = UILabel()
            label.textAlignment = .center
            label.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
            label.text = title
            
            //scrollViewにぺたっとする
            scrollView.addSubview(label)
            
            //次のタブのx座標を用意する
            originX += tabLabelWidth
        }
        let tailLabel = UILabel()
        tailLabel.frame = CGRect(x:originX, y:0, width:dummyLabelWidth, height:tabLabelHeight)
        scrollView.addSubview(tailLabel)
        originX += dummyLabelWidth
        
        scrollView.contentSize = CGSize(width:originX, height:tabLabelHeight)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == self.scrollView else { return }
        let index = Int((scrollView.contentOffset.x + tabLabelWidth/2) / tabLabelWidth)
        let x = index * 100
        UIView.animate(withDuration: 0.3, animations: {
            scrollView.contentOffset = CGPoint(x:x, y:0)
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == self.scrollView else { return }
        let index = Int((scrollView.contentOffset.x + tabLabelWidth/2) / tabLabelWidth)
        let x = index * 100
        UIView.animate(withDuration: 1.0, animations: {
            scrollView.contentOffset = CGPoint(x:x, y:0)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

