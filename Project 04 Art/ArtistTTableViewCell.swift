//
//  ArtistTTableViewCell.swift
//  Project 04 Art
//
//  Created by Chris on 21/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class ArtistTTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistBio: UILabel!
    
    func setImage(as image: UIImage) {
        let imageRatio = image.size.height / image.size.width
        UIGraphicsBeginImageContext(CGSize(width: artistImage.bounds.width, height: artistImage.bounds.width*imageRatio))
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: artistImage.bounds.width, height: artistImage.bounds.width*imageRatio)))
        artistImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
