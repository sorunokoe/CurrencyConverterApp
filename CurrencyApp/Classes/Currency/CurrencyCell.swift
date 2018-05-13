//
//  CurrencyCell.swift
//  CurrencyApp
//
//  Created by Mac on 12.05.2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import UIKit
import Cartography
import Hue

class CurrencyCell: UITableViewCell{
    
    var codeLabel: UILabel!
    var flagImage: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layer.masksToBounds = true
        setViews()
        addViews()
        setConstrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews(){
        codeLabel = {
            let label = UILabel()
            return label
        }()
        flagImage = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.image = #imageLiteral(resourceName: "rectangle")
            return image
        }()
    }
    func addViews(){
        [codeLabel, flagImage].forEach {
            self.addSubview($0)
        }
    }
    func setConstrain(){
        constrain(flagImage, codeLabel){
            $0.left == $0.superview!.left+30
            $0.centerY == $0.superview!.centerY
            $0.width == 45
            $0.height == 30
            
            $1.left == $0.right+15
            $1.centerY == $1.superview!.centerY
        }
    }
    
    func setData(flag: UIImage?, code: String?){
        if let code = code{
            self.codeLabel.text = code
        }
        if let flag = flag{
            self.flagImage.image = flag
        }
    }
}
