# WWMotionGraphicTransition

[![Swift-5.6](https://img.shields.io/badge/Swift-5.6-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-14.0](https://img.shields.io/badge/iOS-14.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![](https://img.shields.io/github/v/tag/William-Weng/WWMotionGraphicTransition) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Imitate the polygonal transition animation commonly used in movies.](https://youtu.be/jlR2J_Ztl4Y)
- [模仿影片常用的多邊形轉場動畫。](https://tw.cyberlink.com/blog/the-top-video-editors/982/motion-graphics)

![WWMotionGraphicTransition](./Example.gif)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWMotionGraphicTransition.git", .upToNextMajor(from: "1.1.3"))
]
```

### 可用效果 - Effect
|效果|說明|
|-|-|
|DoorCurtain|像單片門簾的開關過場動畫|
|FanBlade|像電風扇葉片的旋轉過場動畫|

### 可用函式 - Function
|函式|說明|
|-|-|
|build()|建立實體|
|start(duration:direction:count:colors:)|動畫開始|
|end(duration:)|動畫結束|

### Example
```swift
import UIKit
import WWMotionGraphicTransition

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
        
        doorCurtain.start(duration: duration, direction: .right, count: count, colors: colors)
    }
    
    @IBAction func fanBladeEffect(_ sender: UIBarButtonItem) {
        
        fanBlade = WWMotionGraphicTransition.FanBlade.build(frame: faceImageView.bounds)
        fanBlade.delegate = self
        faceImageView.addSubview(fanBlade)
        
        fanBlade.start(duration: duration, direction: .right, count: count, colors: colors)
    }
}

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
```
