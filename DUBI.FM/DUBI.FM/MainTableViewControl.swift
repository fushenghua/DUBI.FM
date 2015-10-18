//
//  MainTableViewControl.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/10/11.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit
import Alamofire

class MainTableViewControl: UITableViewController {

    var channelsArr:NSArray=NSArray();
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        
        loadData();

        
        
    }
    
    func loadData(){
        Alamofire.request(.GET, get_channels).responseJSON { response in
            print(response.result);
            
            if let json1=response.result.value{
                
                print(json1);
                
//            let json=JSON(data:response.data!);
             let json = JSON(json1);
              self.channelsArr =  json["channels"].arrayObject!;
//                ChannelBean.parses(arr:self.channelsArr);
            
                
                print(self.channelsArr[0]);
//                ChannelBean.parse(dict: self.channelsArr[0] as! NSDictionary);
                print(self.channelsArr.count);
                self.tableView.reloadData();
            }
        };

    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.channelsArr.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID="channel";
        //create cell
        var cell = tableView.dequeueReusableCellWithIdentifier(ID);
        if  cell == nil{
            cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID);
        }
        var dic:NSDictionary = channelsArr[indexPath.row] as! NSDictionary;
        var name=dic["name"] as! String;
        cell?.textLabel?.text="\(name) MHz";
//        let nsd = NSData(contentsOfURL: dic["name"] as! String!);
//        self.backgroundImageView.image=UIImage(data: nsd!)
//        cell?.imageView?.image=UIImage(named: "app");
//        cell?.detailTextLabel?.text="有人赞过你";
        return cell!;
    }
    
}
    