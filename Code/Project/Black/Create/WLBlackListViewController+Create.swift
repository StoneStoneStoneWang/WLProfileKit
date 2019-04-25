//
//  WLBlackListViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLBlackListViewController {
    
    @objc (createBlackListWithStyle:andConfig:)
    public static func createBlackList(_ style: WLBlackListStyle ,config: WLBlackListConfig) -> WLBlackListViewController {
        
        switch style {
        case .one: return WLBlackListViewController(style, config: config)
            
        }
    }
}
