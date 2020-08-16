//
//  IngredientsTableView.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/15/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import Foundation
import UIKit

class IngredientsTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
