//
//  GraphComponent.swift
//  graph
//
//  Created by Admin on 2/28/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class GraphComponent : UIScrollView {
    private var startDate: Date?
    private var endDate: Date?
    private var DAYS_BACK_MILLIS : CGFloat = 0
    private var DAYS_FORWARD_MILLIS : CGFloat = 0
    private var HOURS_IN_VIEWPORT_MILLIS : CGFloat = 10 * 24 * 60 * 60
    private var TIME_LABEL_SPACING_MILLIS : CGFloat = 24 * 60 * 60
    
    private var minumumBrix: Double = 0
    private var maximumBrix: Double = 0
    private var minumumTemp: Double = 0
    private var maximumTemp: Double = 0

    private var mClipRect : CGRect?
    private var mDrawingRect : CGRect?
    private var mMeasuringRect : CGRect?
    
    private var mBrixColor: UIColor?
    private var mTempColor: UIColor?
    private var mPointSize: CGFloat?
    private var mTimeBarHeight: CGFloat?
    
    private var mClickListener : EPGClickListener?;
    private var mMaxHorizontalScroll: CGFloat?
    private var mMaxVerticalScroll: CGFloat?
    private var mMillisPerPixel: CGFloat?
    private var mTimeOffset: CGFloat?
    private var mTimeLowerBoundary: CGFloat?
    private var mTimeUpperBoundary: CGFloat?
    
    private var m_bIsScrollLocked: Bool?
    
    private var bIsLongClickChecked: Bool?
    
    private var epgData: Array<PointData>?
    
    private var longPressBeginTime: TimeInterval?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mDrawingRect = CGRect()
        self.mClipRect = CGRect()
        self.mMeasuringRect = CGRect()
        
        self.mBrixColor = UIColor.orange
        self.mTempColor = UIColor.blue
        self.mPointSize = 5.0
        self.mTimeBarHeight = 50
        
        m_bIsScrollLocked = false
        
        self.bIsLongClickChecked = false
        
        mClickListener = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.mDrawingRect = CGRect()
        self.mClipRect = CGRect()
        self.mMeasuringRect = CGRect()
        
        self.mBrixColor = UIColor.orange
        self.mTempColor = UIColor.blue
        self.mPointSize = 5.0
        self.mTimeBarHeight = 50
        
        m_bIsScrollLocked = false
        
        self.bIsLongClickChecked = false
        
        mClickListener = nil
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        let drawingRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: self.frame.width, height: self.frame.height)
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addRect(drawingRect)
        ctx.drawPath(using: .fill)
        
        if(self.epgData != nil && (self.epgData?.count)! > 0) {
            self.mTimeLowerBoundary = CGFloat(getTimeFrom(x: contentOffset.x).timeIntervalSince1970)
            self.mTimeUpperBoundary = CGFloat(getTimeFrom(x: contentOffset.x + self.frame.width).timeIntervalSince1970)
            
            mDrawingRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: self.frame.width, height: self.frame.height)
            
            drawTopBar(ctx: ctx)
            drawTimeLine(ctx: ctx)
            drawBrixAxis(ctx: ctx)
            drawTempAxis(ctx: ctx)
            drawBrix(ctx: ctx)
            drawTemp(ctx: ctx)
            drawTimeBar(ctx: ctx)
        }
    }
    
    private func drawTimeBar(ctx: CGContext) {
        let drawingRect = CGRect(x: contentOffset.x, y: self.frame.height - mTimeBarHeight!, width: self.frame.width, height: mTimeBarHeight!)
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addRect(drawingRect)
        ctx.drawPath(using: .fill)
        
        mClipRect = CGRect(x: contentOffset.x + mTimeBarHeight!, y: self.frame.height - mTimeBarHeight!, width: self.frame.width - 2 * mTimeBarHeight!, height: mTimeBarHeight!)
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        for i in 0 ..< (Int)(HOURS_IN_VIEWPORT_MILLIS / TIME_LABEL_SPACING_MILLIS) + 1 {
            let time = TIME_LABEL_SPACING_MILLIS * CGFloat((Int)((mTimeLowerBoundary! + (TIME_LABEL_SPACING_MILLIS * CGFloat(i))) + (TIME_LABEL_SPACING_MILLIS / 2)) / (Int)(TIME_LABEL_SPACING_MILLIS))
            
            let timeStr = Utils.getShortTime(date: Date(timeIntervalSince1970: TimeInterval(exactly: time)!))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                         NSAttributedString.Key.paragraphStyle: paragraphStyle,
                         NSAttributedString.Key.foregroundColor: UIColor.gray]
            
            let stringSize = (timeStr as NSString).size(withAttributes: attrs as [NSAttributedString.Key : Any])
            
            let xPos = getXFrom(date: Date(timeIntervalSince1970: TimeInterval(time))) - stringSize.width / 2
            let yPos = drawingRect.minY
            
            timeStr.draw(at: CGPoint(x: xPos, y: yPos), withAttributes: attrs)
        }
        
        ctx.restoreGState()
        
        drawTimeBarDayIndicator(ctx: ctx)
    }
    
    private func drawTimeBarDayIndicator(ctx: CGContext) {
        let drawingRect = CGRect(x: contentOffset.x, y: self.frame.height - mTimeBarHeight!, width: self.frame.width, height: mTimeBarHeight!)
        
        mClipRect = CGRect(x: contentOffset.x + mTimeBarHeight!, y: self.frame.height - mTimeBarHeight!, width: self.frame.width - 2 * mTimeBarHeight!, height: mTimeBarHeight!)
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        for i in 0 ..< (Int)(HOURS_IN_VIEWPORT_MILLIS / TIME_LABEL_SPACING_MILLIS) + 1 {
            let time = TIME_LABEL_SPACING_MILLIS * CGFloat((Int)((mTimeLowerBoundary! + (TIME_LABEL_SPACING_MILLIS * CGFloat(i))) + (TIME_LABEL_SPACING_MILLIS / 2)) / (Int)(TIME_LABEL_SPACING_MILLIS))
            
            let timeDate = Date(timeIntervalSince1970: TimeInterval(exactly: time)!)
            
            let timeDateString = Utils.getDateString(date: timeDate)
            if(timeDateString != "01") {
                continue
            }
            
            let timeStr = Utils.getMonth(date: timeDate)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                         NSAttributedString.Key.paragraphStyle: paragraphStyle,
                         NSAttributedString.Key.foregroundColor: UIColor.gray]
            
            let xPos = getXFrom(date: Date(timeIntervalSince1970: TimeInterval(time)))
            let yPos = drawingRect.minY + mTimeBarHeight! / 2
            
            timeStr.draw(at: CGPoint(x: xPos, y: yPos), withAttributes: attrs)
        }
        
        ctx.restoreGState()
    }
    
    private func drawTopBar(ctx: CGContext) {
        var drawingRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: self.frame.width, height: mTimeBarHeight!)
        mClipRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: self.frame.width, height: mTimeBarHeight!)
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addRect(drawingRect)
        
        ctx.drawPath(using: .fill)
        
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        drawingRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: mTimeBarHeight!, height: mTimeBarHeight!)
        
        var timeStr = "Brix"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                     NSAttributedString.Key.paragraphStyle: paragraphStyle,
                     NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        var stringSize = (timeStr as NSString).size(withAttributes: attrs as [NSAttributedString.Key : Any])
        
        drawingRect = drawingRect.offsetBy(dx: 0, dy: (drawingRect.height - stringSize.height) / 2)
        
        (timeStr as NSString).draw(with: drawingRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs as [NSAttributedString.Key : Any], context: nil)
        
        attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: UIColor.blue]
        
        drawingRect = CGRect(x: contentOffset.x + self.frame.width - mTimeBarHeight!, y: contentOffset.y, width: mTimeBarHeight!, height: mTimeBarHeight!)
        stringSize = (timeStr as NSString).size(withAttributes: attrs as [NSAttributedString.Key : Any])
        
        drawingRect = drawingRect.offsetBy(dx: 0, dy: (drawingRect.height - stringSize.height) / 2)
        timeStr = "Temp"
        (timeStr as NSString).draw(with: drawingRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs as [NSAttributedString.Key : Any], context: nil)
        
        ctx.restoreGState()
    }
    
    private func drawTimeLine(ctx: CGContext) {
        mClipRect = CGRect(x: contentOffset.x + mTimeBarHeight!, y: self.contentOffset.y + mTimeBarHeight!, width: self.frame.width - 2 * mTimeBarHeight!, height: self.frame.height - 2 * mTimeBarHeight!)
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        ctx.setStrokeColor(UIColor.gray.cgColor)
        ctx.addRect(mClipRect!)
        ctx.drawPath(using: .stroke)
        
        for i in 0 ..< (Int)(HOURS_IN_VIEWPORT_MILLIS / TIME_LABEL_SPACING_MILLIS) {
            let time = TIME_LABEL_SPACING_MILLIS * CGFloat((Int)((mTimeLowerBoundary! + (TIME_LABEL_SPACING_MILLIS * CGFloat(i))) + (TIME_LABEL_SPACING_MILLIS / 2)) / (Int)(TIME_LABEL_SPACING_MILLIS))
            
            ctx.setLineWidth(1)
            ctx.setFillColor(UIColor.gray.cgColor)
            ctx.setStrokeColor(UIColor.gray.cgColor)
            ctx.move(to: CGPoint(x: getXFrom(date: Date(timeIntervalSince1970: TimeInterval(time))), y: self.contentOffset.y + mTimeBarHeight!))
            ctx.addLine(to: CGPoint(x: getXFrom(date: Date(timeIntervalSince1970: TimeInterval(time))), y: self.contentOffset.y + self.frame.height - mTimeBarHeight!))
            
            ctx.strokePath()
        }
        
        ctx.restoreGState()
        
        drawTimeBarDayIndicator(ctx: ctx)
    }
    
    private func drawBrix(ctx: CGContext) {
        let firstPos = getFirstVisiblePosition()
        let lastPos = getLastVisiblePosition()
        
        mClipRect = CGRect(x: contentOffset.x + mTimeBarHeight!, y: contentOffset.y + mTimeBarHeight!, width: self.frame.width - 2 * mTimeBarHeight!, height: self.frame.height - 2 * mTimeBarHeight!)
        
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        ctx.setFillColor(UIColor.orange.cgColor)
        ctx.setStrokeColor(UIColor.orange.cgColor)
        
        for pos in firstPos...lastPos {
            let xPos = getXFrom(date: epgData![pos].date.addingTimeInterval(-TimeInterval(startDate!.timeIntervalSince1970)))
            let yPos = mClipRect!.maxY - (CGFloat(epgData![pos].brix - self.minumumBrix) * mClipRect!.height / abs(CGFloat(self.maximumBrix - self.minumumBrix)))
            
            ctx.addEllipse(in: CGRect(x: xPos - 2, y: yPos - 2, width: 4, height: 4))
            ctx.drawPath(using: .fillStroke)
        }
        
        ctx.setLineWidth(1)
        for pos in firstPos...lastPos - 1 {
            let  path = UIBezierPath()

            let xPosStart = getXFrom(date: epgData![pos].date.addingTimeInterval(-TimeInterval(startDate!.timeIntervalSince1970)))
            let yPosStart = mClipRect!.maxY - (CGFloat(epgData![pos].brix - self.minumumBrix) * mClipRect!.height / abs(CGFloat(self.maximumBrix - self.minumumBrix)))
            
            let xPosEnd = getXFrom(date: epgData![pos + 1].date.addingTimeInterval(-TimeInterval(startDate!.timeIntervalSince1970)))
            let yPosEnd = mClipRect!.maxY - (CGFloat(epgData![pos + 1].brix - self.minumumBrix) * mClipRect!.height / abs(CGFloat(self.maximumBrix - self.minumumBrix)))
            
            path.move(to: CGPoint(x: xPosStart, y: yPosStart))
            path.addLine(to: CGPoint(x: xPosEnd, y: yPosEnd))
            
            let calendar = Calendar.current

            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: epgData![pos].date)
            let date2 = calendar.startOfDay(for: epgData![pos + 1].date)

            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if(components.day! > 1) {
                let  dashes: [ CGFloat ] = [ 16.0, 8.0 ]
                path.setLineDash(dashes, count: dashes.count, phase: 0.0)
            }
            
            path.stroke()
        }
        ctx.drawPath(using: .stroke)

        ctx.restoreGState()
    }
    
    private func drawTemp(ctx: CGContext) {
        let firstPos = getFirstVisiblePosition()
        let lastPos = getLastVisiblePosition()
        
        mClipRect = CGRect(x: contentOffset.x + mTimeBarHeight!, y: contentOffset.y + mTimeBarHeight!, width: self.frame.width - 2 * mTimeBarHeight!, height: self.frame.height - 2 * mTimeBarHeight!)
        
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        ctx.setFillColor(UIColor.blue.cgColor)
        ctx.setStrokeColor(UIColor.blue.cgColor)
        
        for pos in firstPos...lastPos {
            let xPos = getXFrom(date: epgData![pos].date.addingTimeInterval(-TimeInterval(startDate!.timeIntervalSince1970)))
            let yPos = mClipRect!.maxY - (CGFloat(epgData![pos].temp - self.minumumTemp) * mClipRect!.height / abs(CGFloat(self.maximumTemp - self.minumumTemp)))
            
            ctx.addEllipse(in: CGRect(x: xPos - 2, y: yPos - 2, width: 4, height: 4))
            ctx.drawPath(using: .fillStroke)
        }
        
        ctx.setLineWidth(1)
        for pos in firstPos...lastPos - 1 {
            let  path = UIBezierPath()

            let xPosStart = getXFrom(date: epgData![pos].date.addingTimeInterval(-TimeInterval(startDate!.timeIntervalSince1970)))
            let yPosStart = mClipRect!.maxY - (CGFloat(epgData![pos].temp - self.minumumTemp) * mClipRect!.height / abs(CGFloat(self.maximumTemp - self.minumumTemp)))
            
            let xPosEnd = getXFrom(date: epgData![pos + 1].date.addingTimeInterval(-TimeInterval(startDate!.timeIntervalSince1970)))
            let yPosEnd = mClipRect!.maxY - (CGFloat(epgData![pos + 1].temp - self.minumumTemp) * mClipRect!.height / abs(CGFloat(self.maximumTemp - self.minumumTemp)))
            
            path.move(to: CGPoint(x: xPosStart, y: yPosStart))
            path.addLine(to: CGPoint(x: xPosEnd, y: yPosEnd))
            
            let calendar = Calendar.current

            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: epgData![pos].date)
            let date2 = calendar.startOfDay(for: epgData![pos + 1].date)

            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if(components.day! > 1) {
                let  dashes: [ CGFloat ] = [ 16.0, 8.0 ]
                path.setLineDash(dashes, count: dashes.count, phase: 0.0)
            }
            
            path.stroke()
        }
        
        ctx.restoreGState()
    }
    
    private func drawBrixAxis(ctx: CGContext) {
        let divider = 10
        let divideValue = abs(self.maximumBrix - self.minumumBrix) / Double(divider)
        
        let drawingRect = CGRect(x: contentOffset.x, y: contentOffset.y + mTimeBarHeight!, width: mTimeBarHeight!, height: self.frame.height - mTimeBarHeight! * 2)
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addRect(drawingRect)
        
        ctx.drawPath(using: .fill)
        
        mClipRect = CGRect(x: contentOffset.x, y: contentOffset.y + mTimeBarHeight!, width: mTimeBarHeight!, height: self.frame.height - mTimeBarHeight! * 2)
        
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        for i in 0...divider {
            let timeStr = String(round(self.minumumBrix + Double(i) * divideValue))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            
            let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
                         NSAttributedString.Key.paragraphStyle: paragraphStyle,
                         NSAttributedString.Key.foregroundColor: UIColor.orange]
            
            timeStr.draw(at: CGPoint(x: contentOffset.x + 5, y: drawingRect.maxY - (CGFloat(Double(i) * divideValue) * drawingRect.height / abs(CGFloat(self.maximumBrix - self.minumumBrix)))), withAttributes: attrs)
        }
        
        ctx.restoreGState()
    }
    
    private func drawTempAxis(ctx: CGContext) {
        let divider = 7
        let divideValue = abs(self.maximumTemp - self.minumumTemp) / Double(divider)
        
        let drawingRect = CGRect(x: contentOffset.x + self.frame.width - mTimeBarHeight!, y: contentOffset.y + mTimeBarHeight!, width: mTimeBarHeight!, height: self.frame.height - mTimeBarHeight! * 2)
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addRect(drawingRect)
        
        ctx.drawPath(using: .fill)
        
        mClipRect = CGRect(x: contentOffset.x + self.frame.width - mTimeBarHeight!, y: contentOffset.y + mTimeBarHeight!, width: mTimeBarHeight!, height: self.frame.height - mTimeBarHeight! * 2)
        
        ctx.saveGState()
        ctx.clip(to: mClipRect!)
        
        for i in 0...divider {
            let timeStr = String(round(self.minumumTemp + Double(i) * divideValue))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
                         NSAttributedString.Key.paragraphStyle: paragraphStyle,
                         NSAttributedString.Key.foregroundColor: UIColor.blue]
            
            timeStr.draw(at: CGPoint(x: drawingRect.minX + 5, y: drawingRect.maxY - (CGFloat(Double(i) * divideValue) * drawingRect.height / abs(CGFloat(self.maximumTemp - self.minumumTemp)))), withAttributes: attrs)
        }
        
        ctx.restoreGState()
    }
    
    public func setStartAndEndDate(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        
        self.DAYS_BACK_MILLIS = 0
        self.DAYS_FORWARD_MILLIS = CGFloat(endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
    }
    
    private func shouldDrawTimeLine(date: Date) -> Bool{
        return CGFloat(date.timeIntervalSince1970) >= mTimeLowerBoundary! && CGFloat(date.timeIntervalSince1970) < mTimeUpperBoundary!
    }
    
    private func calculateBaseLine() -> CGFloat{
        return self.DAYS_BACK_MILLIS
    }
    
    private func getFirstVisiblePosition() -> Int {
        let x = contentOffset.x
        
        let dayWidth = (self.frame.width - 2 * mTimeBarHeight!) / (HOURS_IN_VIEWPORT_MILLIS / TIME_LABEL_SPACING_MILLIS)
        
        var position = (Int)((x - mTimeBarHeight!) / dayWidth)
        if(position < 0) {
            position = 0
        }
        
        return position
    }
    
    private func getLastVisiblePosition() -> Int {
        let x = contentOffset.x
        
        let dayWidth = (self.frame.width - 2 * mTimeBarHeight!) / (HOURS_IN_VIEWPORT_MILLIS / TIME_LABEL_SPACING_MILLIS)
        var position = (Int)((x + self.frame.width + mTimeBarHeight!) / dayWidth)
        if(position > epgData!.count - 1) {
            position = epgData!.count - 1
        }
        
        return position
    }
    
    private func calculateMaxHorizontalScroll() {
        mMaxHorizontalScroll = (DAYS_FORWARD_MILLIS - DAYS_BACK_MILLIS - HOURS_IN_VIEWPORT_MILLIS) / mMillisPerPixel!
    }
    
    private func calculateMaxVerticalScroll() {
        mMaxVerticalScroll = self.frame.height
    }
    
    private func getXFrom(date: Date) -> CGFloat{
        return (CGFloat(date.timeIntervalSince1970) - mTimeOffset!) / mMillisPerPixel! + mTimeBarHeight!
    }
    
    private func getTimeFrom(x: CGFloat) -> Date {
        return Date(timeIntervalSince1970: TimeInterval((x * mMillisPerPixel!) + mTimeOffset!))
    }
    
    private func calculateMillsPerPixel() -> CGFloat {
        return HOURS_IN_VIEWPORT_MILLIS / (self.frame.width - 2 * mTimeBarHeight!)
    }
    
    private func resetBoundaries() {
        mMillisPerPixel = calculateMillsPerPixel()
        mTimeOffset = calculateBaseLine()
        mTimeLowerBoundary = CGFloat(getTimeFrom(x: 0).timeIntervalSince1970)
        mTimeUpperBoundary = CGFloat(getTimeFrom(x: self.frame.width).timeIntervalSince1970)
    }
    
    public func setEPGClickListener(epgClickListenner: EPGClickListener) {
        mClickListener = epgClickListenner
    }
    
    public func setEPGData(epgData: Array<PointData>) {
        self.epgData = epgData
        
        for pointData in epgData {
            if(pointData.brix > self.maximumBrix) {
                self.maximumBrix = pointData.brix
            }
            if(pointData.brix < self.minumumBrix) {
                self.minumumBrix = pointData.brix
            }
            
            if(pointData.temp > self.maximumTemp) {
                self.maximumTemp = pointData.temp
            }
            if(pointData.temp < self.minumumTemp) {
                self.minumumTemp = pointData.temp
            }
        }
        
        setStartAndEndDate(startDate: epgData.first!.date, endDate: epgData.last!.date)
    }
    
    public func recalculateAndRedraw(reset: Bool) {
        if(epgData != nil) {
            resetBoundaries()
            
            calculateMaxVerticalScroll()
            calculateMaxHorizontalScroll()
            
            contentSize.width = mMaxHorizontalScroll!
            contentSize.height = mMaxVerticalScroll!
            
            setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            
//            if let size = epgData?.count() {
//                if(size > 0) {
//                    if(m_iSelectedChannel! == -1 || m_iSelectedChannel! > size - 1) {
//                        m_iSelectedChannel = 0
//                    }
//                    else {
//                        if(m_iSelectedTopic! != -1) {
//                            epgData?.getAt(index: m_iSelectedChannel!).m_arrItemTopic?.getAt(index: m_iSelectedTopic!).m_bIsSelected = false
//                        }
//                    }
//
//                    if(m_iSelectedChannel! > -1 && epgData!.getAt(index: m_iSelectedChannel!).getCurrentTopicIndex() > -1) {
//                        selectTopicByTime(selectedTopicStart: epgData!.getAt(index: m_iSelectedChannel!).m_arrItemTopic?.getAt(index: epgData!.getAt(index: m_iSelectedChannel!).getCurrentTopicIndex()).m_dateTopicStart);
//                        if(reset) {
//                            setContentOffset(CGPoint(x: getXPositionStart(), y: contentOffset.y), animated: false)
//                        }
//                    }
//                }
//                else {
//                    m_iSelectedChannel = -1;
//                    m_iSelectedTopic = -1;
//                    mClickListener!.onEventClicked(channelPosition: m_iSelectedChannel!, programPosition: m_iSelectedTopic!, epgEvent: nil)
//                }
//            }
            redraw();
        }
    }
    
    private func redraw() {
        setNeedsDisplay()
    }
}

protocol EPGClickListener {
//    func onChannelClicked(channelPosition: Int, epgChannel: ChannelItem);
//    func onFavoriteClicked(channelPosition: Int, epgChannel: ChannelItem);
//    func onLongClicked(channelPosition: Int, epgEvent: ItemTopic);
//    func onEventClicked(channelPosition: Int, programPosition: Int, epgEvent: ItemTopic?);
//    func onResetButtonClicked();
//    func onLostFocus();
}

