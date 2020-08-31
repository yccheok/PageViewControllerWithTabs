//
//  MenuTabsView.swift
//  MyPagerCollView
//
//  Created by Leela Prasad on 09/03/18.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//

import UIKit

protocol MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: MenuTabsView,index: Int)
}


class MenuTabsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    lazy var collView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.estimated(44),
            heightDimension: NSCollectionLayoutDimension.fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 1
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: itemSize,
            subitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    
    var isSizeToFitCellsNeeded: Bool = false {
        didSet{
            self.collView.reloadData()
        }
    }

    var dataArray: [TabInfo] = [] {
        didSet{
            self.collView.reloadData()
        }
    }
    
    
    var menuDidSelected: ((_ collectionView: UICollectionView, _ indexPath: IndexPath)->())?

    var menuDelegate: MenuBarDelegate?
    
    var cellId = "BasicCell"
    
    var selectedIndex: Int = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customIntializer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        customIntializer()
    }
    
    public func select(_ index: Int) {
        self.selectedIndex = index
        
        let indexPath = IndexPath(item: index, section: 0)
        self.collView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        self.collectionView(self.collView, didSelectItemAt: indexPath)
    }
    
    private func customIntializer () {
        
        collView.register(BasicCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collView)
        
        collView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsWithFormatString(formate: "V:|[v0]|", views: collView)
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: collView)
        backgroundColor = .clear
    }
    
    
    //MARK: CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BasicCell {
            cell.titleLabel.text = dataArray[indexPath.item].name
            
            if self.selectedIndex == indexPath.row {
                let tabInfo = dataArray[indexPath.item]
                cell.contentView.backgroundColor = Utils.intToUIColor(argbValue: tabInfo.color)
                cell.titleLabel.textColor = UIColor.white
            } else {
                cell.contentView.backgroundColor = UIColor.gray
                cell.titleLabel.textColor = UIColor.black
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        collectionView.reloadData()
        
        menuDelegate?.menuBarDidSelectItemAt(menu: self, index: self.selectedIndex)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}
