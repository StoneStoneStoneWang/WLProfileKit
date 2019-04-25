//
//  WLConfig.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/3.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public let wl_margin: CGFloat = 15

@objc public protocol WLStyleConfig {
    /* logo */
    //    var logo: String { get }
    /* 全局颜色 */
    /* 风格4 代表的是按钮或者文字的主颜色 */
    //    var globalColor: String { get }
    //    /* 欢迎页图片组*/
    //    var welcomeImages: [String] { get }
    //    /* 手机号icon */
    //    var phoneIcon: String { get }
    //    /* 验证码icon */
    //    var vcodeIcon: String { get }
    //    /* 密码 */
    //    var passwordIcon: String { get }
    //    /* 密码 眼睛*/
    //    var passwordItemNIcon: String { get }
    //    /* 密码 眼睛*/
    //    var passwordItemSIcon: String { get }
    /* 返回按钮icon */
    //    var backIcon: String { get }
    //    /* 默认头像 */
    //    var defaultIcon: String { get }
    //    /* 用户资料icon */
    //    /* 联系我们的手机号 */
    //    var phoneNum: String { get }
    /* 请求主链接 */
    var host: String { get }
    /* 获得密码的code */
    var smspasswordCode: String { get }
    /* 快捷登录的code */
    var smsLoginCode: String { get }
    /* 签名 */
    var smsSignName: String { get }
    // 唯一编码
    var prprEncode: String { get }
    
    var umKey: String { get }
    
    var jpKey: String { get }
}
