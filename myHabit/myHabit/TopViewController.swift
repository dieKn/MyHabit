//
//  TopViewController.swift
//  myHabit
//
//  Created by 加藤大 on 2019/05/15.
//  Copyright © 2019 加藤大. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var didPrepareMenu = false
    let tabLabelWidth:CGFloat = 100
    
    override func viewDidLayoutSubviews() {
        
        // viewDidLayoutSubviewsは複数回呼ばれるため
        if didPrepareMenu {return}
        didPrepareMenu = true
        
        // scrollViewのDelegateを指定
        scrollView.delegate = self
        let titles = ["月","火","水","木","金","土","日"]
        
        let tabLabelHeight:CGFloat = scrollView.frame.height
        
        //右端にダミーのUILabelを置くことで
        //一番右のタブもセンターに持ってくることが出来ます
        let dummyLabelWidth = scrollView.frame.size.width/2 - tabLabelWidth/2
        let headDummyLabel = UILabel()
        headDummyLabel.frame = CGRect(x:0, y:0, width:dummyLabelWidth, height:tabLabelHeight)
        scrollView.addSubview(headDummyLabel)
        
        // ダミー分ずらす？
        var originX:CGFloat = dummyLabelWidth
        for title in titles {
            let label = UILabel()
            label.textAlignment = .center
            label.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
            label.text = title
            scrollView.addSubview(label)
            originX += tabLabelWidth
        }
        let tailLabel = UILabel()
        tailLabel.frame = CGRect(x:originX, y:0, width:dummyLabelWidth, height:tabLabelHeight)
        scrollView.addSubview(tailLabel)
        originX += dummyLabelWidth
        
        //ここまでの処理でスクロールでラベルを真ん中まで持ってこれるようにする
        scrollView.contentSize = CGSize(width:originX, height:tabLabelHeight)
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        guard scrollView == self.scrollView else {
            print("ガードしました！")
            return
        }
        
        let index = Int((scrollView.contentOffset.x + tabLabelWidth/2) / tabLabelWidth)
        let x = index * 100
        UIView.animate(withDuration: 0.3,animations: {
            scrollView.contentOffset = CGPoint(x:x, y:0)
        })
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == self.scrollView else {
            print("ガードしました2！")
            return
        }
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

