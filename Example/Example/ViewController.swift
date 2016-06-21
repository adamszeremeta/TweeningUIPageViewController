//
//  ViewController.swift
//  Example
//
//  Created by Adam Szeremeta on 21.06.2016.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    let backgroundColors = [
        
        UIColor.redColor(),
        UIColor.blueColor(),
        UIColor.greenColor(),
        UIColor.orangeColor()
    ]
    
    private var pageViewController:TweeningUIPageViewController!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUIPageViewControllerToViewHierarchy()
        
        //add first controller to pager
        let firstController = self.getControllerForIndex(0)
        self.pageViewController.setViewControllers([firstController!], direction: .Forward, animated: false, completion: nil)
    }

    // MARK: UIPageViewController

    private func addUIPageViewControllerToViewHierarchy() {
        
        self.pageViewController = TweeningUIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(self.pageViewController.view, atIndex: 0)
        
        let views = ["subview": self.pageViewController.view]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? PageViewController {
            
            return self.getControllerForIndex(controller.controllerIndex - 1)
        }
        
        return self.getControllerForIndex(0)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? PageViewController {
            
            return self.getControllerForIndex(controller.controllerIndex + 1)
        }
        
        return self.getControllerForIndex(0)
    }

    // MARK: Helpers
    
    private func getControllerForIndex(index:Int) -> PageViewController? {
        
        if index < 0 || index >= self.backgroundColors.count {
            
            return nil
        }
        
        let controller = PageViewController()
        controller.controllerIndex = index
        
        return controller
    }

}

