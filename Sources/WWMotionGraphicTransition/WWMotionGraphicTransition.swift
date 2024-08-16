//
//  WWMotionGraphicTransition.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/13.
//

import UIKit

// MARK: - WWMotionGraphicTransition
open class WWMotionGraphicTransition {
    
    /// 像單片門簾的開關過場動畫
    public class DoorCurtain: UIView {
        
        /// 過場動畫的狀態
        public enum Status {
            case start  // 動畫開始
            case end    // 動畫結束
        }
        
        /// 動畫方向
        public enum Direction {
            case up     // 由下而上 (↑)
            case down   // 由上而下 (↓)
            case left   // 由右而左 (←)
            case right  // 由左而右 (→)
        }
        
        public weak var delegate: WWMotionGraphicTransitionDoorCurtainDelegate?
        
        var count: Int = 0
        var direction: Direction = .right
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
}
