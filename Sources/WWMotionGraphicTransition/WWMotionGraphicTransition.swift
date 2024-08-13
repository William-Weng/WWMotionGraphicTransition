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
        
        public weak var delegate: WWMotionGraphicTransitionDoorCurtainDelegate?
        
        var count: Int = 0
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
}
