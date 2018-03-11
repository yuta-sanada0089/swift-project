//
//  ViewController.swift
//  Practice App
//
//  Created by 真田雄太 on 2018/02/25.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    struct Photo {
        var imageName: String
        var title: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoList = [
            Photo(imageName: "Photo1", title: "映画は中劇"),
            Photo(imageName: "Photo2", title: "札幌は時計台"),
            Photo(imageName: "Photo3", title: "蓮の花"),
            Photo(imageName: "Photo4", title: "夏の垣根")
        ]
       
        //サブビューを作る
        let subView = createContentsView(contentsList: photoList)
       
        //スクロールビューにサブビューを追加する
        scrollView.addSubview(subView)
        
        //スクロールビューの設定
        scrollView.isPagingEnabled = true //ページ送りする
        scrollView.contentSize = subView.frame.size //コンテンツサイズ
        scrollView.contentOffset = CGPoint(x: 0, y: 0) //スクロール開始位置
        
        //スクロールビューのデリゲートになる
        scrollView.delegate = self
        
        //ページコントロールを設定
        pageControll.numberOfPages = photoList.count
        pageControll.currentPage = 0
        pageControll.pageIndicatorTintColor = UIColor.lightGray
        pageControll.currentPageIndicatorTintColor = UIColor.black
    }
    
    func createContentsView(contentsList:Array<Photo>) -> UIView{
        //ページを追加するコンテンツビューを作る
        let contentView = UIView()
        //1ページの幅と高さ
        let pageWidth = self.view.frame.width
        let pageHeight = scrollView.frame.height
        let pageViewRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        //写真縦横サイズ
        let photoSize = CGSize(width: 250, height: 250)
        //ページを並べたコンテンツビュー全体のサイズ
        contentView.frame = CGRect(x: 0, y: 0, width: pageWidth*4, height: pageHeight)
        //ページの背景色
        let colors:Array<UIColor> = [.cyan, .yellow, .lightGray, .orange]
        //写真コンテンツのページを作ってサブビューに追加
        for i in 0..<contentsList.count {
            //写真のファイル名とタイトルを順番に取り出す
            let contentItem = contentsList[i]
            //ページのビューを作る
            let pageView = createPage(viewRect: pageViewRect, imageSize: photoSize, item: contentItem)
            //コンテンツビューにページを並べて追加してく
            contentView.addSubview(pageView)
        }
        return contentView
    }

    func createPage(viewRect:CGRect, imageSize:CGSize, item:Photo) -> UIView {
        let pageView = UIImageView() // 1ページ分のUIView
        // 写真を作ってイメージを設定する
        let photoView = UIImageView()
        let left = (pageView.frame.width - imageSize.width)/2
        photoView.frame = CGRect(x: left, y: 10, width: imageSize.width, height: imageSize.height)
        photoView.contentMode = .scaleAspectFill
        photoView.image = UIImage(named: item.imageName)
        // ラベルを作って写真タイトルを設定する
        let titleFrame = CGRect(x: left, y: photoView.frame.maxY+10, width: 200, height: 21)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.text = item.title
        // 写真とタイトルをページビューに追加する
        pageView.addSubview(photoView)
        pageView.addSubview(titleLabel)
        return pageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //カレントページを作る
        let pageNo = Int(scrollView.contentOffset.x/scrollView.frame.width)
        //表示をカレントページに合わせる
        pageControll.currentPage = pageNo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

