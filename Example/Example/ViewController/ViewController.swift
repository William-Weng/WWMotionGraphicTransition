//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/8/13.
//

import UIKit
import WWMotionGraphicTransition

// MARK: - ViewController
final class ViewController: UIViewController {

    @IBOutlet weak var faceImageView: UIImageView!
    
    private let count = 5
    private let duration: TimeInterval = 0.5
    private let colors: [UIColor] = [.red, .yellow, .blue, .green, .orange]

    private var doorCurtain: WWMotionGraphicTransition.DoorCurtain!
    private var fanBlade: WWMotionGraphicTransition.FanBlade!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doorCurtainEffect(_ sender: UIBarButtonItem) {
        
        doorCurtain = WWMotionGraphicTransition.DoorCurtain.build(frame: faceImageView.bounds)
        doorCurtain.delegate = self
        faceImageView.addSubview(doorCurtain)
        
        doorCurtain.start(duration: duration, count: count, colors: colors)
    }
    
    @IBAction func fanBladeEffect(_ sender: UIBarButtonItem) {
        
        fanBlade = WWMotionGraphicTransition.FanBlade.build(frame: faceImageView.bounds)
        fanBlade.delegate = self
        faceImageView.addSubview(fanBlade)
        
        fanBlade.start(duration: duration, count: count, colors: colors)
    }
}

// MARK: - WWMotionGraphicTransitionDelegate
extension ViewController: WWMotionGraphicTransitionDelegate {
    
    func start(effectView: UIView, number: Int, status: WWMotionGraphicTransition.Status) {
        
        faceImageView.image = UIImage(named: "Face1")
                
        if (number < count) { return }
        if (status != .end) { return }
        
        faceImageView.image = UIImage(named: "Face2")
        
        if effectView is WWMotionGraphicTransition.DoorCurtain { doorCurtain.end(duration: duration); return }
        if effectView is WWMotionGraphicTransition.FanBlade { fanBlade.end(duration: duration); return }
    }
    
    func end(effectView: UIView, number: Int, status: WWMotionGraphicTransition.Status) {
        
        if (number < count) { return }
        if (status != .end) { return }
        
        if effectView is WWMotionGraphicTransition.DoorCurtain { doorCurtain.removeFromSuperview(); return }
        if effectView is WWMotionGraphicTransition.FanBlade { fanBlade.removeFromSuperview(); return}
    }
}
