import Foundation
import UIKit

// MARK: Basic UI Protocols

// CALayer:
public protocol MasksToBoundsTRUE {}
public protocol CornerRadius      { var myCornerRadius: CGFloat { get } }
public protocol ShadowColor       { var myShadowColor: UIColor  { get } }
public protocol ShadowOpacity     { var myShadowOpacity: Float  { get } }
public protocol ShadowOffset      { var myShadowOffset: CGSize  { get } }
public protocol ShadowRadius      { var myShadowRadius: CGFloat { get } }

// UIView:
public protocol BackgroundColor    { var myBackgroundColor: UIColor { get } }

// MARK: Main protocol which let the change happen

public protocol protocolUI {
    func adoptUIProtcol()
}


extension UIView: protocolUI {
    override public func awakeFromNib() {
        super.awakeFromNib()
        adoptUIProtcol()
    }
    
    public func adoptUIProtcol() {
        // CALayer implementation
        if let _ = self as? MasksToBoundsTRUE  { layer.masksToBounds = true }
        if let mySelf = self as? CornerRadius  { layer.cornerRadius = mySelf.myCornerRadius }
        if let mySelf = self as? ShadowColor   { layer.shadowColor = mySelf.myShadowColor.CGColor }
        if let mySelf = self as? ShadowOpacity { layer.shadowOpacity = mySelf.myShadowOpacity }
        if let mySelf = self as? ShadowOffset  { layer.shadowOffset = mySelf.myShadowOffset }
        if let mySelf = self as? ShadowRadius  { layer.shadowRadius = mySelf.myShadowRadius }
        
        // UIView implementation
        if let mySelf = self as? BackgroundColor { backgroundColor = mySelf.myBackgroundColor }
        
        // Protocol for avatar image view
        if let _ = self as? CircleView { layer.cornerRadius = bounds.width/2 }
        
    }
}

// MARK: Aggregate UI protocol

public protocol OrangeBackgroundColor: BackgroundColor {}
extension OrangeBackgroundColor {
    var myBackgroundColor: UIColor { return UIColor.orangeColor() }
}

public protocol MyRoundCorner: CornerRadius {}
extension MyRoundCorner {
    var myCornerRadius: CGFloat { return 10.0 }
}

public protocol MyShadowEffect: ShadowColor, ShadowRadius, ShadowOpacity, ShadowOffset {}
extension MyShadowEffect {
    var myShadowColor: UIColor  { return UIColor.lightGrayColor() }
    var myShadowOpacity: Float  { return 0.9 }
    var myShadowRadius: CGFloat { return 10.0 }
    var myShadowOffset: CGSize  { return CGSizeMake(10, 10) }
}

public protocol CircleView:MasksToBoundsTRUE {}

public protocol MyTextViewStyle: CornerRadius {}
extension MyTextViewStyle {
    var myCornerRadius: CGFloat { return 10 }
}
