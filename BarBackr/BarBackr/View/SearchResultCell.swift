//
//  SearchCell.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/16/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var cocktail: Cocktail?
    
    weak var delegate : SearchResultCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton){
        print("add button pressed")
        if let cocktail = cocktail,
            let _ = delegate {
            print("if let worked")
            self.delegate?.searchResultTableCell(self, addButtonTappedFor: cocktail)
        }
    }

}

protocol SearchResultCellDelegate: AnyObject {
    func searchResultTableCell(_ searchResultTableCell: SearchResultCell, addButtonTappedFor cocktail: Cocktail)
}
