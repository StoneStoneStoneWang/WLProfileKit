//
//  WLContent1ViewController.swift
//  WLProfileKitDemo
//
//  Created by three stone 王 on 2019/5/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import WLToolsKit

public final class WLContent1ViewController: WLContentBaseViewController {
    
    final let headerView: WLContentHeaderVIew = WLContentHeaderVIew(.lightgray, style: .default, reuseIdentifier: "cell")
    
    public override func configOwnSubViews() {
        super.configOwnSubViews()
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        
        tableView.tableHeaderView = headerView
    
        tableView.frame = view.bounds
        
        headerView.type = (circleBean.users,"\(circleBean.intime)")
        
        tableView.mj_header.isHidden = true
        
        tableView.mj_footer.isHidden = true
    }
}
