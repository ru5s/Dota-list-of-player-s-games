//
//  SettingsVM.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import StoreKit
import SwiftUI

class SettingsVM: ObservableObject {
    func rateApp() {
        DispatchQueue.main.async {
            let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive})
            SKStoreReviewController.requestReview(in: scene as! UIWindowScene)
        }
        
    }
    
    func sharedApp() {
        DispatchQueue.main.async {
            let appStoreURL = URL(string: "https://apps.apple.com")!
            let activityViewController = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY / 2, width: 0, height: 0)
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func deleteAllData() {
        CoreDataManager.shared.removeAllFromEntity(entityName: .match)
        CoreDataManager.shared.removeAllFromEntity(entityName: .tournament)
        let userDefaults = UserDefaults()
        userDefaults.setValue("0", forKey: "ended tournaments")
        userDefaults.setValue("0", forKey: "Victories")
        userDefaults.setValue("0", forKey: "Defeats")
    }
}
