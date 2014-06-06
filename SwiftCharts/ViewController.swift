//
//  ViewController.swift
//  SwiftCharts
//
//  Created by Sam Davies on 05/06/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SChartDatasource {
                            
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let chart = ShinobiChart(frame: view.bounds)
    chart.licenseKey = "<YOUR LICENSE KEY HERE>"
    chart.datasource = self
    chart.autoresizingMask = .FlexibleHeight | .FlexibleWidth
    view.addSubview(chart)
  }
    
  /* SChartDatasource methods */
  func numberOfSeriesInSChart(chart: ShinobiChart!) -> Int {
    return 1
  }
    
  func sChart(chart: ShinobiChart!, seriesAtIndex index: Int) -> SChartSeries! {
    return SChartLineSeries()
  }
    
  func sChart(chart: ShinobiChart!, numberOfDataPointsForSeriesAtIndex seriesIndex: Int) -> Int {
    return 100
  }
    
  func sChart(chart: ShinobiChart!, dataPointAtIndex dataIndex: Int, forSeriesAtIndex seriesIndex: Int) -> SChartData! {
    let dp = SChartDataPoint()
    dp.xValue = dataIndex
    dp.yValue = dataIndex * dataIndex
    return dp
  }
}

