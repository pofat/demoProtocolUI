//
//  ViewController.swift
//  testAutoLoadImageView
//
//  Created by Pofat Diuit on 2016/6/8.
//  Copyright © 2016年 duolC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: autoLoadRoundImageView!

    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var largeTextView: myTextView!
    
    var weather: Weather = Weather()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func load() {
        // image will be loaded automatically
        imageView.mediaURL = "https://i.ytimg.com/vi/5tfsiz79yJg/maxresdefault.jpg"
        // load json
        weather.jsonURL = "http://weather.json.tw/api?region=new_taipei_city"
        weather.loadJSON() { [weak self] in
            self?.smallLabel.displayStringValue(self!.weather)
            self?.mediumLabel.displayStringValue(self!.weather)
            self?.largeTextView.displayStringValue(self!.weather)
        }
    }

}

