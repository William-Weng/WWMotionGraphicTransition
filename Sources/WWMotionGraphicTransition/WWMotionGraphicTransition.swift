//
//  WWMotionGraphicTransition.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/13.
//

import UIKit

// MARK: - WWMotionGraphicTransition
open class WWMotionGraphicTransition {
    
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
    
    /// Constant
    public class Constant: NSObject {}
        
    /// 像單片門簾的開關過場動畫
    public class DoorCurtain: UIView {
        
        public weak var delegate: WWMotionGraphicTransitionDelegate?
        
        var count: Int = 0                                          // 過場動畫View數量
        var direction: Direction = .right                           // 過場動畫的方向
        
        public override init(frame: CGRect) { super.init(frame: frame) }
        required init?(coder: NSCoder) { super.init(coder: coder) }
    }
    
    /// 像電風扇葉片的旋轉過場動畫
    public class FanBlade: UIView {
        
        public weak var delegate: WWMotionGraphicTransitionDelegate?
        
        let mainLayer = CALayer()
        let animKeyWord: (start: String, end: String) = ("Start", "End")

        var count: Int = 0                                          // 過場動畫View數量
        var colors: [UIColor] = []                                  // 過場動畫Layer顏色四
        var direction: WWMotionGraphicTransition.Direction = .right // 過場動畫的方向
        var layerRadius: CGFloat = 0                                // Layer圓弧半徑
        var layerCenter: CGPoint = .zero                            // Layer圓弧中點
        
        public override init(frame: CGRect) { super.init(frame: frame) }
        required init?(coder: NSCoder) { super.init(coder: coder) }
    }
}
