//
//  ViewController.swift
//  Gesture
//
//  Created by Lee Herbst on 9/15/17.
//  Copyright © 2017 Lee Herbst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var imageView: UIImageView!
    var pinchGesture: UIPinchGestureRecognizer!
    var image = UIImage(named: "wink.jpg")
    var lastScale: CGFloat = 1
    var currentScale: CGFloat = 1
    var startWidth: CGFloat = 0
    var flipped: Bool = false {
        didSet {
            if flipped {
                let temp = UIImage(cgImage: image!.cgImage!, scale: 1.0, orientation: .downMirrored)
                imageView.image = temp
            } else {
                imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinch(_:)))
        view.addGestureRecognizer(pinchGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startWidth = imageView.frame.size.width
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.removeGestureRecognizer(pinchGesture)
        pinchGesture = nil
    }

    @IBAction func flipImage(_ sender: Any) {
        flipped = !flipped
    }
    
    func pinch(_ pinch: UIPinchGestureRecognizer) {
        if (pinch.state == .began) {
            lastScale = 1
        }else if (pinch.state == .changed) {
            let delta = pinch.scale - lastScale
            currentScale += delta
            lastScale = pinch.scale
        }
        updateImageSize()
    }
    
    func updateImageSize() {
        for constraint in imageView.constraints {
            if constraint.identifier == "widthConstraint" {
                constraint.constant = startWidth * currentScale
                break
            }
        }
    }

}

