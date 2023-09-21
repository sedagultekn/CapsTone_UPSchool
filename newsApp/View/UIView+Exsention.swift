//
//  UIView+Exsention.swift
//  newsApp
//
//  Created by Seda Gültekin on 9.09.2023.
//


import UIKit
extension UIView{
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
