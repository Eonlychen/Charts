//
//  CHLineChartView.swift
//  Charts
//
//  Created by 陈然 on 2020/9/25.
//

import UIKit
import CoreGraphics

open class CHLineChartView: BarLineChartViewBase, LineChartDataProvider {

    private var markViewShow: Bool = false
    
    open var lineData: LineChartData? { return _data as? LineChartData }

    internal override func initialize()
    {
        super.initialize()
        
        renderer = LineChartRenderer(dataProvider: self, animator: _animator, viewPortHandler: _viewPortHandler)
        
        _tapGestureRecognizer = NSUITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(_tapGestureRecognizer)
    }
    
    @objc func tap(_ recognizer: UITapGestureRecognizer) {
        if _data === nil
        {
            return
        }
        
        if recognizer.state == NSUIGestureRecognizerState.ended
        {
            
            if !isHighLightPerTapEnabled { return }
            let h = getHighlightByTouchPoint(recognizer.location(in: self))
            if self.markViewShow {
                if let markerView = self.marker as? CHMarkerView {
                    let location = recognizer.location(in: self)
                    print("是否包含：",markerView.rect.contains(location),"点击位置：", location, "标记视图frame:", markerView.rect)
                    if !highlighted.isEmpty && markerView.rect.contains(location) {
                        
                        print("qqqqqqqqqqqqq")
                        // In my case, I created custom property 'vertex' on BalloonMarker for easy reference to get `xValue`
//                            let xValue = self.getTransformer(forAxis: .left).valueForTouchPoint(markerView.vertex).x

                        // Do what you need to here with tap (call function, create custom delegate and trigger it, etc)
                        // In my case, my chart has a marker tap delegate
                        // ex, something like: `markerTapDelegate?.tappedMarker()`

                        return
                    }
                }
            }
            if h === nil || h == self.lastHighlighted
            {
                
                lastHighlighted = nil
                highlightValue(nil, callDelegate: true)
                
                self.markViewShow = false
            }
            else
            {

                lastHighlighted = h
                highlightValue(h, callDelegate: true)
                
                self.markViewShow = true
            }
        }
    }

}
