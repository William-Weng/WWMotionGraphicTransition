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
    
    private let duration: TimeInterval = 0.5
    private let colors: [UIColor] = [.red, .yellow, .blue, .green, .orange]

    private var count: Int { colors.count }
    private var doorCurtain: WWMotionGraphicTransition.DoorCurtain!
    private var fanBlade: WWMotionGraphicTransition.FanBlade!
    private var louver: WWMotionGraphicTransition.Louver!

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func doorCurtainEffect(_ sender: UIButton) {
        faceImageView.addSubview(doorCurtain)
        doorCurtain.start(count: count, colors: colors, duration: duration)
    }
    
    @IBAction func fanBladeEffect(_ sender: UIButton) {
        faceImageView.addSubview(fanBlade)
        fanBlade.start(count: count, colors: colors, duration: duration)
    }
    
    @IBAction func louverEffect(_ sender: UIButton) {
        faceImageView.addSubview(louver)
        louver.start(count: count, colors: colors, duration: duration)
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
        if effectView is WWMotionGraphicTransition.Louver { louver.end(duration: duration); return }
    }
    
    func end(effectView: UIView, number: Int, status: WWMotionGraphicTransition.Status) {
        
        if (number < count) { return }
        if (status != .end) { return }
        
        if effectView is WWMotionGraphicTransition.DoorCurtain { doorCurtain.removeFromSuperview(); return }
        if effectView is WWMotionGraphicTransition.FanBlade { fanBlade.removeFromSuperview(); return}
        if effectView is WWMotionGraphicTransition.Louver { louver.removeFromSuperview(); return}
    }
}

// MARK: - 小工具
private extension ViewController {
    
    /// 初始化設定
    func initSetting() {
        
        doorCurtain = WWMotionGraphicTransition.DoorCurtain.build(frame: faceImageView.bounds)
        doorCurtain.delegate = self

        fanBlade = WWMotionGraphicTransition.FanBlade.build(frame: faceImageView.bounds)
        fanBlade.delegate = self
        
        louver = WWMotionGraphicTransition.Louver(frame: faceImageView.bounds)
        louver.delegate = self
    }
}
