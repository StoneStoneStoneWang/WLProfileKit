//
//  WLNameUpdateViewController.swift
//  WLContact
//
//  Created by three stone 王 on 2018/12/17.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import UIKit
import WLToolsKit
@objc (WLNameUpdateViewController)
public final class WLNameUpdateViewController: WLNameUpdateBaseViewController {
    
    override public func addOwnSubViews() {
        
        view.addSubview(name)
    }
    override public func configOwnSubViews() {
        
        name.frame = CGRect(x: 0, y: WL_TOP_LAYOUT_GUARD + 10, width: view.bounds.width, height: 55)
        
        name.text = nickname.value
        
        name.set_backgroundColor(.white)
    }
    public override func configNaviItem() {
        super.configNaviItem()
        
        if let config = config {
            
            completeItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .normal)
            
            completeItem.setTitleColor(WLHEXCOLOR(hexColor: config.itemColor), for: .highlighted)
            
            completeItem.setTitleColor(WLHEXCOLOR_ALPHA(hexColor: config.itemColor + "60"), for: .disabled)
            
        }
    }
}


