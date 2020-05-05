//
//  Record.swift
//  memoryTouchNumber
//
//  Created by abi01373 on 2020/05/03.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation
import RealmSwift

class Record: Object {
    
    @objc dynamic var id = 0
//    @objc dynamic var date: Date = Date()
//    @objc dynamic var minute: Int = 0
//    @objc dynamic var second: Int = 0
//    @objc dynamic var mSec: Int = 0
    @objc dynamic var resultTime: String = ""
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}
