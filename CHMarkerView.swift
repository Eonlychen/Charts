//
//  CHMarkerView.swift
//  Charts
//
//  Created by 陈然 on 2020/9/25.
//

import Foundation
#if canImport(UIKit)
    import UIKit
#endif

public class CHMarkerView: MarkerView {

    public var arrowSize = CGSize(width: 6, height: 4)
    public var font: UIFont = UIFont.systemFont(ofSize: 12)
    public var textColor: UIColor = .blue
    public var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    private var title: String = ""
    private var titleHeight: CGFloat = 0.0
    
    public var rect: CGRect
    {
        get {
            return CGRect(x: originX, y: originY, width: 142 - 16 * 2, height: sizeHeight)
        }
//        get {
//            return CGRect(x: 0 , y: 0, width: 142, height: 100)
//        }
    }
    
    private var originX: CGFloat = CGFloat.nan
    private var originY: CGFloat = CGFloat.nan
    private var sizeHeight: CGFloat = CGFloat.nan
    
    // 黑色背景
    fileprivate lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 142, height: 96))
        view.backgroundColor = .black
        return view
    }()
    // 时间
    fileprivate lazy var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 12, width: 110, height: 18))
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    // 娱乐指数
    fileprivate lazy var entertainmentIndexLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 30, width: 110, height: 18))
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    // 标题
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 48, width: 110, height: 36))
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bgView)
        bgView.addSubview(timeLabel)
        bgView.addSubview(entertainmentIndexLabel)
        bgView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
//        print("point：", point)
        
        self.titleLabel.frame = CGRect(x: 16, y: 48, width: 110, height: self.titleHeight)
        self.bgView.frame = CGRect(x: 0, y: 0, width: 142, height: 60+self.titleHeight)
        self.frame = CGRect(x: 0, y: 0, width: 142, height: 60+self.titleHeight)
        
        sizeHeight = self.titleHeight

//        originX = point.x // - self.frame.size.width/2 + 16
//        originY = point.y // - self.frame.size.height/2 + 48
//        sizeHeight = self.titleHeight
//        print("point：", point)
//        print("frame:", rect)
        
        var offset = self.offset
        var size = self.frame.size
        if size.width == 0.0 && chartView != nil
        {
            size.width = chartView!.frame.size.width
        }
        if size.height == 0.0 && chartView != nil
        {
            size.height = chartView!.frame.size.height
        }

        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0
        
        var origin = point
        print("origin前：", origin)

        origin.x -= width / 2
        origin.y -= height
        
        
        
        if origin.x + offset.x < 0.0 {// 左边
            offset.x = -width/2 - origin.x
            originX = 0
        }else if let chart = chartView,origin.x + width + offset.x > chart.bounds.size.width // 右边
        {
            offset.x = -origin.x + width
            originX = chart.bounds.size.width - width
        }else {
            offset.x = -width/2
            originX = origin.x
        }
        if origin.y + offset.y < 0 {// 上
            offset.y = -height - origin.y + padding
            originY = 0
        } else if let chart = chartView, origin.y + height + offset.y > chart.bounds.size.height
        {// 暂未处理
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }else {
            offset.y = -height - padding
            originY = origin.y
        }
        
        originX += 16
        originY += 48
        
        print("origin后：", origin)


        return offset
    }

//    open override func draw(context: CGContext, point: CGPoint)
//    {
//
//        let offset = self.offsetForDrawing(atPoint: point)
//        let size = self.size
//
//        var rect = CGRect(
//            origin: CGPoint(
//                x: point.x + offset.x,
//                y: point.y + offset.y),
//            size: size)
//        rect.origin.x -= size.width / 2.0
//        rect.origin.y -= size.height
//
//        context.saveGState()
//
//        if offset.y > 0
//        {
//            context.beginPath()
//            context.move(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
//                y: rect.origin.y + arrowSize.height))
//            //arrow vertex
//            context.addLine(to: CGPoint(
//                x: point.x,
//                y: point.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
//                y: rect.origin.y + arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y + arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y + rect.size.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + rect.size.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + arrowSize.height))
//            context.fillPath()
//        }
//        else
//        {
//            context.beginPath()
//            context.move(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
//            //arrow vertex
//            context.addLine(to: CGPoint(
//                x: point.x,
//                y: point.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y))
//            context.fillPath()
//        }
//
//        if offset.y > 0 {
//            rect.origin.y += self.insets.top + arrowSize.height
//        } else {
//            rect.origin.y += self.insets.top
//        }
//
//        rect.size.height -= self.insets.top + self.insets.bottom
//
//        UIGraphicsPushContext(context)
//
////        label.draw(in: rect, withAttributes: _drawAttributes)
//
//        UIGraphicsPopContext()
//
//        context.restoreGState()
//    }

    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        setLabel(entry)
    }
    
    @objc open func setLabel(_ entry: ChartDataEntry)
    {
//        let model = entry.data as! TMEntertainmentModel
//        let time = String.dateStringFromTimestamp(Int(entry.x), format: "yyyy-MM-dd HH:mm")
        let enterIndex = "娱乐指数：" + "\(Int(entry.y))"
        let title = "李宇春上飞机撒砥砺奋进案例暗室逢灯立刻就安分了健身房按时缴费大路口附近阿斯利康打飞机发生了地方安抚"
                
        self.timeLabel.text = "fsafsaf:\(entry.x)"
        self.entertainmentIndexLabel.text = enterIndex
        self.titleLabel.text = title

        
        
        let titleH = title.isEmpty ? 0 : stringHeight(title, font: UIFont.systemFont(ofSize: 12) , width: 110)
        self.titleHeight = titleH > 36 ? 36 : titleH
        self.title = title

    }
    
    func stringHeight(_ text: String, font:UIFont,width:CGFloat)->CGFloat {
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping;
        let attributes = [NSAttributedString.Key.font:font,
                           NSAttributedString.Key.paragraphStyle:paragraphStyle.copy()]
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
