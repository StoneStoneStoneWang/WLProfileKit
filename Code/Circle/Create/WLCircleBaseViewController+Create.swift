//
//  WLCircleBaseViewController+Create.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/7.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLCircleBaseViewController {
    
    @objc (createCircleWithTag:andStyle:andConfig:andLoginStyle:andLoginConfig:andDelegate:)
    public static func createCircle(_ tag: String, style: WLCircleStyle ,config: WLCircleConfig,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig,delegate: WLCircleDelegate?) -> WLCircleBaseViewController {
        
        switch style {
        case .one: return WLCircle1ViewController(tag, style: style, config: config ,loginStyle: loginStyle,loginConfig: loginConfig,delegate: delegate)
            
        case .two: return WLCircle2ViewController(tag, style: style, config: config,loginStyle: loginStyle,loginConfig: loginConfig,delegate: delegate)
            
        default: return WLCircle1ViewController(tag, style: style, config: config,loginStyle: loginStyle,loginConfig: loginConfig,delegate: delegate)
            
        }
    }
}
