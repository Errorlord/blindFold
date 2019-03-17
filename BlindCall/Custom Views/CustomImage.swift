//
//  CustomImage.swift
//  HackPSu
//
//  Created by Nadith Dharmasena on 3/16/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class CustomImage: UIView {
    
    var image:UIImage!
    var width:CGFloat!
    var height:CGFloat!
    
    var albumID:String? // Only for track images
    var trackID:String? // Only for track images
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(image_name:String, width:CGFloat, height:CGFloat) {
        super.init(frame: CGRect())
        
        self.image = UIImage(named: image_name)
        self.width = width
        self.height = height
    }
    
    init(image_data:UIImage, width:CGFloat, height:CGFloat) {
        super.init(frame: CGRect())
        
        self.image = image_data
        self.width = width
        self.height = height
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.image?.draw(in: CGRect(x:0, y:0, width:self.width, height: self.height))
    }
    
    func getImageWidth() -> CGFloat {
        return self.image.size.width
    }
    
    func getImageHeight() -> CGFloat {
        return self.image.size.height
    }
    
}
