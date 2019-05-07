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

class WLPPPPP: WLPublishConfig ,WLProfileConfig ,WLUserInfoConfig ,WLBlackListConfig ,WLFocusListConfig ,WLAboutConfig{
    var backIcon: String { return "" }
    
    var logo: String { return "" }
    
    var defaultIcon: String { return "" }
    
    var userInfoIcon: String { return "" }
    
    var aboutIcon: String { return "" }
    
    var settingIcon: String { return "" }
    
    var contactUsIcon: String { return "" }
    
    var pravicyIcon: String { return "" }
    
    var focusIcon: String { return "" }
    
    var phoneNum: String { return "" }
    
    var itemColor: String { return "#84aaf7" }
    
    var textIcon: String { return "" }
    
    var imageIcon: String { return "" }
    
    var videoIcon: String { return "" }
    
    var broadIcon: String { return "" }
}

class WLLLLLL: WLLoginConfig {
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

class WLMainV: UITabBarController, WLPublishDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publish = WLPublishTableBaseViewController.createPublish("", style: .mix, config: WLPPPPP(), delegate: self)
        
        addChildVC(childVC: publish, title: "发布", fontSize: 12, titleColor: WLHEXCOLOR(hexColor: "#666666"), highColor: WLHEXCOLOR(hexColor: "#84aaf7"), imageName: "", selectedImageName: "")
        
        let a = publish.complete
        
        a.subscribe(onNext: { (a) in
            
            printLog(message: a)
            
        }).disposed(by: publish.disposed)
        
        let profile = WLProfileBaseViewController.createProfile(.one ,profileConfig: WLPPPPP(), userInfoConfig:  WLPPPPP(), blackStyle: .one, blackConfig: WLPPPPP(), loginStyle: .five, loginConfig: WLLLLLL(), aboutConfig: WLPPPPP(), focusStyle: .one, focusConfig: WLPPPPP())
        
        addChildVC(childVC: profile, title: "我的", fontSize: 12, titleColor: WLHEXCOLOR(hexColor: "#666666"), highColor: WLHEXCOLOR(hexColor: "#84aaf7"), imageName: "", selectedImageName: "")
    }
    func onPublishSucc(_ vc: UIViewController ,pubBean: WLProjectBean) {
        
        
    }
}
