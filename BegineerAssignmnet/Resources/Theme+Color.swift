//
//  Theme+Color.swift
//  BegineerAssignmnet
//
//  Created by elesahich on 2021/04/21.
//

import UIKit

struct Theme {
  enum Colors {
    enum Background {
      static var primary: UIColor {
        return .findProperColor(lightModeColor: .white, darkModeColor: .black)
      }
      
      static var container: UIColor {
        return UIColor.lightGray.withAlphaComponent(0.4)
      }
    }
    
    enum Texts {
      static var primary: UIColor {
        return .findProperColor(lightModeColor: .black, darkModeColor: .white)
      }
      
      static var secondary: UIColor {
        return .systemGray
      }
    }
    
    enum Components {
      static var primary: UIColor {
        return .systemTeal
      }
      
      static var foreground: UIColor {
        return .black
      }
    }
    
    enum PrimaryColor {
      static var mainColor: UIColor {
        return UIColor.systemGray.withAlphaComponent(0.6)
      }
    }
  }
}

private extension UIColor {
  static func findProperColor(lightModeColor: UIColor, darkModeColor: UIColor) -> UIColor {
    if #available(iOS 13.0, *) {
      return UIColor { (traits) -> UIColor in
        return (traits.userInterfaceStyle == .dark) ? darkModeColor : lightModeColor
      }
    } else {
      return lightModeColor
    }
  }
}
