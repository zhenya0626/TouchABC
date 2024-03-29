//
//  ResultModalViewController.swift
//  memoryTouchNumber
//
//  Created by abi01373 on 2020/05/03.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds
import StoreKit
import GameKit


class ResultModalViewController: GADBannerViewController, UITableViewDelegate, UITableViewDataSource {
    var interstitial: GADInterstitialAd?
    
    var record: [Record] = [Record]()
    var image: UIImage = UIImage()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        record.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath ) as! RankingTableViewCell
        cell.setCell(record: record[indexPath.row], index: indexPath.row)
        return cell
    }
    
    
    var resultTime: String = ""
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var resultTimeLabel: UILabel!
    
    @IBOutlet weak var rankingTableView: UITableView!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-9614012526549975/7741681777",
                                              request: request,
                                              completionHandler: { [self] ad, error in
                                                if let error = error {
                                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                                  return
                                                }
                                                interstitial = ad
                                              }
        )
        rankingTableView.layer.borderColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7).cgColor

        // 常にライトモード（明るい外観）を指定することでダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        rankingTableView.dataSource = self
        rankingTableView.delegate = self
        rankingTableView.register(UINib(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: "RankingTableViewCell")
        
        
        homeButton.layer.borderColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7).cgColor
        shareButton.layer.borderColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7).cgColor
        rankingButton.layer.borderColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7).cgColor

        resultTimeLabel.text = resultTime
        let realm = try! Realm()
        let resultRecord = realm.objects(Record.self) // retrieves all Dogs from the default Realm
        record = Array(resultRecord.sorted(byKeyPath: "id"))
        
        // Submit a score to one or more leaderboards
        // リファクタする
        let doubleResultTime = self.resultTime.replacingOccurrences(of: " 秒", with: "")
        guard let score = Double(doubleResultTime) else { return }
        GKLeaderboard.submitScore(Int(score * 100), context: 0, player: GKLocalPlayer.local,
            leaderboardIDs: ["touchABCTime"]) { error in
        }
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        image = GetImage()
        let interstitialCount = UserDefaults.standard.integer(forKey: "interstitialCount")
        if interstitialCount % 10 == 2 {
            SKStoreReviewController.requestReview()
        }

    }

    @IBAction func openRanking(_ sender: Any) {
        // GameCenterのdashboardを表示する
        let viewController = GKGameCenterViewController(state: .dashboard)
        viewController.gameCenterDelegate = self
        present(viewController, animated: true, completion: nil)
    }
    @IBAction func retryButtonAction(_ sender: Any) {
        let interstitialCount = UserDefaults.standard.integer(forKey: "interstitialCount")
        if interstitialCount >= 8, let interstitial = interstitial {
            UserDefaults.standard.set(0, forKey: "interstitialCount")
          interstitial.present(fromRootViewController: self)
        } else {
            UserDefaults.standard.set(interstitialCount + 1, forKey: "interstitialCount")
        }
        
        let gameVC :UIViewController = GameViewController() as UIViewController
        //  上部余白の削除
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.modalTransitionStyle = .crossDissolve
        self.present(gameVC, animated: true, completion: nil)
    }
    
    @IBAction func topButtonAction(_ sender: Any) {
    
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let startVC :StartViewController = storyboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController {
            startVC.modalPresentationStyle = .fullScreen
            startVC.modalTransitionStyle = .crossDissolve
                   
                   self.present(startVC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // StringとUIImageを配列で設定
        let activityItems: [Any] = ["記録は \(resultTime)でした！ ぜひやってみてね！ #TOUCH_ABC", image,  "https://apps.apple.com/jp/app/id1511547536?mt=8"]

        let activityVc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        // iPadでクラッシュしたため
        activityVc.popoverPresentationController?.sourceView = contentView
        present(activityVc, animated: true, completion: {

        })
    }
    func GetImage() -> UIImage{

        // キャプチャする範囲を取得.
        let rect = self.contentView.bounds

        // ビットマップ画像のcontextを作成.
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!

        // 対象のview内の描画をcontextに複写する.
        self.contentView.layer.render(in: context)

        // 現在のcontextのビットマップをUIImageとして取得.
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!

        // contextを閉じる.
        UIGraphicsEndImageContext()

        return capturedImage
    }
    
}
extension ResultModalViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated:true)
    }
}
