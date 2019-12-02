//
//  Animator.swift
//  expressPay
//
//  Created by KWEI HESSE on 2017-02-13.
//  Copyright © 2017 expressPay. All rights reserved.
//

import UIKit
open class PullToRefreshSpinner: PullToRefresh {
    
    public convenience init(frame: CGRect, at position: Position = .top) {
        let spinner = Spinner(frame: .zero)
        
        let view = UIView(frame: frame)
        //view.backgroundColor = .red
        view.addSubview(spinner)
        spinner.frame = view.bounds
       // spinner.autoresizingMask = .flexibleWidth | .flexibleHeight
        let animator =  SpinnerAnimator(refreshView: spinner)
        self.init(refreshView: view, animator: animator, height : view.frame.size.height, position : position)
    }
}


class SpinnerAnimator: RefreshViewAnimator {

    private let spinner : Spinner
    
    init(refreshView: Spinner) {
        self.spinner = refreshView
    }
    
    func animate(_ state: RState) {
        // animate refreshView according to state
        switch state {
        case .initial:
            spinner.alpha = 0
           
            break
        case .releasing(let progress):
            spinner.alpha = 0.7 * progress
            break
        case .loading:
            spinner.alpha = 1
            spinner.startInderminateAnimation()
            break
        case .finished:
            spinner.alpha = 0
            spinner.stopInderminateAnimation()

            break
        }

    }
    fileprivate func configure() {
        
        configureBackgroundLayer()
        configureProgressLayer()
        startInderminateAnimation()
    }
    
    fileprivate var backgroundCircleLayer = CAShapeLayer()
    fileprivate var progressCircleLayer = CAShapeLayer()
    
    var indeterminateDuration: Double = 1.5
    
    fileprivate var startAngle: CGFloat {
        return CGFloat(Double.pi/2)
    }
    fileprivate var endAngle: CGFloat {
        return 5 * CGFloat(Double.pi/2)
    }
    fileprivate var arcCenter: CGPoint {
        return spinner.convert(spinner.center, to: spinner)
    }
    fileprivate var arcRadius: CGFloat {
        return (min(spinner.bounds.width, spinner.bounds.height) * 0.2) / 2
    }
    
    fileprivate func getCirclePath() -> CGPath {
        return UIBezierPath(arcCenter: arcCenter, radius: arcRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
    }
    
    
    public static var trackLineWidth: CGFloat = 2
    private var lineWidth = trackLineWidth {
        didSet {
            appearanceBackgroundLayer()
            appearanceProgressLayer()
        }
    }
    public static var trackBgColor = UIColor.clear//UIColor(colorLiteralRed: 238.0/255, green: 238.0/255, blue: 238.0/255, alpha: 1)
    private var bgColor = trackBgColor {
        didSet {
            appearanceBackgroundLayer()
        }
    }
    public static var trackPgColor = UIColor.expMango//UIColor(colorLiteralRed: 47.0/255, green: 177.0/255, blue: 254.0/255, alpha: 1)
    private var pgColor = trackPgColor {
        didSet {
            appearanceProgressLayer()
        }
    }
    
    fileprivate func configureBackgroundLayer() {
        
        backgroundCircleLayer.frame = spinner.bounds
        backgroundCircleLayer.path = getCirclePath()
        spinner.layer.addSublayer(backgroundCircleLayer)
        
        appearanceBackgroundLayer()
    }
    
    fileprivate func configureProgressLayer() {
        progressCircleLayer.frame = spinner.bounds
        progressCircleLayer.path = getCirclePath()
        spinner.layer.addSublayer(progressCircleLayer)
        appearanceProgressLayer()
    }
    
    
    // MARK: - appearance
    fileprivate func appearanceBackgroundLayer() {
        backgroundCircleLayer.lineWidth = lineWidth
        backgroundCircleLayer.fillColor = UIColor.clear.cgColor
        backgroundCircleLayer.strokeColor = bgColor.cgColor
        backgroundCircleLayer.lineCap = CAShapeLayerLineCap.round
    }
    
    fileprivate func appearanceProgressLayer() {
        progressCircleLayer.lineWidth = lineWidth
        progressCircleLayer.fillColor = UIColor.clear.cgColor
        progressCircleLayer.strokeColor = pgColor.cgColor
        progressCircleLayer.lineCap = CAShapeLayerLineCap.round
    }
    
    fileprivate func generateAnimation() -> CAAnimationGroup {
        let headAnimation = CABasicAnimation(keyPath: "strokeStart")
        headAnimation.beginTime = indeterminateDuration / 3
        headAnimation.fromValue = 0
        headAnimation.toValue = 1
        headAnimation.duration = indeterminateDuration / 1.5
        headAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tailAnimation.fromValue = 0
        tailAnimation.toValue = 1
        tailAnimation.duration = indeterminateDuration / 1.5
        tailAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = indeterminateDuration
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.animations = [headAnimation, tailAnimation]
        return groupAnimation
    }
    
    fileprivate func generateRotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.duration = indeterminateDuration
        animation.repeatCount = Float.infinity
        return animation
    }
    
    fileprivate func startInderminateAnimation() {
        progressCircleLayer.add(generateAnimation(), forKey: "strokeLineAnimation")
        spinner.layer.add(generateRotationAnimation(), forKey: "rotationAnimation")
    }
    
    fileprivate func stopInderminateAnimation() {
        progressCircleLayer.removeAllAnimations()
        spinner.layer.removeAllAnimations()
    }
}
