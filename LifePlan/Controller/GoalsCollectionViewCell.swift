//
//  GoalsCollectionViewCell.swift
//  LifePlan
//
//  Created by Ali on 05/10/2019.
//  Copyright © 2019 Ali. All rights reserved.
//

import UIKit

protocol DeleteItemProtocol {
    func deleteItem(indx: Int)
}


class GoalsCollectionViewCell: UICollectionViewCell {
    
    var delegate: DeleteItemProtocol?
    var index: IndexPath?
        
    @IBOutlet var goalIconImage: UIImageView!
    
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var goalTitleLabel: UILabel!
    
    @IBAction func deleteIconPressed(_ sender: Any) {

        delegate?.deleteItem(indx: index!.row)

    }
    
    
}
