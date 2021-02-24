//
//  AlertUtils.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-15.
//

import Foundation
import UIKit

// Code to show UIAlert
struct Alert {

    func show(_ alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
            
        }
        
    }

    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive}
        .compactMap {$0 as? UIWindowScene}
        .first?.windows.filter {$0.isKeyWindow}.first
        
    }

    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
            
        }
        return topMostViewController(for: rootController)
        
    }

    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
            
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
                
            }
            
            return topMostViewController(for: topController)
            
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
                
            }
            return topMostViewController(for: topController)
            
        }
        return controller
        
    }
    
}
