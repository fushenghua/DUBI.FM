//
//  HttpClient.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/11/25.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import Foundation
import Alamofire

class HttpClient {
    
    
    
    func get(url:String){
        
        Alamofire.request(.GET, url).responseJSON { (response:Response<AnyObject, NSError>) -> Void in
//            print("====\(response.result.value)");
        };
        
//        Alamofire.request(.GET, url);
//        Alamofire.request(.GET,url,
//            parameters: ["foo": "bar"])
//            .response { (request, response, data, error) in
//                print(request)
//                print(response)
//                print(error)
//        }
       
    }
    
    
    func post(url:String){
        
    }
    
   
    
}


protocol RequestProtocol{
    
    func onSuccess()->String
    
}




