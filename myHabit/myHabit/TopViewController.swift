//
//  TopViewController.swift
//  myHabit
//
//  Created by 加藤大 on 2019/05/15.
//  Copyright © 2019 加藤大. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var didPrepareMenu = false
    let tabLabelWidth:CGFloat = 45
    
    @IBOutlet weak var tableView: UITableView!
    var calendarCollection : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 線の種類
        initView()
        
        // カレンダーセル設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:50, height:50)
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 32, 16)
        
        layout.scrollDirection = .horizontal
        calendarCollection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        calendarCollection.frame = CGRect(x:0, y:screenHeight/1.2, width:screenWidth, height:50)
        
        calendarCollection.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        calendarCollection.backgroundColor = UIColor.clear
        
        calendarCollection.delegate = self
        calendarCollection.dataSource = self
        
        self.view.addSubview(calendarCollection)
    }
    
    //セル設定コード
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
    //セル設定コード
    
    // 習慣リスト処理
    //項目定義
    let habits = ["記事を書く", "運動する", "iOSアプリ開発", "typeScript練習", "本を読む"]
    
    // 項目数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("table3")
        return habits.count
    }
    
    // 習慣のカラム数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        cell.textLabel?.text = self.habits[indexPath.row]
        tableView.tableFooterView = UIView()
        print("table2")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを外す
        cell?.accessoryType = .none
    }
    
    // 習慣リスト処理*ここまで
    
    
//    override func viewDidLayoutSubviews() {
//        // カレンダー処理
//        // viewDidLayoutSubviewsは複数回呼ばれるため
//        if didPrepareMenu {
//            print("ガードしました3")
//            return}
//        didPrepareMenu = true
//
//        // scrollViewのDelegateを指定
//        scrollView.delegate = self
//        var titles = [String]()
//        var weekDays = [String]()
//
//        //日時取得
//        //現在の日付を取得
//        for i in -29...1{
//            let date:Date = Date(timeIntervalSinceNow:TimeInterval(+60*60*24*i))
//            //日付のフォーマットを指定する。
//            let format = DateFormatter()
//            format.dateFormat = "dd"
//
//            //日付をStringに変換する
//            let sDate = format.string(from: date)
//            titles.append(sDate)
//
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "ja_JP")
//            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale:  Locale.current)
//            weekDays.append(dateFormatter.string(from: date))
//        }
//
//        let tabLabelHeight:CGFloat = scrollView.frame.height
//
//        //右端にダミーのUILabelを置くことで
//        //一番右のタブもセンターに持ってくることが出来ます
//        let dummyLabelWidth = scrollView.frame.size.width/2 - tabLabelWidth/2
//        let headDummyLabel = UILabel()
//        headDummyLabel.frame = CGRect(x:0, y:0, width:dummyLabelWidth, height:tabLabelHeight)
//        scrollView.addSubview(headDummyLabel)
//
//        // ダミー分ずらす？
//        var originX:CGFloat = dummyLabelWidth
//        var n:Int = 0
//        for title in titles {
//            let label = UILabel()
//            label.textAlignment = .center
//            label.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
//            label.numberOfLines = 2
//            label.text = weekDays[n] + "\n" + title
//            n = n + 1
//            label.layer.borderColor = UIColor.blue.cgColor
//            label.layer.borderWidth = 1
//            label.layer.cornerRadius = 5
//            label.isUserInteractionEnabled = true
//
//            scrollView.addSubview(label)
//            originX += tabLabelWidth
//
//            let labelSpace = UILabel()
//            labelSpace.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
//            scrollView.addSubview(labelSpace)
//            originX += 10
//        }
//        let tailLabel = UILabel()
//        tailLabel.frame = CGRect(x:originX, y:0, width:dummyLabelWidth, height:tabLabelHeight)
//        scrollView.addSubview(tailLabel)
//        originX += dummyLabelWidth
//
//        //ここまでの処理でスクロールでラベルを真ん中まで持ってこれるようにする
//        scrollView.contentSize = CGSize(width:originX, height:tabLabelHeight)
//        // カレンダー処理
//    }
    
    func tapAction(sender: UITapGestureRecognizer) {
        print("label touched")
    }
    
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
//        guard scrollView == self.scrollView else {
//            print("ガードしました！")
//            return
//        }
//        
//        let index = Int((scrollView.contentOffset.x + tabLabelWidth/2) / tabLabelWidth)
//        let x = index * 100
//        UIView.animate(withDuration: 0.3,animations: {
//            scrollView.contentOffset = CGPoint(x:x, y:0)
//        })
//    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        guard scrollView == self.scrollView else {
//            print("ガードしました2！")
//            return
//        }
//        let index = Int((scrollView.contentOffset.x + tabLabelWidth/2) / tabLabelWidth)
//        let x = index * 100
//        UIView.animate(withDuration: 1.0, animations: {
//            scrollView.contentOffset = CGPoint(x:x, y:0)
//        })
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TopViewController {
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        // 複数選択可にする
        tableView.allowsMultipleSelection = true
    }
}

