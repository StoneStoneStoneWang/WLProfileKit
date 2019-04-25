//
//  WLGlobalManager+SOOther.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLThirdUtil.WLHudUtil
import WLBaseViewController
import WLToolsKit

extension WLGlobalManager {
    
    @objc public static func showActivity() {  WLHudUtil.showActivity() }
    
    @objc public static func barButtonItem(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero ,target: AnyObject ,action: Selector) -> UIBarButtonItem {
        
        return UIBarButtonItem.barButtonItem(imageName: imageName,highImageName: highImageName,size: size,target: target,action: action)
    }
    
    @objc public static func barButtonItem(name : String,nameColor: UIColor ,highName : String = "",highColor: UIColor,disbledName: String,disbledColor: UIColor,font: UIFont, size : CGSize = CGSize.zero ,target: AnyObject ,action: Selector) -> UIBarButtonItem {
        
        return UIBarButtonItem.barButtonItem(name: name, nameColor: nameColor, highName : highName ,highColor: highColor, disbledName: disbledName, disbledColor: disbledColor, font: font, size: size,target: target, action: action)
    }
    
    @objc public static func barButtonItem(name : String,nameColor: UIColor ,highName : String = "",highColor: UIColor, size : CGSize = CGSize.zero ,target: AnyObject ,action: Selector) -> UIBarButtonItem {
        
        return UIBarButtonItem.barButtonItem(name: name, nameColor: nameColor, highName: highName, highColor: highColor, size: size, target: target, action: action)
    }
    
    @objc static func compressImage(_ img: UIImage) -> Data {
        
        return UIImage.compressImage(img, maxLength: 50 * 1024)
    }
    @objc static func compressImage(_ img: UIImage ,maxLength: NSInteger) -> Data {
        
        return UIImage.compressImage(img, maxLength: maxLength)
    }
    @objc public static func wl_BottomLineColor() -> UIColor { return WLHEXCOLOR(hexColor: "#f1f1f1") }
    @objc public static func wl_globalHightColor() -> UIColor {  return WLHEXCOLOR_ALPHA(hexColor: WLGlobalManager.default.styleConfig.globalColor + "60") }
    @objc public static func wl_globalNormalColor() -> UIColor { return WLHEXCOLOR(hexColor: WLGlobalManager.default.styleConfig.globalColor) }
    @objc public static func wl_333333Color() -> UIColor { return WLHEXCOLOR(hexColor: "#333333") }
    @objc public static func wl_666666Color() -> UIColor { return WLHEXCOLOR(hexColor: "#666666") }
    @objc public static func wl_999999Color() -> UIColor { return WLHEXCOLOR(hexColor: "#999999") }
    
    @objc public static func wl_colorTransform(_ hex: String) -> UIColor { return WLHEXCOLOR(hexColor: hex) }
}
