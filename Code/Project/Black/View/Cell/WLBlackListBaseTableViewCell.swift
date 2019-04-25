//
//  WLBlackListBaseTableViewCell.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseTableView
import WLToolsKit
import Kingfisher
import SnapKit

@objc (WLBlackListBaseTableViewCell)
open class WLBlackListBaseTableViewCell: WLBaseTableViewCell {
    
    open var type: (WLBlackListBean ,WLBlackListConfig)!{
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            printLog(message: newValue)
        }
    }
}
