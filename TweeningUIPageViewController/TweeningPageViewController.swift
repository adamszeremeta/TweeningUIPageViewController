//
//  TweeningPageViewController.swift
//  TweeningUIPageViewController
//
//  Created by Adam Szeremeta on 21.06.2016.
//  Copyright © 2016 Adam Szeremeta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TweeningPageViewControllerDelegate: class {
    
    func tweeningPageViewController(_ tweeningController:TweeningPageViewController, backgroundColorForControllerBeforeController viewController:UIViewController?) -> UIColor?
    func tweeningPageViewController(_ tweeningController:TweeningPageViewController, backgroundColorForCurrentController viewController:UIViewController?) -> UIColor?
    func tweeningPageViewController(_ tweeningController:TweeningPageViewController, backgroundColorForControllerAfterController viewController:UIViewController?) -> UIColor?

    @objc optional func tweeningPageViewController(_ tweeningController:TweeningPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) -> Void
}

open class TweeningPageViewController : UIPageViewController, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    // MARK: Properties
    
    fileprivate (set) weak var currentController:UIViewController?
    
    open weak var tweeningDelegate:TweeningPageViewControllerDelegate?
    
    // MARK: Life cycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        registerForScrollViewDelegate()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //set current controller
        self.currentController = self.viewControllers?.first
        
        //set initial background color
        if let startingColor = self.tweeningDelegate?.tweeningPageViewController(self, backgroundColorForCurrentController: self.viewControllers?.first) {
            
            self.view.backgroundColor = startingColor
        }
    }
    
    // MARK: PageViewControllerDelegate
    
    open func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            
            self.currentController = self.viewControllers?.first
        }
        
        self.tweeningDelegate?.tweeningPageViewController?(self, didFinishAnimating: finished, previousViewControllers: previousViewControllers, transitionCompleted: completed)
    }
    
    // MARK: ScrollViewDelegate
    
    fileprivate func registerForScrollViewDelegate() {
        
        for view in self.view.subviews {
            
            if let scrollView = view as? UIScrollView {
                
                scrollView.delegate = self
            }
        }
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //color tweening
        self.handleScrollOffsetForColorTweening(scrollView.contentOffset.x)
    }
    
    // MARK: Color tweening

    fileprivate func handleScrollOffsetForColorTweening(_ scrollOffset:CGFloat) {
        
        //delta factor
        let startingOffset = self.view.frame.size.width
        let offset = scrollOffset - startingOffset
        let delta = offset / startingOffset
        
        //calculate tweening
        if delta > 0 {
         
            //scrolling forward
            if let startingColor = self.tweeningDelegate?.tweeningPageViewController(self, backgroundColorForCurrentController: self.currentController),
                let endingColor = self.tweeningDelegate?.tweeningPageViewController(self, backgroundColorForControllerAfterController: self.currentController) {
                
                let newColor = UIColor.colorTweenBetweenColors(startingColor, endingColor: endingColor, deltaFactor: delta)
                self.view.backgroundColor = newColor
            }
            
        } else {
            
            //scrolling backwards
            if let startingColor = self.tweeningDelegate?.tweeningPageViewController(self, backgroundColorForCurrentController: self.currentController),
                let endingColor = self.tweeningDelegate?.tweeningPageViewController(self, backgroundColorForControllerBeforeController: self.currentController) {
                
                let newColor = UIColor.colorTweenBetweenColors(startingColor, endingColor: endingColor, deltaFactor: abs(delta))
                self.view.backgroundColor = newColor
            }
        }
    }

}
