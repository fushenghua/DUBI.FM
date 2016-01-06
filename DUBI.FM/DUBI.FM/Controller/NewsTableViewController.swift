//
//  NewsTableViewController.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/10/22.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableViewController: UITableViewController {
    
    var index=0;
    var urlString:String?;
    var newsData:Array<NewsModel>=Array<NewsModel>();;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.clearColor();

        
        self.loadData();
    }
    
    
    func loadData(){
        
        self.loadDataForType(1, url: baseURL+"/nc/article/"+urlString!+"/0-20.html");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    
    func loadDataForType(type:Int,url:String){
        print(url)
        
        Alamofire.request(.GET, url).responseJSON { (response:Response<AnyObject, NSError>) -> Void in
            print("====\(response.result.value)");
            
            let json:Array<JSON>=JSON(data:response.data!)["T1348647853363"].arrayValue as! Array<JSON>;
            
            
            for  jb in json {
                let new=NewsModel();
                
                new.digest=jb["digest"].string;
                new.title=jb["title"].string
                new.replyCount="20000"
                new.imgsrc=jb["imgsrc"].string
                new.docid=jb["docid"].string

                self.newsData.append(new);
            }
            self.tableView.reloadData();
      
        };
    
    }
    
    
    
    //tableview 代理方法
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsData.count;
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let new:NewsModel=self.newsData[indexPath.row];
        
        let ID:String=NewsModel.idForRow(new);
        
        let cell:NewsCell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as! NewsCell;
        
        cell.setNewsModel(new);

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80;
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true);
       
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController .isKindOfClass(NewsDetailController)){
            let x=self.tableView.indexPathForSelectedRow?.row;
            let dc:NewsDetailController=segue.destinationViewController as! NewsDetailController;
            dc.newsModel=self.newsData[x!];
            dc.index=self.index;
            let isSeelector=(self.navigationController?.respondsToSelector(Selector("interactivePopGestureRecognizer")))!;

            if(isSeelector){
                self.navigationController?.interactivePopGestureRecognizer?.delegate=nil;
            }
            
        }else{
        
        
        
        }
        
//        if(segue.destinationViewController is NewsDetailController){
//        
//        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
