//
//  WWMotionGraphicTransition.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/13.
//

import UIKit

// MARK: - WWMotionGraphicTransition
open class WWMotionGraphicTransition {
    
    static let animKeyWord: (start: String, end: String) = ("Start", "End")
    
    /// 過場動畫的狀態
    public enum Status {
        case start                          // 動畫開始
        case end                            // 動畫結束
    }
    
    /// 動畫方向
    public enum Direction {
        case up                             // 由下而上 (↑)
        case down                           // 由上而下 (↓)
        case left                           // 由右而左 (←)
        case right                          // 由左而右 (→)
    }
            
    /// 像單片門簾的開關過場動畫
    public class DoorCurtain: UIView {
        public weak var delegate: WWMotionGraphicTransitionDelegate?
    }
    
    /// 像電風扇葉片的旋轉過場動畫
    public class FanBlade: UIView {
        
        public weak var delegate: WWMotionGraphicTransitionDelegate?
        
        let mainLayer = CALayer()

        var colors: [UIColor] = []          // 過場動畫Layer顏色
        var layerRadius: CGFloat = 0        // Layer圓弧半徑
        var layerCenter: CGPoint = .zero    // Layer圓弧中點
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            layer.addSublayer(mainLayer)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            layer.addSublayer(mainLayer)
        }
    }
    
    /// 像百葉窗的開關過場動畫
    public class Louver: UIView {
        
        static public let rainbowColors = [
            UIColor(red: 255 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1.0),     // 紅
            UIColor(red: 255 / 255, green: 127 / 255, blue: 0 / 255, alpha: 1.0),   // 橙
            UIColor(red: 255 / 255, green: 255 / 255, blue: 0 / 255, alpha: 1.0),   // 黃
            UIColor(red: 0 / 255, green: 255 / 255, blue: 0 / 255, alpha: 1.0),     // 綠
            UIColor(red: 0 / 255, green: 0 / 255, blue: 255 / 255, alpha: 1.0),     // 藍
            UIColor(red: 75 / 255, green: 0 / 255, blue: 130 / 255, alpha: 1.0),    // 靛
            UIColor(red: 148 / 255, green: 0 / 255, blue: 211 / 255, alpha: 1.0)    // 紫
        ]
        
        public weak var delegate: WWMotionGraphicTransitionDelegate?
        
        let stackView = UIStackView()
        
        var colors: [UIColor] = []
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            stackView._autolayout(on: self)
            stackView.distribution = .fillEqually
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            stackView._autolayout(on: self)
            stackView.distribution = .fillEqually
        }
    }
}
