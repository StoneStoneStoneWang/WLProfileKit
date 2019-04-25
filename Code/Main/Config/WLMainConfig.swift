//
//  WLMainConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public let wl_main_margin: CGFloat = 15

@objc public protocol WLMainStyleConfig {
    
    var mediaCovor: String { get }
    
    var mediaStyle: String { get }
    
    var globalColor: String { get }
    
    var watchIcon: String { get }
    
    var commentIcon: String { get }
    
    var funNormalIcon: String { get }
    
    var funSelectedIcon: String { get }
}
