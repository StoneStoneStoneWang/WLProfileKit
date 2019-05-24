//
//  WLProfileViewController+Create.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation

extension WLProfileBaseViewController {
    
    @available(iOS, introduced: 10.0, deprecated: 10.0, message: "Use createProfileWithProfileStyle:andProfileConfig:andUserInfoConfig: andBlackStyle:andBlackConfig:andLoginStyle:andLoginConfig:andAboutConfig:andFocusStyle: andFocusConfig:andDelegate: instead")
    @objc (createProfileWithProfileStyle:andProfileConfig:andUserInfoConfig: andBlackStyle:andBlackConfig:andLoginStyle:andLoginConfig:andAboutConfig:andFocusStyle: andFocusConfig:)
    public static func createProfile(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,userInfoConfig: WLUserInfoConfig,blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ,aboutConfig: WLAboutConfig ,focusStyle: WLFocusListStyle,focusConfig: WLFocusListConfig) -> WLProfileBaseViewController {
        
        return WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig)
    }
    
    @objc (createProfileWithProfileStyle:andProfileConfig:andUserInfoConfig: andBlackStyle:andBlackConfig:andLoginStyle:andLoginConfig:andAboutConfig:andFocusStyle: andFocusConfig:andDelegate:)
    public static func createProfile(_ profileStyle: WLProfileStyle,profileConfig: WLProfileConfig,userInfoConfig: WLUserInfoConfig,blackStyle: WLBlackListStyle ,blackConfig: WLBlackListConfig ,loginStyle: WLLoginStyle,loginConfig: WLLoginConfig ,aboutConfig: WLAboutConfig ,focusStyle: WLFocusListStyle,focusConfig: WLFocusListConfig ,delegate: WLProfileViewControllerDelegate?) -> WLProfileBaseViewController {
        
        switch profileStyle {
        case .one: return WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
        case .two: return WLProfile2ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
        case .three: return WLProfile3ViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
            
        default: return WLProfileViewController(profileStyle, profileConfig: profileConfig, userInfoConfig: userInfoConfig, blackStyle: blackStyle, blackConfig: blackConfig, loginStyle: loginStyle, loginConfig: loginConfig, aboutConfig: aboutConfig ,focusStyle: focusStyle,focusConfig: focusConfig,delegate: delegate)
        }
    }
}
