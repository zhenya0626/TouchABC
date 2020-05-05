//
//  RankingTableViewCell.swift
//  memoryTouchNumber
//
//  Created by abi01373 on 2020/05/03.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {


    @IBOutlet weak var indexLable: UILabel!
    
    @IBOutlet weak var timeLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addBottomBorderWithColor(color: UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.3), width: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCell(record: Record, index: Int) {
        print("record")
        print(record)
      self.indexLable.text = "\(index + 1)"
        self.indexLable.textColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7)
    self.timeLable.text = "\(record.resultTime)" as String
        self.timeLable.textColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7)
    }
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
      let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
      self.layer.addSublayer(border)
    }
    
}
