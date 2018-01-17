//
//  SVTableViewCell.swift
//  SVDeck
//
//  Created by 張峻浩 on 2018/1/11.
//  Copyright © 2018年 張峻浩. All rights reserved.
//

import UIKit

class SVTableViewCell: UITableViewCell {

    @IBOutlet weak var deckName: UILabel!
    
    @IBOutlet weak var typeIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
