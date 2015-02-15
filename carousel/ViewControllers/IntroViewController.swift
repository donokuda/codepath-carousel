//
//  IntroViewController.swift
//  carousel
//
//  Created by Don Okuda on 2/14/15.
//  Copyright (c) 2015 donokuda. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {
    
    var imageViews: [UIView] = []
    var imageViewsHorizontalOffset = [-20, 50, -40, 0, -130, 0]
    var imageViewsVerticalOffset = [-400, -160, -260, -260, -300, -320]
    var imageViewsScaleOffset = [0.789473684, 1.6, 1.6, 1.6, 1.6, 1.6]
    var imageViewsRotateOffset = [-10,-10,10,10,10,-10]

    @IBOutlet weak var introImageHouse: UIImageView!
    @IBOutlet weak var introImageDeer: UIImageView!
    @IBOutlet weak var introImageFishing: UIImageView!
    @IBOutlet weak var introImageLake: UIImageView!
    @IBOutlet weak var introImageSoccerDog: UIImageView!
    @IBOutlet weak var introImageOrange: UIImageView!
    @IBOutlet weak var introImage: UIView!
    @IBOutlet weak var introScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViews = [introImageOrange, introImageDeer, introImageFishing, introImageLake, introImageHouse, introImageSoccerDog]
        
        introScrollView.delegate = self
        introScrollView.contentSize = introImage.bounds.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var progress = 1 - (introScrollView.contentOffset.y / introScrollView.bounds.size.height)
        for (viewIndex, view) in enumerate(imageViews) {
            let targetOffset = CGFloat(imageViewsVerticalOffset[viewIndex])
            var currentX =  CGFloat(imageViewsHorizontalOffset[viewIndex]) * progress
            var currentY = targetOffset * progress
            var currentScale = (CGFloat(imageViewsScaleOffset[viewIndex] - 1) * progress) + 1
            var currentRotate = CGFloat(imageViewsRotateOffset[viewIndex]) * progress
            view.transform = CGAffineTransformMakeTranslation(currentX, currentY)
            view.transform = CGAffineTransformConcat(view.transform, CGAffineTransformMakeScale(currentScale, currentScale))
            view.transform = CGAffineTransformConcat(view.transform, CGAffineTransformMakeDegreeRotation(currentRotate))
        }
        
        if (introScrollView.contentOffset.y >= 568) {
            println("page 2")
        } else {
            println("page 1")
        }
    }
    
    @IBAction func dismiss(segue: UIStoryboardSegue) {
        introScrollView.contentOffset.y = 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
