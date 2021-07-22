//
//  UIView+Extension.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/13/21.
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                self.layer.borderColor = color.cgColor
            } else {
                self.layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                self.layer.shadowColor = color.cgColor
            } else {
                self.layer.shadowColor = nil
            }
        }
    }
}


extension UIView {
    enum BorderSide {
        case top, bottom, left, right
    }
    
    func corners(radius: CGFloat, maskToBounds: Bool = true, maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = maskToBounds
        self.layer.maskedCorners = maskedCorners
    }
    
    func corner(radius: CGFloat, maskToBounds: Bool = true, roundingCorners: UIRectCorner = .allCorners) {
        if roundingCorners == .allCorners {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = maskToBounds
        } else {
            let shape = CAShapeLayer()
            shape.bounds = self.frame
            shape.position = self.center
            shape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = shape
        }
    }

    func circle() {
        self.layoutIfNeeded()
        self.corner(radius: self.frame.width / 2.0, roundingCorners: .allCorners)
    }
    
    func shadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat, path: CGPath? = nil) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowPath = path
    }
    
    func border(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func border(side: BorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        self.layer.addSublayer(border)
    }
    
    func gradient(colors: [UIColor], start: CGPoint, end: CGPoint, locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat?, height: CGFloat?) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func showWithAnimation(animatedView:UIView, in view:UIView?){
       
        self.frame = view!.bounds
        view?.addSubview(self)
        view?.bringSubviewToFront(self)
        animatedView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        animatedView.alpha = 0
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.8),
                       initialSpringVelocity: CGFloat(10.0),
                       options: [],
                       animations: {
                        animatedView.alpha = 1.0
                        animatedView.transform = CGAffineTransform.identity
                       }, completion: nil)
        
    }
    func hideWithAnimation(animatedView: UIView, callback: (()->())?){
        animatedView.alpha = 1.0
        animatedView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            animatedView.alpha = 0.0
            animatedView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        }, completion:{finished in
            self.removeFromSuperview()
            callback?()
        })
    }
}

fileprivate var ActivityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"

extension UIView {
    var activityIndicatorView: UIActivityIndicatorView {
        get {
            if let activityIndicatorView = objc_getAssociatedObject(self,&ActivityIndicatorViewAssociativeKey) as? UIActivityIndicatorView {
                bringSubviewToFront(activityIndicatorView)
                return activityIndicatorView
            } else {
                let activityIndicatorView:UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
                if #available(iOS 12.0, *) {
                    if(traitCollection.userInterfaceStyle == .dark){
                        activityIndicatorView.style = .medium
                    }
                } else {
                }
                activityIndicatorView.tintColor = .black
                activityIndicatorView.frame = CGRect.init(x: 0, y: 0, width: 120, height: 120)
                activityIndicatorView.layer.cornerRadius = 15
                activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(activityIndicatorView)
                bringSubviewToFront(activityIndicatorView)
                NSLayoutConstraint.activate([
                    activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
                    activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
                ])
                
                objc_setAssociatedObject(self, &ActivityIndicatorViewAssociativeKey,activityIndicatorView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activityIndicatorView
            }
        }
        
        set {
            addSubview(newValue)
            bringSubviewToFront(activityIndicatorView)
            objc_setAssociatedObject(self, &ActivityIndicatorViewAssociativeKey,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
}

protocol NibLoadableView: AnyObject { }
extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
        
    func connectNibUI() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil)
        guard let nibView = nib.first as? UIView else {
            fatalError("Nib is not correct")
        }
        nibView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nibView)
        nibView.anchor(top: topAnchor,
                       left: leftAnchor,
                       bottom: bottomAnchor,
                       right: rightAnchor,
                       paddingTop: 0,
                       paddingLeft: 0,
                       paddingBottom: 0,
                       paddingRight: 0,
                       width: nil,
                       height: nil)
    }
}



extension UIView {

    /// Creates an image from the view's contents, using its layer.
    ///
    /// - Returns: An image, or nil if an image couldn't be created.
    func imagePlotView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: UIScreen.main.bounds.width - 44, height: 97), false, 1)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        layer.render(in: context)
        context.restoreGState()
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }

}

extension UIView {
    func addShadow(color: CGColor, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
}

