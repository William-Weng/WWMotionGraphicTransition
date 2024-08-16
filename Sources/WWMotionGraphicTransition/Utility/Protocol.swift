//
//  Protocol.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/13.
//

import UIKit

/// MARK: - 單片門簾效果的Delegate
public protocol WWMotionGraphicTransitionDelegate: AnyObject {
    
    /// 動畫開始
    /// - Parameters:
    ///   - effectView: UIView
    ///   - number: 編號
    ///   - status: 動畫狀態
    func start(effectView: UIView, number: Int, status: WWMotionGraphicTransition.Status)
    
    /// 動畫結束
    /// - Parameters:
    ///   - effectView: UIView
    ///   - number: 編號
    ///   - status: 動畫狀態
    func end(effectView: UIView, number: Int, status: WWMotionGraphicTransition.Status)
}
