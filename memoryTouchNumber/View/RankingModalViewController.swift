//
//  RankingModalViewController.swift
//  memoryTouchNumber
//
//  Created by abi01373 on 2020/05/04.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit
import RealmSwift

class RankingModalViewController: GADBannerViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    var record: [Record] = [Record]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        record.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath ) as! RankingTableViewCell
        cell.setCell(record: record[indexPath.row], index: indexPath.row)
        return cell
        
    }
    

    @IBOutlet weak var rankingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 常にライトモード（明るい外観）を指定することでダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7)
        closeButton.layer.borderColor = UIColor.white.cgColor
        rankingTableView.layer.cornerRadius = 5
        
        rankingTableView.dataSource = self
        rankingTableView.delegate = self
        rankingTableView.register(UINib(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: "RankingTableViewCell")
        
        let realm = try! Realm()
        let resultRecord = realm.objects(Record.self) // retrieves all Dogs from the default Realm
        record = Array(resultRecord.sorted(byKeyPath: "id"))
        

        // Do any additional setup after loading the view.
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
 
}
