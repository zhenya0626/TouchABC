//
//  GADBannerViewController.swift
//  memoryTouchNumber
//
//  Created by abi01373 on 2020/05/04.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GADBannerViewController: UIViewController, GADBannerViewDelegate {
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        // テスト用
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        // 本番用
        bannerView.adUnitID = "ca-app-pub-9614012526549975/1240918262"

        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self

        addBannerViewToView(bannerView)
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
     bannerView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(bannerView)
     view.addConstraints(
       [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: bottomLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
       ])
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
