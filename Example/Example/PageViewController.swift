//
//  PageViewController.swift
//  Example
//
//  Created by Adam Szeremeta on 21.06.2016.
//  Copyright © 2016 Example. All rights reserved.
//

import Foundation
import UIKit

class PageViewController : UIViewController {
    
    @IBOutlet weak var indexLabel: UILabel!
    
    //view pager controller index
    var controllerIndex:Int = 0
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indexLabel.text = "\(self.controllerIndex)"
    }

}