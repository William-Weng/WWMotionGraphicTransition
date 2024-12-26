//
//  DoorCurtain.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/13.
//

import UIKit

// MARK: - 公開函式 (static function)
public extension WWMotionGraphicTransition.DoorCurtain {
    
    /// [產生門簾View](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-uiview-transition-製作圖片轉換動畫-淡入淡出-翻轉-無限循環播放-ad00297f2b5a)
    /// - Parameter frame: CGRect
    /// - Returns: WWMotionGraphicTransition.DoorCurtain
    static func build(frame: CGRect) -> WWMotionGraphicTransition.DoorCurtain {
        return WWMotionGraphicTransition.DoorCurtain(frame: frame)
    }
}

// MARK: - 公開函式 (function)
public extension WWMotionGraphicTransition.DoorCurtain {
    
    /// [動畫開始](https://cod-chill-component.pages.dev/)
    /// - Parameters:
    ///   - count: 門簾數量
    ///   - colors: 門簾顏色
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    func start(count: Int = 3, colors: [UIColor] = [.red, .yellow, .green], duration: TimeInterval = 0.5, direction: WWMotionGraphicTransition.Direction = .right) {
        effectSubViewMaker(with: count, duration: duration, direction: direction, colors: colors)
    }
    
    /// [動畫結束](https://www.appcoda.com.tw/interactive-animation-uiviewpropertyanimator/)
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    func end(duration: TimeInterval = 0.5, direction: WWMotionGraphicTransition.Direction = .right) {
        removeEffectSubView(duration: duration, direction: direction)
    }
}

// MARK: - 小工具
private extension WWMotionGraphicTransition.DoorCurtain {
    
    /// 效果View產生器
    /// - Parameters:
    ///   - count: Int
    ///   - duration: TimeInterval
    ///   - direction: WWMotionGraphicTransition.Direction
    ///   - colors: [UIColor]
    func effectSubViewMaker(with count: Int, duration: TimeInterval, direction: WWMotionGraphicTransition.Direction, colors: [UIColor]) {
        
        (0..<count).forEach { index in
            
            let effectSubView = UIView(frame: frame)
            
            effectSubView.backgroundColor = colors[index % colors.count]
            addSubview(effectSubView)
            
            effectSubViewAnimation(with: index, subView: effectSubView, duration: duration, direction: direction)
        }
    }
    
    /// 移除效果View
    /// - Parameters:
    ///   - duration: TimeInterval
    ///   - direction: WWMotionGraphicTransition.Direction
    func removeEffectSubView(duration: TimeInterval, direction: WWMotionGraphicTransition.Direction) {
        
        for (index, effectSubView) in self.subviews.reversed().enumerated() {
            removeEffectSubViewAnimation(with: index, subView: effectSubView, duration: duration, direction: direction)
        }
    }
    
    /// 效果View的動畫效果
    /// - Parameters:
    ///   - index: Int
    ///   - subView: UIView
    ///   - duration: TimeInterval
    ///   - direction: WWMotionGraphicTransition.Direction
    func effectSubViewAnimation(with index: Int, subView: UIView, duration: TimeInterval, direction: WWMotionGraphicTransition.Direction) {
        
        let number = index + 1
        
        switch direction {
        case .up: subView.frame.origin.y = frame.height
        case .down: subView.frame.origin.y = -frame.height
        case .left: subView.frame.origin.x = frame.width
        case .right: subView.frame.origin.x = -frame.width
        }
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) { [unowned self] in
            switch direction {
            case .up, .down: subView.frame.origin.y = 0
            case .left, .right: subView.frame.origin.x = 0
            }
        }
        
        animator.startAnimation(afterDelay: Double(index) * duration * 0.5)
        delegate?.start(effectView: self, number: number, status: .start)
        
        animator.addCompletion { [unowned self] position in
            delegate?.start(effectView: self, number: number, status: .end)
        }
    }
    
    /// 移除效果View的動畫效果
    /// - Parameters:
    ///   - index: Int
    ///   - subView: UIView
    ///   - duration: TimeInterval
    ///   - direction: WWMotionGraphicTransition.Direction
    func removeEffectSubViewAnimation(with index: Int, subView: UIView, duration: TimeInterval, direction: WWMotionGraphicTransition.Direction) {
        
        switch direction {
        case .up, .down: subView.frame.origin.y = 0
        case .left, .right: subView.frame.origin.x = 0
        }
        
        let number = index + 1
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) { [unowned self] in
            
            switch direction {
            case .up: subView.frame.origin.y = -frame.height
            case .down: subView.frame.origin.y = frame.height
            case .left: subView.frame.origin.x = -frame.width
            case .right: subView.frame.origin.x = frame.width
            }
        }
        
        animator.startAnimation(afterDelay: Double(index) * duration * 0.5)
        delegate?.end(effectView: self, number: number, status: .start)
        
        animator.addCompletion { [unowned self] position in
            subView.removeFromSuperview()
            delegate?.end(effectView: self, number: number, status: .end)
        }
    }
}
