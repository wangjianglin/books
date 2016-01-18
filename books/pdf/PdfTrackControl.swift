//
//  PdfTrackControl.swift
//  reader
//
//  Created by lin on 14-9-8.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit

class PdfTrackControl:UIControl
{
    var value:CGFloat = 0;

    override init(frame:CGRect)
    {
        super.init(frame:frame);
        self.autoresizesSubviews = false;
        self.userInteractionEnabled = true;
        self.contentMode = UIViewContentMode.Redraw;
        self.autoresizingMask = UIViewAutoresizing.None;
        self.backgroundColor = UIColor.clearColor();
        self.exclusiveTouch = true;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func limitValue(valueX:CGFloat)->CGFloat
    {
        let minX:CGFloat = self.bounds.origin.x; // 0.0f;
        let maxX:CGFloat = (self.bounds.size.width - 1.0);
    
        var result:CGFloat = valueX;
        if valueX < minX {
            result = minX;
        }// Minimum X
        if valueX > maxX {
            result = maxX;
        } // Maximum X
    
        return result;
    }

    
    override func beginTrackingWithTouch(touch:UITouch,withEvent:UIEvent?)->Bool
    {
        let point:CGPoint = touch.locationInView(self); // Touch point
    
        self.value = self.limitValue(point.x); // Limit control value
    
        return true;
    }
    
    override func continueTrackingWithTouch(touch:UITouch,withEvent:UIEvent?)->Bool
    {
        if (self.touchInside == true) // Only if inside the control
        {
            let point:CGPoint = touch.locationInView(touch.view); // Touch point
        
            let x:CGFloat = self.limitValue(point.x); // Potential new control value
            
            if (x != self.value) // Only if the new value has changed since the last time
            {
                self.value = x;
                self.sendActionsForControlEvents(UIControlEvents.ValueChanged);
            }
        }
    
        return true;
    }
    
    override func endTrackingWithTouch(touch:UITouch?,withEvent:UIEvent?)
    {
        let point:CGPoint = touch!.locationInView(self); // Touch point
    
        self.value = self.limitValue(point.x); // Limit control value
    }

}
