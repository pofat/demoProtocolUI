//
//  DataFormattingProtocol.swift
//  testAutoLoadImageView
//
//  Created by Pofat Diuit on 2016/6/13.
//  Copyright © 2016年 duolC. All rights reserved.
//

import Foundation
import UIKit

// Define display string for different length
protocol StringRepresentable {
    var short: String { get }
    var medium: String { get }
    var long: String { get }
}

// Define which length of the displayed string can be put in a container
protocol StringDisplay {
    var containerSize: CGSize { get }
    var containerFont: UIFont { get }
    func assignString(str: String)
}
extension StringDisplay {
    func displayStringValue(obj: StringRepresentable) {
        // Determine the longest string which can fit within the containerSize, then assign it.
        if self.stringWithin(obj.long) {
            self.assignString(obj.long)
        } else if self.stringWithin(obj.medium) {
            self.assignString(obj.medium)
        } else {
            self.assignString(obj.short)
        }
    }
    // calculate string display rect size
    func sizeWithString(str: String) -> CGSize {
        return str.boundingRectWithSize(CGSizeMake(self.containerSize.width, .max),
                                                      options: .UsesLineFragmentOrigin,
                                                      attributes:  [NSFontAttributeName: self.containerFont],
                                                      context: nil).size
    }
    // check if string fits in a container
    private func stringWithin(str: String) -> Bool {
        return self.sizeWithString(str).height <= self.containerSize.height
    }
}

// setup display for UILabel
extension UILabel: StringDisplay {
    var containerSize: CGSize { return self.frame.size }
    var containerFont: UIFont { return self.font }
    func assignString(str: String) {
        self.text = str
    }
}

// setup display for UITextView
extension UITextView: StringDisplay {
    var containerSize: CGSize { return self.frame.size }
    var containerFont: UIFont { return self.font! }
    func assignString(str: String) {
        self.text = str
    }
}



// Identifier protocol
protocol Unique {
    var id: String! { get set }
}
extension Unique where Self: NSObject {
    init(id: String?) {
        self.init()
        if let identifier = id {
            self.id = identifier
        } else {
            self.id = NSUUID().UUIDString
        }
    }
}