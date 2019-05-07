//
//  WLPublishCollectionView.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/30.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

public final class WLPublishCollectionView: UICollectionView {
    
    public static func createPublish(_ flowLayout: UICollectionViewFlowLayout) -> WLPublishCollectionView {
        
        return WLPublishCollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension WLPublishCollectionView {
    
    public func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        backgroundColor = .clear
        
        bounces = true
    }
}
