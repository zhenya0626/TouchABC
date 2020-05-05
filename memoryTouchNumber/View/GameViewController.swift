//
//  GameViewController.swift
//  memoryTouchNumber
//
//  Created by abi01373 on 2020/05/03.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit
import RealmSwift

class GameViewController: GADBannerViewController {
    var count = 1
    var minuteString = ""
    var secondString = "00"
    var mSecString = "00"
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var timerMinuteLabel: UILabel!
    
    @IBOutlet weak var timerSecondLabel: UILabel!
    
    @IBOutlet weak var timerMSecLabel: UILabel!
    
    @IBOutlet weak var startView: UIView!
    
    @IBOutlet weak var homeButton: UIButton!
    
    
    @IBOutlet weak var retryButton: UIButton!
    //    var timerLabel: UILabel = UILabel()
    weak var timer: Timer!
    var startTime = Date()
    let orderedLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    private let feedbackGenerator: Any? = {
        if #available(iOS 10.0, *) {
            let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            return generator
        } else {
            return nil
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 常にライトモード（明るい外観）を指定することでダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = UIColor(red:123/255,green:139/255,blue:179/255,alpha:1)
        self.view.isOpaque = false

        homeButton.layer.borderWidth = 1
        homeButton.layer.borderColor = UIColor.white.cgColor
        homeButton.layer.cornerRadius = 5
        
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7).cgColor
        retryButton.layer.cornerRadius = 5
        
