//
//  Extensions.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/22.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation
import UIKit

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIColor {
    
    func  primary() -> UIColor {
        return UIColor(red: 255/255, green: 45/255, blue: 68/255, alpha: 1)
    }
    
    func tabBarSelectedColor() -> UIColor{
        return UIColor(red: 255/255, green: 216/255, blue: 223/255, alpha: 1)
    }
    
    static var sampleRed = UIColor(red: 252 / 255, green: 70 / 255, blue: 93 / 255, alpha: 1)
    static var sampleGreen = UIColor(red: 49 / 255, green: 193 / 255, blue: 109 / 255, alpha: 1)
    static var sampleBlue = UIColor(red: 52 / 255, green: 154 / 255, blue: 254 / 255, alpha: 1)
}

extension Date {
    
    func longDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
    func stringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMMyyyyHHmmSS"
        
        return dateFormatter.string(from: self)
    }
    
    func interVal(ofComponent : Calendar.Component, fromDate : Date) -> Int {
        
        let currentCarrender = Calendar.current
        
        guard let start = currentCarrender.ordinality(of: ofComponent, in: .era, for: fromDate) else { return 0}
        guard let end = currentCarrender.ordinality(of: ofComponent, in: .era, for: self) else { return 0}
        
        return end - start
        
    }
    
    
}
//
//extension UIImage {
//    var isPortrait : Bool { return size.height > self.size.width}
//    var isLabdscape : Bool { return size.width > self.size.height}
//
//    var breath : CGFloat {return min(size.width, size.height)}
//    var breathSize : CGSize {return CGSize(width: breath, height: breath)}
//
//    var breathRect : CGRect {return CGRect(origin: .zero, size: breathSize)}
//
//    var circleMasked : UIImage? {
//        UIGraphicsBeginImageContextWithOptions(breathSize, false, scale)
//
//        defer { UIGraphicsEndImageContext()}
//
//        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLabdscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait ? floor((size.height - size.width) / 2) : 0), size: breathSize)) else {return nil}
//    }
//}



extension UIView {
    
    func applyShadow(radius: CGFloat,
                     opacity: Float,
                     offset: CGSize,
                     color: UIColor = .black) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                   paddingTop: CGFloat = 0,
                   paddingLeft: CGFloat = 0,
                   paddingBottom: CGFloat = 0,
                   paddingRight: CGFloat = 0,
                   width: CGFloat? = nil,
                   height: CGFloat? = nil) {
           
           translatesAutoresizingMaskIntoConstraints = false
           
           if let top = top {
               topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
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
       
       func centerX(inView view : UIView, topAnchor : NSLayoutYAxisAnchor? = nil, paddingTop : CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            if let topAnchor = topAnchor {
                self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
            }
        }
       
       func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                    paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
           
           translatesAutoresizingMaskIntoConstraints = false
           centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
           
           if let left = leftAnchor {
               anchor(left: left, paddingLeft: paddingLeft)
           }
       }
    
    func center(inView view : UIView, yConstant : CGFloat? = 0) {
           translatesAutoresizingMaskIntoConstraints = false
           centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
       }
       
       func setDimensions(height: CGFloat, width: CGFloat) {
           translatesAutoresizingMaskIntoConstraints = false
           heightAnchor.constraint(equalToConstant: height).isActive = true
           widthAnchor.constraint(equalToConstant: width).isActive = true
       }
    
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @discardableResult
    open func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
            let superviewBottomAnchor = superview?.bottomAnchor,
            let superviewLeadingAnchor = superview?.leadingAnchor,
            let superviewTrailingAnchor = superview?.trailingAnchor else {
                return anchoredConstraints
        }
        
        return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
    }
    
    @discardableResult
    open func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        let anchoredConstraints = AnchoredConstraints()
        if #available(iOS 11.0, *) {
            guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
                let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
                let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
                let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else {
                    return anchoredConstraints
            }
            return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
            
        } else {
            return anchoredConstraints
        }
    }
    
    open func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerXToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    open func centerYToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
    }
    
    @discardableResult
    open func constrainHeight(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        return anchoredConstraints
    }
    
    @discardableResult
    open func constrainWidth(_ constant: CGFloat) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        return anchoredConstraints
    }
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    convenience public init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}

//MARK: - Indicators

