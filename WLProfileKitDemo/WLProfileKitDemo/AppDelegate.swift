//
//  AppDelegate.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/6.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import UIKit
import WLBaseViewController

class WLCCCC: WLStyleConfig {
    
    var host: String { return "https://zhih.ecsoi.com/" }
    
    var smspasswordCode: String { return "SMS_160571563"}
    
    var smsLoginCode: String { return "SMS_160576175" }
    
    var smsSignName: String { return "纸盒App"}
    
    var prprEncode: String { return "6d47b329735f4f6eb1cb76e4b1e13e26"}
    
    var umKey: String { return ""}
    
    var jpKey: String { return "" }
    
}

class WLAAA: WLNaviControllerConfig {
    var Back_Image: String { return "" }
    
    var Title_FontSize: CGFloat { return 20 }
    
    var Title_HEXColor: String { return "#333333" }
    
    var Background_HEXColor: String { return "#f1f1f1"}
    
    var NaviBackground_HEXColor: String { return "#ffffff" }
}



class WLWWWWW: WLWelComeConfig {
    var welcomeImgs: [String] { return ["画板 1","画板 2"] }
    
    var itemColor: String { return "#84aaf7"}
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,WLWelComeBaseDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        WLNaviController.wl_setNaviConfig(WLAAA())
        
        WLGlobalManager.creatStyleConfig(WLCCCC())
        
        _ = WLAccountCache.default.queryAccount()
        
        self.window  = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = WLWelComeBaseViewController.createWelcome(.two, config: WLWWWWW(), delegate: self)
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func onskipTap(_ vc: UIViewController) {
        
        let main = WLMainV()
        
        main.modalTransitionStyle = .flipHorizontal
        
        vc.present(main, animated: true, completion: nil)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

