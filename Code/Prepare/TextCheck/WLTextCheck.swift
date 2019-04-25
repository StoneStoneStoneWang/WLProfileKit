//
//  WLTextCheck.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLToolsKit

public func checkPhoneResult(_ mobile: String ) -> WLUserResult {
    
    if mobile.isEmpty || mobile.wl_isEmpty {
        
        return WLUserResult.failed("手机号不能为空")
    }
    if !String.validPhone(phone: mobile) {
        
        return WLUserResult.failed( "请输入正确手机号")
    }
    return WLUserResult.ok("")
}

public func smsResult(count: Int) -> (Bool ,String) {
    
    if count <= 0 { return  (true ,"获取验证码") }
        
    else { return (false ,"(\(count)s)")}
}

public func swiftLoginCheckResult(_ mobile: String ,vcode: String) -> WLUserResult {
    
    if mobile.isEmpty || mobile.wl_isEmpty {
        
        return WLUserResult.failed("手机号不能为空")
    }
    if !String.validPhone(phone: mobile) {
        
        return WLUserResult.failed( "请输入正确手机号")
    }
    
    if vcode.isEmpty || vcode.wl_isEmpty {
        
        return WLUserResult.failed( "请输入6位验证码")
    }
    
    if vcode.length < 6 {
        
        return WLUserResult.failed( "请输入6位验证码")
    }
    
    return WLUserResult.ok( "")
}
public func pwdCheckResult(_ mobile: String ,vcode: String ,password: String) -> WLUserResult {
    
    if mobile.isEmpty || mobile.wl_isEmpty {
        
        return WLUserResult.failed("手机号不能为空")
    }
    if !String.validPhone(phone: mobile) {
        
        return WLUserResult.failed( "请输入正确手机号")
    }
    
    if vcode.isEmpty || vcode.wl_isEmpty {
        
        return WLUserResult.failed( "请输入6位验证码")
    }
    
    if vcode.length < 6 {
        
        return WLUserResult.failed( "请输入6位验证码")
    }
    
    if password.isEmpty || password.wl_isEmpty {
        
        return WLUserResult.failed( "请输入6-18位密码")
    }
    
    if password.length < 6 {
        
        return WLUserResult.failed( "请输入6-18位密码")
    }
    
    return WLUserResult.ok( "")
}
