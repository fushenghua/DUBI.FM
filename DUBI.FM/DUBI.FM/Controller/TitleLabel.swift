//
//  TitleLabel.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/10/22.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    var sacle:CGFloat?;
    var sacleValue:CGFloat{
        get {
            return self.sacle!;
        }
        
        set{
            self.sacle=newValue;
            self.textColor=UIColor.init(red: sacleValue, green: 0.0, blue: 0.0, alpha: 1);
            var minScale:CGFloat=0.7;
            var trueScale=minScale +  CGFloat(1-minScale) * sacleValue;
            self.transform=CGAffineTransformMakeScale(trueScale, trueScale);
        }
        
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textAlignment=NSTextAlignment.Center;
        self.font=UIFont.systemFontOfSize(18);
        self.sacle=0.0;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