        retryButton.alpha = 0
    }
    func startGame() {
        self.view.backgroundColor = UIColor.white
        retryButton.alpha = 1
        count = 1
        countLabel.text = orderedLetters[count-1]
        
        while true {
            letters.shuffle()
            if letters.last != "A" {
                break
            }
        }
        let width: CGFloat = self.view.bounds.width
        let height: CGFloat = self.view.bounds.height
        let inset: CGFloat = 5
        let margin: CGFloat = 10
        let recWidth: CGFloat =  (width - margin * 2 - inset * 4) / 5
        for i in 0 ..< 5 {
            for j in 0 ..< 5 {
                drowButton(x: margin + (recWidth / 2) + CGFloat(CGFloat(i) * (recWidth + inset)), y: CGFloat((height / 2 - width / 2 + recWidth) + CGFloat(j) * (recWidth + inset)), rectWidth: recWidth, text: letters[ i * 5 + (j+1)-1])
            }
        }
        startTimer()
    }
    
    func startTimer() {
         if timer != nil{
             // timerが起動中なら一旦破棄する
             timer.invalidate()
         }
         
         timer = Timer.scheduledTimer(
             timeInterval: 0.01,
             target: self,
             selector: #selector(self.timerCounter),
             userInfo: nil,
             repeats: true)
         
         startTime = Date()
     }
     
    func stopTimer() {
         if timer != nil{
             timer.invalidate()
         }
     }
     
     @objc func timerCounter() {
         // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)

        // fmod() 余りを計算
        let minute = (Int)(fmod((currentTime/60), 60))
        // currentTime/60 の余り
        let second = (Int)(fmod(currentTime, 60))
        // floor 切り捨て、小数点以下を取り出して *100
        let msec = (Int)((currentTime - floor(currentTime))*100)

        // %02d： ２桁表示、0で埋める
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        let sMsec = String(format:"%02d", msec)


        if sMinute != "00" {
            minuteString = "\(sMinute)"
        }
        secondString = "\(sSecond)"
        mSecString = "\(sMsec)"


         timerMinuteLabel.text = minuteString
         timerSecondLabel.text = secondString
         timerMSecLabel.text = mSecString
         
     }
     
    func drowButton(x: CGFloat, y: CGFloat, rectWidth: CGFloat, text: String){
        let button = UIButton()
        
        //ボタンのテキスト
        button.setTitle(text, for: .normal)

        //テキストの色 color
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.contentHorizontalAlignment = .center

//        //タップした状態のテキスト
//        button.setTitle(text, for: .highlighted)

//        //タップした後の文字色
//        button.setTitleColor(UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7), for: .highlighted)
        
        // ボタンの文字サイズ
        button.titleLabel?.font = UIFont.systemFont(ofSize: rectWidth * 0.5)

        //ボタンのサイズ width height
        button.frame = CGRect(x: 0, y: 0, width: rectWidth, height: rectWidth)

//        //タグ番号
//        button.tag = tag

        //配置場所
        button.layer.position = CGPoint(x: x, y: y)

        //背景色 background-color
        button.backgroundColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7)

        //角の丸み　border-radius
        button.layer.cornerRadius = 10

        //ボーダー幅 border
        button.layer.borderWidth = 1

        //ボーダーの色 border-color
        button.layer.borderColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.3).cgColor

        //ボタンをタップした時に実行するメソッドを指定
        button.addTarget(self, action: #selector(tapped(_:)), for:.touchUpInside)
        // TouchDownの時のイベントを追加する.
        button.addTarget(self, action: #selector(onDownButton(_:)), for: .touchDown)

    
       // TouchUpの時のイベントを追加する.
        button.addTarget(self, action: #selector(onUpButton(_:)), for: [.touchUpInside,.touchUpOutside])

        //viewにボタンを追加する
        self.view.addSubview(button)
    }
    @objc func tapped(_ sender: UIButton) {
        if #available(iOS 10.0, *), let generator = feedbackGenerator as? UIImpactFeedbackGenerator {
            generator.impactOccurred()
        }
        if sender.titleLabel?.text == orderedLetters[count-1] {
            if sender.titleLabel?.text == "Z" {
                stopTimer()
                // Use them like regular Swift objects
                
                //背景色 background-color
                sender.backgroundColor = UIColor(red:90/255,green:90/255,blue:90/255,alpha:0.7)
                //テキスト
                sender.setTitle("", for: .normal)
                presentResult()
            } else {
                count = count + 1
                countLabel.text = orderedLetters[count-1]
                if sender.titleLabel?.text == "A" {
                    //テキスト
                    sender.setTitle(letters.last, for: .normal)
                    sender.setTitle(letters.last, for: .highlighted)
                    return
                }
                //背景色 background-color
                sender.backgroundColor = UIColor(red:90/255,green:90/255,blue:90/255,alpha:0.7)
                //テキスト
                sender.setTitle("", for: .normal)
                //テキスト
                sender.setTitle("", for: .highlighted)
                
            }
            
        } 
        
        
    }
    /*
      ボタンイベント(Down)
      */
    @objc func onDownButton(_ sender: UIButton) {
        //UIView.animateWithDuration
        UIView.animate(withDuration: 0.06,

                                   // アニメーション中の処理.
            animations: { () -> Void in

                // 縮小用アフィン行列を作成する.
                sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

            })
        { (Bool) -> Void in

        }
    }
    /*
     ボタンイベント(Up)
     */
    @objc func onUpButton(_ sender: UIButton){
        UIView.animate(withDuration: 0.1,

            // アニメーション中の処理.
            animations: { () -> Void in

                // 拡大用アフィン行列を作成する.
                sender.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)

                // 縮小用アフィン行列を作成する.
                sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            })
        { (Bool) -> Void in

        }
    }
    

    func presentResult(){
        
        let resultVC :ResultModalViewController = ResultModalViewController() as ResultModalViewController
        //  上部余白の削除
        resultVC.modalPresentationStyle = .overCurrentContext
        resultVC.modalTransitionStyle = .crossDissolve
        var resultTime = ""
          if minuteString == "" {
            resultTime = "\(secondString).\(mSecString) 秒"
          } else {
            resultTime = "\(minuteString)分 \(secondString).\(mSecString) 秒"
        }
        
        resultVC.resultTime = resultTime
        let record = Record()
        record.resultTime = resultTime
        if let id = Int("\(minuteString)\(secondString)\(mSecString)") {
            record.id = id
        }

        // Get the default Realm
        let realm = try! Realm()
        // Persist your data easily
        try! realm.write {
            realm.add(record)
        }
        
        
        self.present(resultVC, animated: true, completion: nil)
    }
    
    @IBAction func homeButtonAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let startVC :StartViewController = storyboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController {
            startVC.modalPresentationStyle = .fullScreen
            startVC.modalTransitionStyle = .crossDissolve
                   
                   self.present(startVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func retryButtonAction(_ sender: Any) {
        if timer != nil{
            // timerが起動中なら一旦破棄する
            timer.invalidate()
        }
        loadView()
        viewDidLoad()
    }
    
    @IBAction func tappedReadyView(_ sender: Any) {
        startView.removeFromSuperview()
        startGame()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        

        
    }
    

}
