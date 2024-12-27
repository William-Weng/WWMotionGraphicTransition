//
//  Louver.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/12/27.
//

import UIKit

// MARK: - 公開函式 (static function)
public extension WWMotionGraphicTransition.Louver {
    
    /// [風扇葉片View](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-uiview-transition-製作圖片轉換動畫-淡入淡出-翻轉-無限循環播放-ad00297f2b5a)
    /// - Parameter frame: CGRect
    /// - Returns: WWMotionGraphicTransition.FanBlade
    static func build(frame: CGRect) -> WWMotionGraphicTransition.Louver {
        return WWMotionGraphicTransition.Louver(frame: frame)
    }
}

// MARK: - 公開函式 (function)
public extension WWMotionGraphicTransition.Louver {
    
    /// [動畫開始](https://cod-chill-component.pages.dev/)
    /// - Parameters:
    ///   - count: 風扇葉片數量
    ///   - colors: 風扇葉片顏色
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    func start(count: Int = WWMotionGraphicTransition.Louver.rainbowColors.count, colors: [UIColor] = WWMotionGraphicTransition.Louver.rainbowColors, duration: TimeInterval = 0.5, direction: WWMotionGraphicTransition.Direction = .right) {
        self.colors = colors
        effectSubViewMaker(isDisplay: true, count: count, colors: colors, duration: duration, direction: direction)
    }
    
    /// [動畫結束](https://www.appcoda.com.tw/interactive-animation-uiviewpropertyanimator/)
    /// - Parameters:
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    func end(duration: TimeInterval = 0.5, direction: WWMotionGraphicTransition.Direction = .right) {
        effectSubViewMaker(isDisplay: false, count: stackView.arrangedSubviews.count, colors: colors, duration: duration, direction: direction)
    }
}

// MARK: - CAAnimationDelegate
extension WWMotionGraphicTransition.Louver: CAAnimationDelegate {}
public extension WWMotionGraphicTransition.Louver {
    
    func animationDidStart(_ anim: CAAnimation) {
        animationDidStartAction(anim)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationDidStopAction(anim, finished: flag)
    }
}

// MARK: - 小工具
private extension WWMotionGraphicTransition.Louver {
    
    /// 產生效果的View
    /// - Parameters:
    ///   - backgroundColor: 背景色
    func effectViewSetting(backgroundColor: UIColor) {
        
        let effectView = UIView()
        effectView.backgroundColor = backgroundColor
        
        stackView.addArrangedSubview(effectView)
    }
    
    /// 建立效果View
    /// - Parameters:
    ///   - isDisplay: 是否顯示
    ///   - count: 數量
    ///   - colors: 顏色
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    func effectSubViewMaker(isDisplay: Bool, count: Int, colors: [UIColor], duration: TimeInterval, direction: WWMotionGraphicTransition.Direction) {
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        (0..<count).forEach { index in
            let backgroundColor = colors[index % colors.count]
            effectViewSetting(backgroundColor: backgroundColor)
        }
        
        effectSubViewAnimation(isDisplay: isDisplay, duration: duration, direction: direction)
    }
        
    /// 效果View動畫處理
    /// - Parameters:
    ///   - isDisplay: Bool
    ///   - duration: TimeInterval
    ///   - direction: WWMotionGraphicTransition.Direction
    func effectSubViewAnimation(isDisplay: Bool, duration: TimeInterval, direction: WWMotionGraphicTransition.Direction) {
        
        let fromValue = transform3DRotation(isDisplay: isDisplay, direction: direction)
        let toValue = transform3DRotation(isDisplay: !isDisplay, direction: direction)
        let key = isDisplay ? WWMotionGraphicTransition.animKeyWord.start : WWMotionGraphicTransition.animKeyWord.end
        let info = CABasicAnimation._basicAnimation(keyPath: .transform, delegate: self, fromValue: NSValue(caTransform3D: fromValue), toValue: NSValue(caTransform3D: toValue), duration: duration)
                
        for (index, subview) in arrangedSubviews(with: direction).enumerated() {
            
            let number = index + 1
            let key = "\(key)_\(number)"
            let delayTime = CGFloat(number) * duration * 0.5

            subview.transform3D = fromValue
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                subview.layer.add(info.animation, forKey: key)
            }
        }
    }
    
    /// 根據方向的相關設定 (array的排列 / stackView的排列)
    /// - Parameter direction: WWMotionGraphicTransition.Direction
    /// - Returns: [UIView]
    func arrangedSubviews(with direction: WWMotionGraphicTransition.Direction) -> [UIView] {
        
        let arrangedSubviews: [UIView]
        
        switch direction {
        case .up:
            stackView.axis = .vertical
            arrangedSubviews = stackView.arrangedSubviews.reversed()
        case .down:
            stackView.axis = .vertical
            arrangedSubviews = stackView.arrangedSubviews
        case .left:
            stackView.axis = .horizontal
            arrangedSubviews = stackView.arrangedSubviews.reversed()
        case .right:
            stackView.axis = .horizontal
            arrangedSubviews = stackView.arrangedSubviews
        }
        
        return arrangedSubviews
    }

    /// 根據方向來決定旋轉的軸 (轉90度)
    /// - Parameters:
    ///   - isDisplay: Bool
    ///   - direction: WWMotionGraphicTransition.Direction
    /// - Returns: CATransform3D
    func transform3DRotation(isDisplay: Bool, direction: WWMotionGraphicTransition.Direction) -> CATransform3D {
        
        let value: CATransform3D
        let angle = CGFloat.pi
        
        switch direction {
        case .up, .down: value = CATransform3DMakeRotation(angle * 0.5, 1, 0, 0)
        case .left, .right: value = CATransform3DMakeRotation(angle * 0.5, 0, 1, 0)
        }
        
        return isDisplay ? value : CATransform3DIdentity
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
        
        stackView.arrangedSubviews.forEach({ view in
            
            let shapeLayer = view.layer
            
            if let key = shapeLayer.animationKeys()?.first(where: { shapeLayer.animation(forKey: $0) === anim }) {

                let array = key.components(separatedBy: "_")
                
                guard let keyWord = array.first,
                      let value = array.last,
                      let number = Int(value)
                else {
                    return
                }
                
                if (keyWord == WWMotionGraphicTransition.animKeyWord.start) { delegate?.start(effectView: self, number: number, status: status); return }
                if (keyWord == WWMotionGraphicTransition.animKeyWord.end) { delegate?.end(effectView: self, number: number, status: status); return }
            }
        })
    }
}
