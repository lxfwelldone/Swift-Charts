//
//  SleepBarData.swift
//  xczn
//
//  Created by lg on 2020/9/29.
//  Copyright © 2020 lxf. All rights reserved.
//

import UIKit
import HandyJSON

class SleepBarData: NSObject, HandyJSON {

    /// 深度睡眠
    var deep: [Double]!
    
    /// 浅度睡眠
    var light: [Double]!
    
    /// 清醒
    var dream: [Double]!
    
    /// 详细时间段
    var timeInfo: [String]!
    
    /// 分组时间段
    var category: [String]!
    
    
    
    required override init() {
    }
    
}
