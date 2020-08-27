//
//  BasicCell.swift
//  MyPagerCollView
//
//  Created by Leela Prasad on 08/03/18.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//

import UIKit

class BasicCell: UICollectionViewCell {
    
    var tabInfo: TabInfo?
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    override var isSelected: Bool {
        didSet{
            select(self.isSelected)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormatString(formate: "V:|[v0]|", views: titleLabel)
        
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        BasicCell.topRoundCorners(self.contentView)
        select(false)
    }
    
    private func select(_ selected: Bool) {
        if (selected) {
            self.contentView.backgroundColor = Utils.intToUIColor(argbValue: tabInfo!.color)
            self.titleLabel.textColor = UIColor.white
        } else {
            self.contentView.backgroundColor = UIColor.gray
            self.titleLabel.textColor = UIColor.black
        }
    }
    
    private static func topRoundCorners(_ view: UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                    byRoundingCorners: [.topLeft, .topRight],
                    cornerRadii: CGSize(width: 12.0, height: 12.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}
