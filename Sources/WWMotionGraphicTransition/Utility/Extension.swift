//
//  Extension.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/16.
//

import UIKit

// MARK: - CAShapeLayer (function)
extension CAShapeLayer {
    
    /// 設定路徑
    /// - Parameter path: CGPath
    /// - Returns: Self
    func _path(_ path: CGPath) -> Self { self.path = path; return self }
    
    /// 設定填滿的顏色
    /// - Parameter color: UIColor
    /// - Returns: Self
    func _fillColor(_ color: UIColor?) -> Self { self.fillColor = color?.cgColor; return self }

    /// 設定框線的顏色
    /// - Parameter color: UIColor
    /// - Returns: Self
    func _strokeColor(_ color: UIColor?) -> Self { self.strokeColor = color?.cgColor; return self }
    
    /// 設定框線寬度
    /// - Parameter width: 框線寬度
    /// - Returns: Self
    func _lineWidth(_ width: CGFloat) -> Self { self.lineWidth = width; return self }
    
    /// 設定兩邊端點的樣子
    /// - Parameter round: CAShapeLayerLineCap
    /// - Returns: Self
    func _lineCap(_ round: CAShapeLayerLineCap = .butt) -> Self { self.lineCap = round; return self }
}

// MARK: - UIBezierPath (static function)
extension UIBezierPath {
    
    /// [圓弧路徑](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/運用-uibezierpath-繪製形-3c858e194676)
    /// - Parameters:
    ///   - center: [中心點](https://medium.com/彼得潘的-swift-ios-app-開發教室/利用-uibezierpath-實現圓環進度條-甜甜圈圖表-圓餅圖-625e7e773634)
    ///   - radius: 半徑
    ///   - startAngle: 開始角度 (徑度)
    ///   - endAngle: 結束角度 (徑度)
    ///   - clockwise: 順時針旋轉
    /// - Returns: UIBezierPath
    static func _arc(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> UIBezierPath {
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
}

// MARK: - CAAnimation (static function)
extension CAAnimation {
    
    /// [Layer動畫產生器 (CABasicAnimation)](https://jjeremy-xue.medium.com/swift-說說-cabasicanimation-9be31ee3eae0)
    /// - Parameters:
    ///   - keyPath: [要產生的動畫key值](https://blog.csdn.net/iosevanhuang/article/details/14488239)
    ///   - delegate: [CAAnimationDelegate?](https://juejin.cn/post/6936070813648945165)
    ///   - fromValue: 開始的值
    ///   - toValue: 結束的值
    ///   - duration: 動畫時間
    ///   - repeatCount: 播放次數
    ///   - fillMode: [CAMediaTimingFillMode](https://juejin.cn/post/6991371790245183496)
    ///   - timingFunction: CAMediaTimingFunction?
    ///   - isRemovedOnCompletion: Bool
    /// - Returns: Constant.CAAnimationInformation
    static func _basicAnimation(keyPath: WWMotionGraphicTransition.Constant.AnimationKeyPath = .strokeEnd, delegate: CAAnimationDelegate? = nil, fromValue: Any?, toValue: Any?, duration: CFTimeInterval = 5.0, repeatCount: Float = 1.0, fillMode: CAMediaTimingFillMode = .forwards, timingFunction: CAMediaTimingFunction? = nil, isRemovedOnCompletion: Bool = false) -> WWMotionGraphicTransition.Constant.BasicAnimationInformation {
        
        let animation = CABasicAnimation(keyPath: keyPath.rawValue)
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        animation.delegate = delegate
        animation.timingFunction = timingFunction
        
        return (animation, keyPath)
    }
}
