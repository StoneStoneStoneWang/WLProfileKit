//
//  WLProjectFuncCell.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import WLToolsKit

protocol WLProjectFuncCellDelegate {
    
    func onWatchItemClick()
    
    func onCommentItemClick()
    
    func onFunItemClick()
}

public enum WLProjectFuncType {
    
    case watch
    
    case comment
    
    case fun
    
    var icon: String {
        
        switch self {
        case .watch: return WLMainGlobal.default.styleConfig.watchIcon
            
        case .comment: return WLMainGlobal.default.styleConfig.commentIcon
            
        case .fun: return WLMainGlobal.default.styleConfig.funNormalIcon
            
        }
    }
    var selectedIcon: String {
        
        switch self {
        case .fun: return WLMainGlobal.default.styleConfig.funSelectedIcon
            
        default: return ""
            
        }
    }
}

public final class WLProjectFuncBean {
    
    var type: WLProjectFuncType = .watch
    
    var isSelected: Bool = false
    
    var title: String = ""
}

@objc public final class WLProjectFuncCell: UICollectionViewCell {
    
    var mDelegate: WLProjectFuncCellDelegate!
    
    public final let funcItem: UIButton = UIButton(type: .custom).then {
        
        $0.setTitleColor(WLHEXCOLOR(hexColor: "#999999"), for: .normal)
        
        $0.setTitleColor(WLHEXCOLOR(hexColor: "#666666"), for: .highlighted)
        
        $0.setTitleColor(WLHEXCOLOR(hexColor: WLMainGlobal.default.styleConfig.globalColor), for: .selected)
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var funcBean: WLProjectFuncBean? {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            funcItem.setImage(UIImage(named: newValue.type.icon), for: .normal)
            
            funcItem.setImage(UIImage(named: newValue.type.icon), for: .highlighted)
            
            funcItem.setTitle("  \(newValue.title)", for: .normal)
            
            funcItem.setTitle("  \(newValue.title)", for: .highlighted)
            
            if newValue.type == .fun {
                
                funcItem.setTitle("  \(newValue.title)", for: .selected)
                
                funcItem.setImage(UIImage(named: newValue.type.selectedIcon), for: .selected)
                
                funcItem.isSelected = newValue.isSelected
            } else {
                
                funcItem.isSelected = false
            }
        }
    }
}

extension WLProjectFuncCell {
    
    public func commitInit() {
        
        addSubview(funcItem)
        
        funcItem.addTarget(self, action: #selector(onFuncItemClick), for: .touchUpInside)
    }
    @objc func onFuncItemClick() {
        
        guard let delegate = mDelegate ,let funcBean = funcBean else { return }
        
        switch funcBean.type {
        case .fun: delegate.onFunItemClick()
            
        case .comment: delegate.onCommentItemClick()
            
        case .watch: delegate.onWatchItemClick()
        }
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        funcItem.snp.makeConstraints { (make) in
            
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
