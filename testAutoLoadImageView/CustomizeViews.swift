//
//  CustomizeViews.swift
//  ProtocolOrientedUIProgramming
//
//  Created by Pofat Diuit on 2016/8/18.
//  Copyright © 2016年 Pofat. All rights reserved.
//

import Foundation
import UIKit

class MyView: UIView, OrangeBackgroundColor, MyRoundCorner, MyShadowEffect {}

@IBDesignable class myTextView: UITextView, MyTextViewStyle {}

@IBDesignable class autoLoadRoundImageView: UIImageView, MediaResource, CircleView {
    // Automatically load the image right after its url is set
    var mediaURL: String = "" {
        didSet {
            self.loadMedia { [weak self] in
                self?.image = self?.imageValue
            }
        }
    }
}