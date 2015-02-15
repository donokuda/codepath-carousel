//
//  WelcomeScreensViewController.swift
//  carousel
//
//  Created by Don Okuda on 2/14/15.
//  Copyright (c) 2015 donokuda. All rights reserved.
//

import UIKit

class WelcomeScreensViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var backupPromptView: UIView!
    @IBOutlet weak var welcomeScreenImage1: UIImageView!
    @IBOutlet weak var welcomeScrollView: UIScrollView!
    @IBOutlet weak var welcomePageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeScrollView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var size = welcomeScrollView.bounds.size
        size.width *= 4
        welcomeScrollView.contentSize = size
        backupPromptView.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page: Int = Int(round(welcomeScrollView.contentOffset.x / welcomeScrollView.bounds.size.width))
        welcomePageControl.currentPage = page
        
        UIView.animateWithDuration(1.0, animations: {
            if (self.welcomePageControl.currentPage == 3) {
                self.welcomePageControl.alpha = 0
                self.backupPromptView.alpha = 1
            } else {
                self.welcomePageControl.alpha = 1
                self.backupPromptView.alpha = 0
            }
        })
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
