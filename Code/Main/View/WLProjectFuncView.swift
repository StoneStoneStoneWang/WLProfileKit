//
//  WLProjectFuncView.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/8.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

@objc public final class WLProjectFuncView: UICollectionView {
    
    var mDelegate: WLProjectFuncCellDelegate!
    
    public var funcItems: [WLProjectFuncBean] = []
    
    @objc public static func project() -> Self {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: 60, height: 30)
        
        return self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    @objc public var layout: UICollectionViewFlowLayout!
    
    @objc public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.layout = layout as? UICollectionViewFlowLayout
        
        let w = WLProjectFuncBean()
        
        w.type = .watch
        
        let c = WLProjectFuncBean()
        
        c.type = .comment
        
        let f = WLProjectFuncBean()
        
        f.type = .fun
        
        funcItems += [w,c,f]
        
        commitInit()
    }
    
    var projectBean: WLProjectBean! {
        
        willSet {
            
            guard let newValue = newValue else { return }
            
            funcItems[0].title = "\(newValue.countComment)"
            
            funcItems[1].title = "\(newValue.countComment)"
            
            funcItems[2].title = "\(newValue.countLaud)"
            
            funcItems[2].isSelected = newValue.isLaud
            
            reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension WLProjectFuncView {
    
    @objc public func commitInit() {
        
        showsVerticalScrollIndicator = false
        
        showsHorizontalScrollIndicator = false
        
        bounces = false
        
        register(WLProjectFuncCell.self, forCellWithReuseIdentifier: "cell")
        
        dataSource = self
        
        delegate = self
        
        backgroundColor = .clear
    }
}

extension WLProjectFuncView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return funcItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WLProjectFuncCell
        
        cell.funcBean = funcItems[indexPath.row]
        
        cell.mDelegate = self.mDelegate
        
        return cell
        
    }
}

extension WLProjectFuncView: UICollectionViewDelegate { }
