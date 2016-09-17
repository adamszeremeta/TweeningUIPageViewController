//
//  UIColor+ColorTweening.swift
//  TweeningUIPageViewController
//
//  Created by Adam Szeremeta on 21.06.2016.
//  Copyright © 2016 Adam Szeremeta. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     * Create new color mixed from starting and ending color and delta factor
     */
    class func colorTweenBetweenColors(_ startingColor:UIColor, endingColor:UIColor, deltaFactor:CGFloat) -> UIColor {
        
        var redStartingColor:CGFloat = 0
        var greenStartingColor:CGFloat = 0
        var blueStartingColor:CGFloat = 0
        var alphaStartingColor:CGFloat = 0
        
        var redEndingColor:CGFloat = 0
        var greenEndingColor:CGFloat = 0
        var blueEndingColor:CGFloat = 0
        var alphaEndingColor:CGFloat = 0
        
        //extract channels value
        startingColor.getRed(&redStartingColor, green: &greenStartingColor, blue: &blueStartingColor, alpha: &alphaStartingColor)
        endingColor.getRed(&redEndingColor, green: &greenEndingColor, blue: &blueEndingColor, alpha: &alphaEndingColor)
        
        //create mixed color
        let finalColorRed = redStartingColor + deltaFactor * (redEndingColor - redStartingColor)
        let finalColorGreen = greenStartingColor + deltaFactor * (greenEndingColor - greenStartingColor)
        let finalColorBlue = blueStartingColor + deltaFactor * (blueEndingColor - blueStartingColor)
        let finalAlpha = alphaStartingColor + deltaFactor * (alphaEndingColor - alphaStartingColor)
        
        return UIColor(red: finalColorRed, green: finalColorGreen, blue: finalColorBlue, alpha: finalAlpha)
    }

}
