//
//  resoureProtocol.swift
//  testAutoLoadImageView
//
//  Created by Pofat Diuit on 2016/6/8.
//  Copyright © 2016年 duolC. All rights reserved.
//

import Foundation
import UIKit

// Cache for demo only. You should not use this for a product.
public var dataCache: [String : NSData] = [:]

// Resource protocol
public protocol RemoteResource {}
public extension RemoteResource {
    func load(url: String, completion: ((success: Bool)->())?) {
        print("Performing request: ", url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { data, response, error in
            if let httpResponse = response as? NSHTTPURLResponse where error == nil && data != nil {
                print("Response Code: %d", httpResponse.statusCode)
                
                dataCache[url] = data
                if let c = completion {
                    c(success: true)
                }
            } else {
                print("Request Error")
                if let c = completion {
                    c(success: false)
                }
            }
        }
        task.resume()
    }
    
    func dataForURL(url: String) -> NSData? {
        return dataCache[url]
    }
}



// Image Resource
public protocol MediaResource : RemoteResource {
    var mediaURL: String { get set }
}
public extension MediaResource {
    // Main loading method
    func loadMedia(completion: (()->())?) {
        self.load(self.mediaURL) { success in
            // Execute closure on the main queue
            if let c = completion {
                dispatch_async(dispatch_get_main_queue(), c)
            }
        }
    }
    // get image value
    var imageValue: UIImage? {
        if let d = self.dataForURL(self.mediaURL) {
            return UIImage(data: d)
        }
        return nil
    }
}


// JSON Resource
protocol JSONResource : RemoteResource {
    var jsonURL: String { get }
    func processJSON(success: Bool)
}
extension JSONResource {
    // Main loading method.
    func loadJSON(completion: (()->())?) {
        self.load(self.jsonURL) { success in
            // process parsed JSON
            self.processJSON(success)
            if let c = completion {
                dispatch_async(dispatch_get_main_queue(), c)
            }
        }
    }
    // get JSON value
    var jsonValue: [String : AnyObject]? {
        do {
            if let d = self.dataForURL(self.jsonURL), result = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject] {
                return result
            }
        } catch {}
        return nil
    }
}



