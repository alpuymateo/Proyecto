//
//  CategoryMovieTableViewCell.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 29/7/21.
//

import UIKit
import Cosmos

protocol CategoryMovieTableViewCellDelegate: AnyObject {
//    func didTapButton(cell: CategoryMovieTableViewCell)
//    func didTapBackground()
}
class CategoryMovieTableViewCell: UITableViewCell {

    weak var delegate: CategoryMovieTableViewCellDelegate?

    @IBOutlet weak var RatingView: CosmosView!
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    var movie: Movie!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(name: String) {
        TitleLabel.text = name
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
