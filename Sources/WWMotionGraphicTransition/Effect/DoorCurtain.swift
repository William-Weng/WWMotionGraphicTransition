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
    ///   - duration: 動畫時間
    ///   - direction: 動畫方向
    ///   - count: 門簾數量
    ///   - colors: 門簾顏色
    func start(duration: TimeInterval = 0.5, direction: Direction = .right, count: Int = 3, colors: [UIColor] = [.red, .yellow, .green]) {
        
        subviews.forEach { subview in subview.removeFromSuperview() }
        
        self.count = count
        self.direction = direction
        
        (0..<count).forEach { index in
            
            let demoView = UIView(frame: frame)
            demoView.backgroundColor = colors[index % colors.count]
            addSubview(demoView)
            
            switch direction {
            case .up: demoView.frame.origin.y = frame.height
            case .down: demoView.frame.origin.y = -frame.height
            case .left: demoView.frame.origin.x = frame.width
            case .right: demoView.frame.origin.x = -frame.width
            }
                        
            let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) { [unowned self] in
                
                switch direction {
                case .up, .down: demoView.frame.origin.y = 0
                case .left, .right: demoView.frame.origin.x = 0
                }
            }
            
            animator.startAnimation(afterDelay: Double(index) * duration * 0.5)
            delegate?.start(doorCurtain: self, index: index, status: .start)
            
            animator.addCompletion { position in
                self.delegate?.start(doorCurtain: self, index: index, status: .end)
            }
        }
    }
        
    /// [動畫結束](https://www.appcoda.com.tw/interactive-animation-uiviewpropertyanimator/)
    /// - Parameter duration: 動畫時間
    func end(duration: TimeInterval = 0.5) {
        
        for (index, demoView) in self.subviews.reversed().enumerated() {
            
            let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn) { [unowned self] in
                
                switch direction {
                case .up: demoView.frame.origin.y = -frame.height
                case .down: demoView.frame.origin.y = frame.height
                case .left: demoView.frame.origin.x = -frame.width
                case .right: demoView.frame.origin.x = frame.width
                }
            }
            
            animator.startAnimation(afterDelay: Double(index) * duration * 0.5)
            delegate?.end(doorCurtain: self, index: index, status: .start)
            
            animator.addCompletion { position in
                self.delegate?.end(doorCurtain: self, index: index, status: .end)
            }
        }
    }
}

