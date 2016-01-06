//
//  MainTableBar.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/11/25.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit

class MainTableBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.loadLatestAdImage();
        
    }
    
    
    
    //加载广告图片
    func loadLatestAdImage(){
        var now=NSDate.init().timeIntervalSince1970;
        var path:String="http://g1.163.com/madr?app=7A16FBB6&platform=ios&category=startup&location=1&timestamp=ld";
//        var path="http://baidu.com";
        HttpClient.init().get(path);
        
    }
    
}