extension UIViewController {
    func showAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func checkInternetConnection(nav : UINavigationController? = nil, tab : UITabBarController? = nil) {
        
        guard Reachabilty.HasConnection() else {
            showAlert(title: "Error", message: "No Internet Connection")
            
            if nav != nil {
                nav?.showPresentLoadindView(false)
                return
            } else if tab != nil {
                tab?.showPresentLoadindView(false)
                return
            }
            self.showPresentLoadindView(false)
            return
        }
        
        print("connect internt")
        
    }
    
    func showPresentLoadindView(_ present : Bool, message : String? = nil) {
        
        if present {
            
            let blackView = UIView()
            blackView.frame = self.view.bounds
            blackView.backgroundColor = .black
            blackView.alpha = 0
            blackView.tag = 1
            
            let indicator = UIActivityIndicatorView()
            indicator.color = .white
            indicator.style = .large
            indicator.center = blackView.center
            
            let label = UILabel()
            label.text = message
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            label.textAlignment = .center
            label.alpha = 0.7
            
            self.view.addSubview(blackView)
            blackView.addSubview(indicator)
            blackView.addSubview(label)
            
            label.centerX(inView: view)
            label.anchor(top : indicator.bottomAnchor,paddingTop: 23)
            
            indicator.startAnimating()
            
            UIView.animate(withDuration: 0.2) {
                blackView.alpha = 0.7
            }
            
            
        } else {
            
            // hide
            view.subviews.forEach { (subview) in
                
                if subview.tag == 1 {
                    UIView.animate(withDuration: 0.5, animations: {
                        subview.alpha = 0
                    }) { (_) in
                        subview.removeFromSuperview()
                    }
                }
            }
            
        }
    }
    
    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
            return topBarHeight
        }
    }
}


extension UIViewController {
    
    func createContainerView(_ withLabel : String? = nil, textField : UITextField) -> UIView {
        
        let containerView = UIView()
        
        containerView.addSubview(textField)
        textField.centerY(inView: containerView)
        textField.anchor(left: containerView.leftAnchor,bottom: containerView.bottomAnchor, right: containerView.rightAnchor)
        
        if withLabel != nil {
            let label = UILabel()
              label.text = withLabel
              label.font = UIFont.systemFont(ofSize: 12)
              label.textColor = .white
              containerView.addSubview(label)
              
              label.anchor(left : containerView.leftAnchor, bottom: textField.topAnchor,paddingLeft: 2,paddingBottom: 4)
        }
        let bottomLine = UILabel()
        bottomLine.backgroundColor = .white
        containerView.addSubview(bottomLine)
        
        bottomLine.anchor(top: textField.bottomAnchor, left :containerView.leftAnchor,right: containerView.rightAnchor, paddingTop : 4,width: containerView.frame.width,height: 0.75)
        
        return containerView
    }
    
    func createtextField(withPlaceholder : String, isSecureType : Bool, addBorder : Bool = false) -> UITextField {
        
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .white
        tf.isSecureTextEntry = isSecureType
        tf.borderStyle = .none
        tf.attributedPlaceholder = NSAttributedString(string: withPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        tf.autocapitalizationType = .none
        
        if addBorder {
            
            let bottomLine = UILabel()
            bottomLine.backgroundColor = .white
            tf.addSubview(bottomLine)
            
            bottomLine.anchor(top: tf.bottomAnchor, left :tf.leftAnchor,right: tf.rightAnchor, paddingTop : 4,width: tf.frame.width,height: 0.75)
            return tf
        }
        
        return tf
        
    }
}

extension NSAttributedString.Key {

  static var overlayAttributes: [NSAttributedString.Key: Any] = [
    // swiftlint:disable:next force_unwrapping
    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 42)!,
    NSAttributedString.Key.kern: 5.0
  ]
    
    static var shadowAttribute: NSShadow = {
      let shadow = NSShadow()
      shadow.shadowOffset = CGSize(width: 0, height: 1)
      shadow.shadowBlurRadius = 2
      shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
      return shadow
    }()

    static var titleAttributes: [NSAttributedString.Key: Any] = [
      // swiftlint:disable:next force_unwrapping
      NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 24)!,
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]

    static var subtitleAttributes: [NSAttributedString.Key: Any] = [
      // swiftlint:disable:next force_unwrapping
      NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)!,
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
}

