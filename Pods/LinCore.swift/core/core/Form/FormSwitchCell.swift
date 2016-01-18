//
//  FormSwitchCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 21/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public class FormSwitchCell: FormBaseCell {

    /// MARK: Properties
    
    let switchView = UISwitch()
    
    /// MARK: FormBaseCell
    
    override public func configure() {
        super.configure()
        selectionStyle = .None
        accessoryView = switchView
        switchView.addTarget(self, action: "valueChanged:", forControlEvents: .ValueChanged)
        //switchView.enabled = false;
    }
    
    override public func update() {
        super.update()
        textLabel?.text = rowDescriptor.title
        switchView.enabled = rowDescriptor.enabled;
        
        if rowDescriptor.value != nil {
            switchView.on = rowDescriptor.value as! Bool
        }
        else {
            switchView.on = false
        }
    }
    
    /// MARK: Actions
    
    func valueChanged(_: UISwitch) {
        rowDescriptor.value = switchView.on as Bool
    }
}

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
