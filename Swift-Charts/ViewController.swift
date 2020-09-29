//
//  ViewController.swift
//  Swift-Charts
//
//  Created by lg on 2020/9/29.
//  Copyright © 2020 lxf. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    lazy var barChart: BarChartView = {
        let v = BarChartView()
        return v
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    func addViews() {
        addBarChart()
        changeBarData("")
    }

    /// 添加条形图
    func addBarChart() {
        
        self.view.addSubview(barChart)
        barChart.frame = CGRect(x: 0, y: 100, width: 375, height: 200)

        barChart.delegate = self
        barChart.chartDescription?.enabled =  false
        barChart.noDataText = "暂无数据"
        barChart.fitBars = true
        barChart.extraBottomOffset = 10
        barChart.pinchZoomEnabled = true
        barChart.setScaleEnabled(true)
        barChart.drawGridBackgroundEnabled = false
        barChart.drawBarShadowEnabled = false
        barChart.drawValueAboveBarEnabled = false
        
        let l = barChart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 8, weight: .light)
        l.yOffset = 0
        l.xOffset = 0
        l.yEntrySpace = 0
        
        let xAxis = barChart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.granularity = 1
        xAxis.granularityEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.labelRotationAngle = -45
        xAxis.labelPosition = .bottom

        let leftAxis = barChart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.spaceTop = 10
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 60
        leftAxis.drawGridLinesEnabled = false
        
        barChart.rightAxis.enabled = false
      
    }
    
    func changeBarData(_ json: String) {
        let json = "{\"category\":[\"20-21\",\"21-22\",\"22-23\",\"23-24\",\"00-01\",\"01-02\",\"02-03\",\"03-04\",\"04-05\",\"05-06\",\"06-07\",\"07-08\"],\"deep\":[5.0, 2.0, 3.0, 1.0, 5.0, 5.0, 2.0, 5.0, 5.0, 5.0, 10.0, 20.0],\"dream\":[10.0, 22.0, 32.0, 10.0, 30.0, 25.0, 30.0, 10.0, 10.0, 20.0, 10.0, 20.0],\"light\":[10.0, 3.0, 20.0, 10.0, 4.0, 20.0, 30.0, 13.0, 10.0, 20.0, 30.0, 40.0],\"timeInfo\":[\"20:00-21:00\",\"21:00-22:00\",\"22:00-23:00\",\"23:00-24:00\",\"00:00-01:00\",\"01:00-02:00\",\"02:00-03:00\",\"03:00-04:00\",\"04:00-05:00\",\"05:00-06:00\",\"06:00-07:00\",\"07:00-08:00\"]}"
        
        guard let sleep = SleepBarData.deserialize(from: json) else { return  }

        let groupSpace: Double = 0.07
        let barSpace: Double = 0.01
        let barWidth: Double = 0.3
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: sleep.category)
        barChart.xAxis.labelCount = sleep.category.count
        
        var values1: [BarChartDataEntry] = [BarChartDataEntry]()
        var values2: [BarChartDataEntry] = [BarChartDataEntry]()
        var values3: [BarChartDataEntry] = [BarChartDataEntry]()

        for i in 0..<sleep.category.count {
            let cate = sleep.category[i]
            let timeInfo = sleep.timeInfo[i]
            let deep = sleep.deep[i]
            let light = sleep.light[i]
            let dream = sleep.dream[i]
            let model = SleepBarModel(deep, light, dream, timeInfo, cate)
            values1.append(BarChartDataEntry(x: Double(i), y: deep, data: model))
            values2.append(BarChartDataEntry(x: Double(i), y: light, data: model))
            values3.append(BarChartDataEntry(x: Double(i), y: dream, data: model))
        }
        
        let set1 = BarChartDataSet(entries: values1, label: "深睡")
        set1.setColor(NSUIColor.yellow)
        let set2 = BarChartDataSet(entries: values3, label: "浅睡")
        set2.setColor(NSUIColor.red)
        let set3 = BarChartDataSet(entries: values3, label: "清醒")
        set3.setColor(NSUIColor.blue)

        set1.drawValuesEnabled = false
        set2.drawValuesEnabled = false
        set3.drawValuesEnabled = false
        
        let data = BarChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 10))
        
        data.barWidth = barWidth
        
        barChart.data = data
        
        barChart.xAxis.axisMinimum = 0
        barChart.xAxis.axisMaximum = Double(values1.count)
        barChart.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        
    }
    
}

extension ViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        debugPrint("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        debugPrint("chartValueNothingSelected")
    }
}
