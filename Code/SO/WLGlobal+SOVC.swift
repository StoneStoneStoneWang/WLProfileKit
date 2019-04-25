//
//  WLGlobalManager+SOVC.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewController

extension WLGlobalManager {
    
//    // 创建欢迎vc
//    @objc (creatWelcomViewControllerWithDelegate:)
//    public static func creatWelcomViewController(_ delegate: WLWelComeBaseDelegate) -> WLWelCome1ViewController {
//        
//        let vc = WLWelCome1ViewController(.one)
//        
//        vc.mDelegate = delegate
//        
//        return vc
//    }
    // 创建个人中心
    @objc (createProfileNavi)
    public static func createProfileNavi() -> WLNaviController {
        
        let vc = WLProfileViewController()
        
        NotificationCenter.default.addObserver(vc, selector: #selector(WLProfileViewController.tokenInvalid), name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil)
        
        return WLNaviController(rootViewController: vc)
    }
    @objc (createProfileNaviWithDelegate:)
    public static func createProfileNavi(_ delegate: WLProfileViewControllerDelegate ) -> WLNaviController {
        
        let vc = WLProfileViewController()
        
        NotificationCenter.default.addObserver(vc, selector: #selector(WLProfileViewController.tokenInvalid), name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil)
        
        vc.mDelegate = delegate
        
        return WLNaviController(rootViewController: vc)
    }
    @objc (createProfileWithDelegate:)
    public static func createProfile(_ delegate: WLProfileViewControllerDelegate) -> WLProfileViewController {
        
        let vc = WLProfileViewController()
        
        NotificationCenter.default.addObserver(vc, selector: #selector(WLProfileViewController.tokenInvalid), name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil)
        
        vc.mDelegate = delegate
        
        return vc
    }
    @objc (createProfile)
    public static func createProfile() -> WLProfileViewController {
        
        let vc = WLProfileViewController()
        
        NotificationCenter.default.addObserver(vc, selector: #selector(WLProfileViewController.tokenInvalid), name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil)
        
        return vc
    }
    // 创建登录
    @objc (createLogin)
    public static func createLogin() -> WLLoginViewController { return WLLoginViewController()  }
    @objc (createUserInfo)
    public static func createUserInfo() -> WLUserInfoViewController { return WLUserInfoViewController() }
    @objc (createPravicy)
    public static func createPravicy() -> WLProtocolViewController { return WLProtocolViewController() }
    @objc (createAbout)
    public static func createAbout() -> WLAboutViewController { return WLAboutViewController() }
    @objc (createSetting)
    public static func createSetting() -> WLSettingViewController { return WLSettingViewController() }
    @objc (createSomeVCWithVC:)
    public static func createSomeVC(_ vc: UIViewController) -> WLNaviController { return WLNaviController(rootViewController: vc) }
    
    public static func addChildVC(_ tabbar: UITabBarController,childVC: UIViewController, title: String = "" ,fontSize: CGFloat,titleColor: UIColor ,highColor: UIColor,imageName: String = "" ,selectedImageName: String = "" ) {
        
        tabbar.addChildVC(childVC: childVC, fontSize: fontSize, titleColor: titleColor, highColor: highColor ,imageName: imageName ,selectedImageName: selectedImageName)
    }
    
    //    @objc public static func createFocus() -> WLFocusViewController { return WLFocusViewController() }
    
}
