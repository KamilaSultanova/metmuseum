//
//  ArtTableViewCell.swift
//  metmuseum
//
//  Created by Kamila Sultanova on 10.08.2023.
//

import UIKit
import SDWebImage

class ArtTableViewCell: UITableViewCell {
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var artLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(newArt: Arts){
        artistLabel.text = newArt.artistDisplayName
        artLabel.text = newArt.title
        dateLabel.text = newArt.objectDate
        materialLabel.text = newArt.medium
        artImageView.sd_setImage(with: URL(string: newArt.primaryImage),completed: nil)
        
    }

}
