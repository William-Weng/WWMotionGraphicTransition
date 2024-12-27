//
//  DoorCurtain.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/16.
//

import UIKit

// MARK: - 公開函式 (static function)
public extension WWMotionGraphicTransition.FanBlade {
    
    /// [風扇葉片View](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-uiview-transition-製作圖片轉換動畫-淡入淡出-翻轉-無限循環播放-ad00297f2b5a)
    /// - Parameter frame: CGRect
    /// - Returns: WWMotionGraphicTransition.FanBlade
    static func build(frame: CGRect) -> WWMotionGraphicTransition.FanBlade {
        return WWMotionGraphicTransition.FanBlade(frame: frame)
    }
}

// MARK: - CAAnimationDelegate
extension WWMotionGraphicTransition.FanBlade: CAAnimationDelegate {}
public extension WWMotionGraphicTransition.FanBlade {
    
    func animationDidStart(_ anim: CAAnimation) {
        animationDidStartAction(anim)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationDidStopAction(anim, finished: flag)
    }
}

// MARK: - 公開函式 (function)
public extension WWMotionGraphicTransition.FanBlade {
    
    /// [動畫開始](https://cod-chill-component.pages.dev/)
    /// - Parameters:
    ///   - count: 風扇葉片數量
    ///   - colors: 風扇葉片顏色
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    func start(count: Int = 3, colors: [UIColor] = [.red, .yellow, .green], duration: TimeInterval = 0.5, direction: WWMotionGraphicTransition.Direction = .right) {
        
        mainLayer.sublayers?.forEach { subLayer in subLayer.removeFromSuperlayer() }        
        subLayerAnimation(count: count, colors: colors, duration: duration, direction: direction)
    }
    
    /// [動畫結束](https://www.appcoda.com.tw/interactive-animation-uiviewpropertyanimator/)
    /// - Parameters:
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    func end(duration: TimeInterval = 0.5, direction: WWMotionGraphicTransition.Direction = .right) {
        
        guard let sublayers = mainLayer.sublayers else { return }
        
        sublayers.forEach { $0.removeFromSuperlayer() }
        cleanSubLayerAnimation(count: sublayers.count, duration: duration, direction: direction)
    }
}

// MARK: - 小工具
private extension WWMotionGraphicTransition.FanBlade {
        
