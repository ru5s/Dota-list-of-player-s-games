//
//  Dota_DairyApp.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      UITabBar.appearance().isTranslucent = true
      UITabBar.appearance().backgroundColor = UIColor.active
      UITabBar.appearance().barTintColor = UIColor.active
      UITabBar.appearance().unselectedItemTintColor = UIColor.ddWhite.withAlphaComponent(0.5)
      UITabBar.appearance().isTranslucent = true
      
      return true
  }
}

@main
struct Dota_DairyApp: App {
    let persistenceController = CoreDataManager.shared
    @ObservedObject var model = RootVM()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            VStack(content: {
                if let event = model.event {
                    SplashV(event: event)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
            )
            .ignoresSafeArea()
            .onAppear(perform: {
                model.eventRequest { event in
                    model.event = event
                }
            })
        }
    }
}
