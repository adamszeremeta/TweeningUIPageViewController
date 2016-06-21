//
//  TweeningUIPageViewController.swift
//  Example
//
//  Created by Adam Szeremeta on 21.06.2016.
//  Copyright © 2016 Example. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TweeningUIPageViewControllerDelegate: class {
    
    func tweeningUIPageViewController(tweeningController:TweeningUIPageViewController, backgroundColorForControllerBeforeController viewController:UIViewController?) -> UIColor?
    func tweeningUIPageViewController(tweeningController:TweeningUIPageViewController, backgroundColorForCurrentController viewController:UIViewController?) -> UIColor?
    func tweeningUIPageViewController(tweeningController:TweeningUIPageViewController, backgroundColorForControllerAfterController viewController:UIViewController?) -> UIColor?

    optional func tweeningUIPageViewController(tweeningController:TweeningUIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) -> Void
}

class TweeningUIPageViewController : UIPageViewController, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    // MARK: Properties
    
    private (set) weak var currentController:UIViewController?
    
    weak var tweeningDelegate:TweeningUIPageViewControllerDelegate?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        registerForUIScrollViewDelegate()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //set current controller
        self.currentController = self.viewControllers?.first
        
        //set initial background color
        if let startingColor = self.tweeningDelegate?.tweeningUIPageViewController(self, backgroundColorForCurrentController: self.viewControllers?.first) {
            
            self.view.backgroundColor = startingColor
        }
    }
    
    // MARK: UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            
            self.currentController = self.viewControllers?.first
        }
        
        self.tweeningDelegate?.tweeningUIPageViewController?(self, didFinishAnimating: finished, previousViewControllers: previousViewControllers, transitionCompleted: completed)
    }
    
    // MARK: UIScrollViewDelegate
    
    private func registerForUIScrollViewDelegate() {
        
        for view in self.view.subviews {
            
            if let scrollView = view as? UIScrollView {
                
                scrollView.delegate = self
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //color tweening
        self.handleScrollOffsetForColorTweening(scrollView.contentOffset.x)
    }
    
    // MARK: Color tweening

    private func handleScrollOffsetForColorTweening(scrollOffset:CGFloat) {
        
        //delta factor
        let startingOffset = self.view.frame.size.width
        let offset = scrollOffset - startingOffset
        let delta = offset / startingOffset
        
        //calculate tweening
        if delta > 0 {
         
            //scrolling forward
            if let startingColor = self.tweeningDelegate?.tweeningUIPageViewController(self, backgroundColorForCurrentController: self.currentController),
                let endingColor = self.tweeningDelegate?.tweeningUIPageViewController(self, backgroundColorForControllerAfterController: self.currentController) {
                
                let newColor = UIColor.colorTweenBetweenColors(startingColor, endingColor: endingColor, deltaFactor: delta)
                self.view.backgroundColor = newColor
            }
            
        } else {
            
            //scrolling backwards
            if let startingColor = self.tweeningDelegate?.tweeningUIPageViewController(self, backgroundColorForCurrentController: self.currentController),
                let endingColor = self.tweeningDelegate?.tweeningUIPageViewController(self, backgroundColorForControllerBeforeController: self.currentController) {
                
                let newColor = UIColor.colorTweenBetweenColors(startingColor, endingColor: endingColor, deltaFactor: abs(delta))
                self.view.backgroundColor = newColor
            }
        }
    }

}