//
//  ViewController.swift
//  ViewPracticeApp
//
//  Created by 真田雄太 on 2018/02/19.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit

let sectionTitle = ["チョウ目","バッタ目","コウチュウ目"]
let section0 = [("キタハテ","タテハチョウ"),("クロアゲハ","アゲハ蝶")]
let section1 = [("キリギリス","キリギリス"),("ヒナバッタ","バッタ科"),("マツムシ","マツムシ科")]
let section2 = [("ハンミョウ","ハンミョウ科"),("アオオサムシ","オサムシ科"),("チビクワガタ","クワガタムシ科")]
let tableData = [section0,section1,section2]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTableView:UITableView!
        myTableView = UITableView(frame: view.frame, style: .grouped)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        view.addSubview(myTableView)
    }
    
    //セクションの個数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    //セクションの行数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = tableData[section]
        return sectionData.count
    }
    
    //セクションのタイトルを決める
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
        
    }
    
    //セルを作る
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1  //セルに表示する虫の名前と科目を設定
        return cell
    }
    
    
    //UITableViewDelegate デリゲートメソッド
    //行がタップされると実行される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectionTitle[indexPath.section]
        let sectionData = tableData[indexPath.section]
        let cellData = sectionData[indexPath.row]
        print("\(title)\(cellData.1)")
        print("\(cellData.0)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

