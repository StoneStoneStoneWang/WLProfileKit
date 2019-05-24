//
//  WLMainV.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLBaseViewController
import WLToolsKit
import ObjectMapper


class WLLLLLL: WLLoginConfig ,WLProfileConfig{
    var circleIcon: String { return "" }
    
    var ciecleName: String { return "我的发布" }
    
    var defaultIcon: String  { return "" }
    
    var userInfoIcon: String  { return "" }
    
    var aboutIcon: String  { return "" }
    
    var settingIcon: String  { return "" }
    
    var contactUsIcon: String  { return "" }
    
    var pravicyIcon: String  { return "" }
    
    var focusIcon: String  { return "" }
    
    var phoneNum: String { return "" }
    
    var logo: String { return "" }
    
    var itemColor: String { return "#84aaf7" }
    
    var phoneIcon: String { return "" }
    
    var vcodeIcon: String { return "" }
    
    var passwordIcon: String { return "" }
    
    var passwordItemNIcon: String { return "" }
    
    var passwordItemSIcon: String { return "" }
    
    var backIcon: String { return "" }
    
    var goIcon: String { return "" }
}

class WLUUUUUU: WLUserInfoConfig ,WLBlackListConfig ,WLFocusListConfig ,WLAboutConfig{
    var logo: String {  return "" }
    
    var itemColor: String {  return "#84aaf7" }
    
    var backIcon: String {  return "" }
    
    var defaultIcon: String {  return "" }
    
}

class WLMainV: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = WLProfileBaseViewController.createProfile(.two ,profileConfig: WLLLLLL(), userInfoConfig:  WLUUUUUU(), blackStyle: .one, blackConfig: WLUUUUUU(), loginStyle: .five, loginConfig: WLLLLLL(), aboutConfig: WLUUUUUU(), focusStyle: .one, focusConfig: WLUUUUUU(),delegate: nil)
        
        addChildVC(childVC: profile, title: "我的", fontSize: 12, titleColor: WLHEXCOLOR(hexColor: "#666666"), highColor: WLHEXCOLOR(hexColor: "#84aaf7"), imageName: "", selectedImageName: "")
    }
    func onPublishSucc(_ vc: UIViewController ,pubBean: [String: Any]) {
        
        
    }
}
