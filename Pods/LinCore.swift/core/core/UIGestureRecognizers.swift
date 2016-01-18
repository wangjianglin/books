//
//  UIGestureRecognizers.swift
//  LinCore
//
//  Created by lin on 1/22/15.
//  Copyright (c) 2015 lin. All rights reserved.
//

import Foundation
import UIKit
import LinUtil

extension UIGestureRecognizer {
    
    convenience
    public init(action:((AnyObject)->())){
        var delegateAction = EventDelegateAction(action: action);
        self.init(target:delegateAction,action:"action:");
        delegateAction.withObjectSameLifecycle = self;
    }
}