//
//  TopViewController.swift
//  myHabit
//
//  Created by 加藤大 on 2019/05/15.
//  Copyright © 2019 加藤大. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var didPrepareMenu = false
    let tabLabelWidth:CGFloat = 45
    @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    @IBAction func goNext(_ sender:UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "nextView")
        self.present(next,animated: true, completion: nil)
    }
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var calendarCollection : UICollectionView!
    var titles = [String]()
    var weekDays = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 線の種類
        initView()
        
        //日時取得
        //現在の日付を取得
        
        for i in -29...1{
            let date:Date = Date(timeIntervalSinceNow:TimeInterval(+60*60*24*i))
            //日付のフォーマットを指定する。
            let format = DateFormatter()
            format.dateFormat = "dd"

            //日付をStringに変換する
            let sDate = format.string(from: date)
            titles.append(sDate)


            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale:  Locale.current)
            weekDays.append(dateFormatter.string(from: date))
        }
        
        // カレンダーセル設定
        let layout = UICollectionViewFlowLayout()
        let tabLabelHeight:CGFloat = calendarView.frame.height
        layout.itemSize = CGSize(width:tabLabelWidth, height:tabLabelHeight)
        layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 70)
        
        layout.scrollDirection = .horizontal
        calendarCollection = UICollectionView(frame: calendarView.frame, collectionViewLayout: layout)
        
        let screenWidth:CGFloat = calendarView.frame.size.width+100
        //TODO:width+100のところ確認
        
        let screenHeight:CGFloat = calendarView.frame.origin.y + calendarView.frame.size.height
        
        calendarCollection.frame = CGRect(x:0, y:screenHeight, width:screenWidth, height:tabLabelHeight)
        
    calendarCollection.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        calendarCollection.backgroundColor = UIColor.clear
        
        calendarCollection.delegate = self
        calendarCollection.dataSource = self
        self.view.addSubview(calendarCollection)
    }
    
    // 2000を修正する
    override func viewWillAppear(_ animated: Bool) {
        calendarCollection.setContentOffset(CGPoint(x:2000, y:calendarCollection.contentInset.top), animated: true)
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
        return titles.count
    }
    
    /*
     Cellに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomUICollectionViewCell
        let tmpText = titles[indexPath.row]
        let tmpWeeksText = weekDays[indexPath.row]
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = tmpText.description + "\n" + tmpWeeksText.description
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
//
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

