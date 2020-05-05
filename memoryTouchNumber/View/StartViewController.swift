//
//  ViewController.swift
//  memoryTouchNumber
//
//  Created by abi01373 on 2020/05/03.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit
import RealmSwift


class StartViewController: GADBannerViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DBのファイルの場所
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // 常にライトモード（明るい外観）を指定することでダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        
    }


    @IBAction func startButtonAction(_ sender: Any) {
        let gameVC :UIViewController = GameViewController() as UIViewController
        //  上部余白の削除
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.modalTransitionStyle = .crossDissolve
        

        
        self.present(gameVC, animated: true, completion: nil)
    }
    
    
    @IBAction func rankingButtonAction(_ sender: Any) {
        let rankingVC :RankingModalViewController = RankingModalViewController()
        //  上部余白の削除
        rankingVC.modalPresentationStyle = .overCurrentContext
//        rankingVC.modalTransitionStyle = .crossDissolve
        self.present(rankingVC, animated: true, completion: nil)
    }
    
}

