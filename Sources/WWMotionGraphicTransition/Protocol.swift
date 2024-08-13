//
//  Protocol.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/13.
//

import UIKit

/// MARK: - 單片門簾效果的Delegate
public protocol WWMotionGraphicTransitionDoorCurtainDelegate: AnyObject {
    
    /// 動畫開始
    /// - Parameters:
    ///   - doorCurtain: WWMotionGraphicTransition.DoorCurtain
    ///   - index: 門簾的Index
    ///   - status: 門簾的動畫狀態
    func start(doorCurtain: WWMotionGraphicTransition.DoorCurtain, index: Int, status: WWMotionGraphicTransition.DoorCurtain.Status)
    
    /// 動畫結束
    /// - Parameters:
    ///   - doorCurtain: WWMotionGraphicTransition.DoorCurtain
    ///   - index: 門簾的Index
    ///   - status: 門簾的動畫狀態
    func end(doorCurtain: WWMotionGraphicTransition.DoorCurtain, index: Int, status: WWMotionGraphicTransition.DoorCurtain.Status)
}
