//
//  ViewController.swift
//  Example
//
//  Created by Adam Szeremeta on 21.06.2016.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit
import TweeningUIPageViewController

class ViewController: UIViewController, UIPageViewControllerDataSource, TweeningPageViewControllerDelegate {

    let backgroundColors = [
        
        UIColor.red,
        UIColor.blue,
        UIColor.green,
        UIColor.orange
    ]
    
    fileprivate var pageViewController:TweeningPageViewController!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUIPageViewControllerToViewHierarchy()
        
        //add first controller to pager
        let firstController = self.getControllerForIndex(0)
        self.pageViewController.setViewControllers([firstController!], direction: .forward, animated: false, completion: nil)
    }

    // MARK: UIPageViewController

    fileprivate func addUIPageViewControllerToViewHierarchy() {
        
        self.pageViewController = TweeningPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.tweeningDelegate = self
        
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(self.pageViewController.view, at: 0)
        
        let views:[String: UIView] = ["subview": self.pageViewController.view]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? PageViewController {
            
            return self.getControllerForIndex(controller.controllerIndex - 1)
        }
        
        return self.getControllerForIndex(0)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? PageViewController {
            
            return self.getControllerForIndex(controller.controllerIndex + 1)
        }
        
        return self.getControllerForIndex(0)
    }
    
    // MARK: TweeningUIPageViewControllerDelegate
    
    func tweeningPageViewController(_ tweeningController:TweeningPageViewController, backgroundColorForControllerBeforeController viewController:UIViewController?) -> UIColor? {
        
        if let pageController = viewController as? PageViewController {
            
            let previousIndex = pageController.controllerIndex - 1
            if previousIndex >= 0 && previousIndex < self.backgroundColors.count {
                
                return self.backgroundColors[previousIndex]
            }
        }
        
        return nil
    }
    
    func tweeningPageViewController(_ tweeningController:TweeningPageViewController, backgroundColorForCurrentController viewController:UIViewController?) -> UIColor? {
        
        if let pageController = viewController as? PageViewController {
            
            return self.backgroundColors[pageController.controllerIndex]
        }
        
        return nil
    }
    
    func tweeningPageViewController(_ tweeningController:TweeningPageViewController, backgroundColorForControllerAfterController viewController:UIViewController?) -> UIColor? {
        
        if let pageController = viewController as? PageViewController {
            
            let nextIndex = pageController.controllerIndex + 1
            if nextIndex >= 0 && nextIndex < self.backgroundColors.count {
                
                return self.backgroundColors[nextIndex]
            }
        }
        
        return nil
    }

    // MARK: Helpers
    
    fileprivate func getControllerForIndex(_ index:Int) -> PageViewController? {
        
        if index < 0 || index >= self.backgroundColors.count {
            
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))
        
        let controller = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        controller.controllerIndex = index
        
        return controller
    }

}

