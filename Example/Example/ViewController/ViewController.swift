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
    private let colors: [UIColor] = [.red, .yellow, .green, .blue, .orange]
    private let duration: TimeInterval = 0.5
    
    private var doorCurtain: WWMotionGraphicTransition.DoorCurtain!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doorCurtainEffect(_ sender: UIBarButtonItem) {

        doorCurtain = WWMotionGraphicTransition.DoorCurtain.maker(frame: faceImageView.bounds)
        doorCurtain.delegate = self
        faceImageView.addSubview(doorCurtain)

        doorCurtain.start(duration: duration, count: count, colors: colors)
    }
}

// MARK: - WWMotionGraphicTransitionDoorCurtainDelegate
extension ViewController: WWMotionGraphicTransitionDoorCurtainDelegate {
    
    func start(doorCurtain: WWMotionGraphicTransition.DoorCurtain, index: Int, status: WWMotionGraphicTransition.DoorCurtain.Status) {
        
        faceImageView.image = UIImage(named: "Face1")
        
        if ((index + 1) < count) { return }
        if (status != .end) { return }
        
        faceImageView.image = UIImage(named: "Face2")
        doorCurtain.end(duration: duration)
    }
    
    func end(doorCurtain: WWMotionGraphicTransition.DoorCurtain, index: Int, status: WWMotionGraphicTransition.DoorCurtain.Status) {
        
        if ((index + 1) < count) { return }
        if (status != .end) { return }
        
        doorCurtain.removeFromSuperview()
    }
}
