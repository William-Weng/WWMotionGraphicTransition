//
//  Constant.swift
//  WWMotionGraphicTransition
//
//  Created by William.Weng on 2024/8/16.
//

import UIKit

// MARK: - typealias
extension WWMotionGraphicTransition.Constant {
    typealias BasicAnimationInformation = (animation: CABasicAnimation, keyPath: WWMotionGraphicTransition.Constant.AnimationKeyPath)     // Basic動畫資訊
}

// MARK: - enum
extension WWMotionGraphicTransition.Constant {
    
    /// [動畫路徑 (KeyPath)](https://stackoverflow.com/questions/44230796/what-is-the-full-keypath-list-for-cabasicanimation)
    enum AnimationKeyPath: String {
        
        case strokeEnd = "strokeEnd"
        case position = "position"
        case bounds = "bounds"
        case width = "bounds.size.width"
        case height = "bounds.size.height"
        case locations = "locations"
        case contents = "contents"
        case opacity = "opacity"
        case backgroundColor = "backgroundColor"
        case scale = "transform.scale"
        case scaleXY = "transform.scale.xy"
        case translationX = "transform.translation.x"
        case translationY = "transform.translation.y"
        case translationZ = "transform.translation.z"
        case rotationX = "transform.rotation.x"
        case rotationY = "transform.rotation.y"
        case rotationZ = "transform.rotation.z"
        case centerX = "center.x"
        case centerY = "center.y"
        case shimmer = "shimmer"
        case selectionBounds = "SelectionBounds"
    }
}
