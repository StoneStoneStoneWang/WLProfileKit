//
//  WLProfileViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLProfileBaseViewController {
    
    @objc (createProfileWithProfileStyle:andProfileConfig:andUserInfoConfig: andBlackStyle:andBlackConfig:andLoginStyle:andLoginConfig:andAboutConfig:andFocusStyle: andFocusConfig:)
    public static func createProfile(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,userInfoConfig: WLUserInfoConfig,blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ,aboutConfig: WLAboutConfig ,focusStyle: WLFocusListStyle,focusConfig: WLFocusListConfig) -> WLProfileBaseViewController {
        
        return WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig)
    }
}
