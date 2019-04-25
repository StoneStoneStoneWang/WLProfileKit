//
//  WLUtilView.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLTextField
import RxCocoa
import RxSwift



public final class WLPasswordTextFiled: WLLeftImageTextField {
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.rightViewRect(forBounds: bounds)
        
        return CGRect(x: rect.minX - 30, y: rect.minY, width: rect.width , height: rect.height)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.editingRect(forBounds: bounds)
        
        return CGRect(x: rect.minX, y: rect.minY, width: rect.width  - 30, height: rect.height)
    }
}


public class WLLoginVerfiyTextField: WLLeftImageTextField {
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.rightViewRect(forBounds: bounds)
        
        return CGRect(x: rect.minX - 20, y: rect.minY, width: rect.width, height: rect.height)
    }
}