    /// 開始的Layer動畫 (畫半圓)
    /// - Parameters:
    ///   - count: Int
    ///   - colors: [UIColor]
    ///   - duration: TimeInterval
    ///   - direction: WWMotionGraphicTransition.Direction
    func subLayerAnimation(count: Int, colors: [UIColor], duration: TimeInterval, direction: WWMotionGraphicTransition.Direction) {
        
        let layerRadius = frame.width * 0.5 / CGFloat(count)
        let layerCenter = layerCenter(with: direction, radius: layerRadius)
        let angleRange = angleRange(with: direction)
        
        self.colors = colors
        self.layerRadius = layerRadius
        self.layerCenter = layerCenter
        
        (1...count + 1).forEach { number in
            
            let shapeLayer = shapeLayerMaker(with: number, radius: layerRadius, center: layerCenter, startAngle: angleRange.start, endAngle: angleRange.end, clockwise: angleRange.clockwise)
            let info = CAAnimation._basicAnimation(delegate: self, fromValue: 0.0, toValue: 1.0, duration: duration)
            let delayTime = CGFloat(number) * duration * 0.5
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) { [unowned self] in
                mainLayer.addSublayer(shapeLayer)
                shapeLayer.add(info.animation, forKey: "\(WWMotionGraphicTransition.animKeyWord.start)_\(number)")
            }
        }
    }
    
    /// 清除的Layer (圓倒著畫 => 變短)
    /// - Parameters:
    ///   - count: Int
    ///   - duration: TimeInterval
    ///   - direction: WWMotionGraphicTransition.Direction
    func cleanSubLayerAnimation(count: Int, duration: TimeInterval, direction: WWMotionGraphicTransition.Direction) {
        
        let angleRange = angleRange(with: direction)
        
        (1...count).forEach { number in
            
            let multiple = CGFloat(number) * 2 + 1
            let delayTime = CGFloat(number) * duration * 0.5
            let lineWidth = layerRadius * 2.0
            
            let path = UIBezierPath(arcCenter: layerCenter, radius: multiple * layerRadius, startAngle: angleRange.end, endAngle: angleRange.start, clockwise: !angleRange.clockwise)
            let info = CAAnimation._basicAnimation(fromValue: 1.0, toValue: 0.0, duration: duration)
            let strokeColor = colors[number % colors.count]
            let shapeLayer = CAShapeLayer()._path(path.cgPath)._strokeColor(strokeColor)._fillColor(.clear)._lineWidth(lineWidth)
            
            mainLayer.addSublayer(shapeLayer)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) { [unowned self] in
                shapeLayer.add(info.animation, forKey: "\(WWMotionGraphicTransition.animKeyWord.end)_\(number)")
            }
        }
    }
    
    /// 產生圓弧Layer
    /// - Parameters:
    ///   - number: Int
    ///   - radius: CGFloat
    ///   - center: CGPoint
    ///   - startAngle: CGFloat
    ///   - endAngle: CGFloat
    ///   - clockwise: Bool
    /// - Returns: CAShapeLayer
    func shapeLayerMaker(with number: Int, radius: CGFloat, center: CGPoint, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> CAShapeLayer {
        
        let multiple = CGFloat(number) * 2 + 1
        let lineWidth = radius * 2.0
        
        let path = UIBezierPath(arcCenter: center, radius: multiple * radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        let strokeColor = colors[number % colors.count]
        let shapeLayer = CAShapeLayer()._path(path.cgPath)._strokeColor(strokeColor)._fillColor(.clear)._lineWidth(lineWidth)
        
        return shapeLayer
    }
    
    /// 動畫開始的處理
    /// - Parameter anim: CAAnimation
    func animationDidStartAction(_ anim: CAAnimation) {
        animationAction(anim, status: .start)
    }
    
    /// 動畫結束的處理
    /// - Parameters:
    ///   - anim: CAAnimation
    ///   - flag: Bool
    func animationDidStopAction(_ anim: CAAnimation, finished flag: Bool) {
        animationAction(anim, status: .end)
    }
    
    /// 動畫處理 + WWMotionGraphicTransitionDelegate
    /// - Parameters:
    ///   - anim: CAAnimation
    ///   - status: WWMotionGraphicTransition.Status
    func animationAction(_ anim: CAAnimation, status: WWMotionGraphicTransition.Status) {
        
        mainLayer.sublayers?.forEach({ shapeLayer in
            
            if let key = shapeLayer.animationKeys()?.first(where: { shapeLayer.animation(forKey: $0) === anim }) {

                let array = key.components(separatedBy: "_")
                
                guard let keyWord = array.first,
                      let value = array.last,
                      let number = Int(value)
                else {
                    return
                }
                
                if (keyWord == WWMotionGraphicTransition.animKeyWord.start) { delegate?.start(effectView: self, number: number - 1, status: status); return }
                if (keyWord == WWMotionGraphicTransition.animKeyWord.end) { delegate?.end(effectView: self, number: number - 1, status: status); return }
            }
        })
    }
    
    /// 動畫Layer層中點
    /// - Parameters:
    ///   - direction: WWMotionGraphicTransition.Direction
    ///   - radius: CGFloat
    /// - Returns: CGPoint
    func layerCenter(with direction: WWMotionGraphicTransition.Direction, radius: CGFloat) -> CGPoint {
        
        let point: CGPoint
        
        switch direction {
        case .up: point = CGPoint(x: frame.width * 0.5, y: radius * 2.5 + frame.height)
        case .down: point = CGPoint(x: frame.width * 0.5, y: -radius * 2.5)
        case .left: point = CGPoint(x: radius * 2.5 + frame.width, y: frame.height * 0.5)
        case .right: point = CGPoint(x: -radius * 2.5, y: frame.height * 0.5)
        }
        
        return point
    }
    
    /// 動畫Layer層的角度設定
    /// - Parameter direction: WWMotionGraphicTransition.Direction
    /// - Returns: WWMotionGraphicTransition.Constant.AngleRange
    func angleRange(with direction: WWMotionGraphicTransition.Direction) -> WWMotionGraphicTransition.AngleRange {
        
        let range: WWMotionGraphicTransition.AngleRange
        
        switch direction {
        case .up: range = (start: .pi * 1.0, end: .pi * 0.0, clockwise: true)
        case .down: range = (start: .pi * 1.0, end: .pi * 0.0, clockwise: false)
        case .left: range = (start: .pi * -0.5, end: .pi * 0.5, clockwise: false)
        case .right: range = (start: .pi * -0.5, end: .pi * 0.5, clockwise: true)
        }
        
        return range
    }
}
