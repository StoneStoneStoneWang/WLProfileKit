//
//  WLPublishHeaderView.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLComponentView

public final class WLPublishHeaderView: UICollectionReusableView {
    
    public var tf: WLNickNameTextField = WLNickNameTextField(frame: .zero).then {
        
        $0.placeholder = "请输入标题"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    public func commitInit() {
        
        addSubview(tf)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WLPublishHeaderView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        
        tf.snp.makeConstraints { (make) in
            
            make.left.top.right.bottom.equalToSuperview()
            
        }
    }
    
}
