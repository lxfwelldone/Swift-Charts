//
//  SleepBarModel.swift
//  xczn
//
//  Created by lg on 2020/9/29.
//  Copyright © 2020 lxf. All rights reserved.
//

import UIKit
import HandyJSON

class SleepBarModel:  NSObject, HandyJSON {

    /// 深度睡眠
    var deep: Double = 0.0

    /// 浅度睡眠
    var light: Double = 0.0
    
    /// 清醒
    var dream: Double = 0.0
    
    /// 详细时间段
    var timeInfo: String!
    
    /// 分组时间段
    var category: String!
    
    
    convenience init(_ deep: Double?=0.0, _ light: Double?=0.0, _ dream: Double?=0.0, _ timeInfo: String?="", _ categroy: String?="") {
        self.init()
        self.deep = deep!
        self.light = light!
        self.dream = dream!
        self.timeInfo = timeInfo!
        self.category = categroy!
    }
    
    required override init() {
    }
}
