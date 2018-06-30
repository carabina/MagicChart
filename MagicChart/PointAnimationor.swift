//
//  PointAnimationor.swift
//  MagicChartDemo
//
//  Created by wen on 2018/5/10.
//  Copyright © 2018年 wenfeng. All rights reserved.
//

import UIKit

class PointAnimator {
    
    var link: CADisplayLink?
    var sourceLayer: CAShapeLayer?
    var points: [CGPoint] = []
    var layers: [CAShapeLayer] = []
    var duration: TimeInterval = 0
    var nextIndex: Int = 0
    var completion = false
    
    init(source: CAShapeLayer, duration: TimeInterval, points: [CGPoint], layers: [CAShapeLayer]) {
        self.sourceLayer = source
        self.duration = duration
        self.points = points
        self.layers = layers
//        print(points)
        for layer in layers {
            layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            layer.opacity = 0
        }
    }
    
    func start() {
        link = CADisplayLink.init(target: self, selector: #selector(self.handleDisplayLink))
        link?.add(to: .current, forMode: .commonModes)

        Timer.scheduledTimer(withTimeInterval: duration + 1, repeats: false) { (timer) in
            self.stop()
            timer.invalidate()
        }
    }
    
    func stop(completion: Bool = true) {
        self.completion = completion
        link?.invalidate()
    }
    
    @objc
    func handleDisplayLink() {
        if let width = sourceLayer?.presentation()?.path?.boundingBoxOfPath.width {
//            print(width)
            displayLayerIfNeed(width: width)
        }
    }
    
    func displayLayerIfNeed(width: CGFloat) {
        for index in nextIndex..<points.count {
            if width >= points[index].x {
                displayLayer(layer: layers[index])
                nextIndex = index + 1
                
                if nextIndex >= points.count {
                    stop()
                }
                
                break
            }
        }
    }
    
    func displayLayer(layer: CAShapeLayer) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 2, y: 2))
        transformAnimation.toValue = CATransform3DIdentity
        
        let group = CAAnimationGroup()
        
        group.animations = [opacityAnimation, transformAnimation]
        
        group.duration = 0.4
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        
        layer.add(group, forKey: "display")
    }
}


