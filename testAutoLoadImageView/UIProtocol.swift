
import Foundation
import UIKit

// protocol UI
public protocol MasksToBoundsTRUE {}
public protocol CornerRadius      { var myCornerRadius: CGFloat { get } }
public protocol CircleView:MasksToBoundsTRUE {}

public protocol protocolUI {
    func adoptUIProtcol()
}
extension UIView: protocolUI {
    override public func awakeFromNib() {
        super.awakeFromNib()
        adoptUIProtcol()
    }
    
    public func adoptUIProtcol() {
        if let _ = self as? MasksToBoundsTRUE { layer.masksToBounds = true }
        if let _ = self as? CircleView        { layer.cornerRadius = bounds.width/2 }
        if let mySelf = self as? CornerRadius      { layer.cornerRadius = mySelf.myCornerRadius }
    }
}

// aggregate UI protocol
public protocol MyUIStyle: CornerRadius {}
extension MyUIStyle {
    var myCornerRadius: CGFloat { return 10 }
}


// Custom ui class
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

@IBDesignable class myTextView: UITextView, MyUIStyle {}