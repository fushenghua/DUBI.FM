//
//  ViewController.swift
//  DUBI.FM
//
//  Created by fushenghua on 15/10/7.
//  Copyright © 2015年 fushenghua. All rights reserved.
//

import UIKit
import MediaPlayer
import Alamofire
import AVKit



class MainViewController: UIViewController {

    var audioPlay:MPMoviePlayerController = MPMoviePlayerController();
    var isPlaying:Bool                    = true;
    let url="http://douban.fm/j/mine/playlist?channel=0";
    var timer:NSTimer?;
    var currentTimeMinutes:Int?;
    var currentTimeSeconds:Int?;
    var lengthTime:Int?;

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var singerLable: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        loadAudio("http://mr7.doubanio.com/8d9ec4d0ac9192b12ced9b931dc7d605/0/fm/song/p184_128k.mp3");
        initshadow();
        loadData();
        initialize();
        testWidget();
    }
    
    func testWidget(){
    let groudID="group.com.rtmap.dubi";
       let shareID = NSUserDefaults(suiteName: groudID);
        shareID?.setObject(10, forKey: "number");
        shareID?.synchronize();
    }
    
    
    func initialize(){
        let session=AVAudioSession.sharedInstance();
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord);
        try! session.setActive(true);
    }
    
    func initTimer(){
        timer=NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateProgress", userInfo: nil, repeats: true);
    }
    
    
    @IBAction func next(sender: AnyObject) {
        loadData();
    }
   func initshadow(){
    let shoadowPath:UIBezierPath=UIBezierPath(rect: backgroundImageView.bounds);
    backgroundImageView.layer.masksToBounds=false;
    backgroundImageView.layer.shadowColor=UIColor.blackColor().CGColor;
    backgroundImageView.layer.shadowOffset=CGSizeMake(0.0,5.0);
    backgroundImageView.layer.shadowOpacity=0.1;
    backgroundImageView.layer.shadowPath=shoadowPath.CGPath;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   @IBAction func play(){
        if(isPlaying){
        isPlaying = false;
        audioPlay.play();
         btnPlay.setTitle("暂停", forState: UIControlState.Normal);
        }else{
        isPlaying = true;
         audioPlay.pause();
        btnPlay.setTitle("播放", forState: UIControlState.Normal);

        }

    }

    func stop(){
        self.audioPlay.stop();
    }

    func loadAudio(url:String){
    self.audioPlay.contentURL             = NSURL(string: url);
    }
    
    
    func loadData(){
        Alamofire.request(.GET, url).responseJSON { response in
            print(response.result);
            
            if let json1=response.result.value{
              
                print(json1);
               
            }
            
           let json=JSON(data:response.data!);
           let picture=json["song"][0]["picture"].string;
            if (picture == nil){
                return ;
            }
           let picurl=NSURL(string: picture!);
            let nsd = NSData(contentsOfURL: picurl!);
            self.backgroundImageView.image=UIImage(data: nsd!);
            let musicUrl=json["song"][0]["url"].string;
            let title=json["song"][0]["title"].string;
             self.lengthTime=json["song"][0]["length"].int;
            let singer=json["song"][0]["singers"][0]["name"];
            self.titleLable.text=title;
            self.singerLable.text=singer.string;
            self.loadAudio(musicUrl!)
            self.isPlaying=true;
            self.play();
            self.initTimer();
            print(picture);
            let TotalTimeSeconds=self.lengthTime!%60;
            let TotalTimeMinutes=self.lengthTime!/60;
            if(TotalTimeSeconds<10){
             
                self.timeLabel.text="-\(TotalTimeMinutes):0\(TotalTimeSeconds)";

            }else{ self.timeLabel.text="-\(TotalTimeMinutes):\(TotalTimeSeconds)";
                          }
            
        };
    }
    
    
    func updateProgress(){
        print(audioPlay.currentPlaybackTime);
        if audioPlay.currentPlaybackTime.isNaN{
            return;
        }
       currentTimeMinutes = Int(audioPlay.currentPlaybackTime)/60;
       currentTimeSeconds = Int(audioPlay.currentPlaybackTime)%60;
        print("currentTimeMinutes:\(currentTimeMinutes):-currentTimeSeconds:\(currentTimeSeconds)");
        
       
        self.progressbar.progress=Float(audioPlay.currentPlaybackTime)/Float(self.lengthTime!);
            
            //Float(Int(audioPlay.currentPlaybackTime)/self.lengthTime!);
        print("progressbar:\(Float(audioPlay.currentPlaybackTime)/Float(self.lengthTime!))")
    }


}

