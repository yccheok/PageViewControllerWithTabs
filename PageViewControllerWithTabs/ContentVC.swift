//
//  ContentVC.swift
//  PageViewControllerWithTabs
//
//  Created by Leela Prasad on 22/03/18.
//  Copyright © 2018 Leela Prasad. All rights reserved.
//

import UIKit


class ContentVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pageIndex: Int = 0
    var strTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = strTitle
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ContentVC.nameLabelTap))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(tap)
    }

    @objc func nameLabelTap(sender:UITapGestureRecognizer) {
        if let viewController = self.parent?.parent as? ViewController {
            viewController.debug()
        }
    }
}
