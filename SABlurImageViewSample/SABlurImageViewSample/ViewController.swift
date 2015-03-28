//
//  ViewController.swift
//  SABlurImageViewSample
//
//  Created by 鈴木大貴 on 2015/03/27.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider?
    @IBOutlet weak var animationButton: UIButton?
    
    private var imageView: SABlurImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animationButton?.addTarget(self, action: "didTapAnimationButton:", forControlEvents: .TouchUpInside)
        slider?.addTarget(self, action: "didChangeSliderValue:", forControlEvents: .ValueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 1.0)
        self.view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageView = SABlurImageView(image: image)
        if let slider = slider {
            imageView.configrationForBlurAnimation()
            view.insertSubview(imageView, belowSubview: slider)
        } else if let button = animationButton {
            imageView.configrationForBlurAnimation()
            view.insertSubview(imageView, belowSubview: button)
        } else {
            imageView.addBlurEffect(50, times: 3)
            view.addSubview(imageView)
        }
        self.imageView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapAnimationButton(sender: UIButton) {
        imageView?.startBlurAnimation(duration: 2.0)
    }
    
    func didChangeSliderValue(sender: UISlider) {
        imageView?.blur(sender.value)
    }
}
