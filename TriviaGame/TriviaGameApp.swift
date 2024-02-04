//
//  TriviaGameApp.swift
//  TriviaGame
//
//  Created by kuet on 8/11/23.
//

import SwiftUI
import Firebase

@main
struct TriviaGameApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //Home()
            
            ContentView()
            //AddQuiz()
//                .onAppear {
//
//                    FirebaseApp.configure()
//                    print("Configured Firebase")
//                            // Check Firebase initialization here
//                            if FirebaseApp.app() == nil {
//                                print("Firebase is not initialized!")
//                            } else {
//                                print("Firebase is initialized!")
//                            }
//                        }
                
        }
    }
}

class AppDelegate:NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        FirebaseApp.configure()
        print("Firebase configured successfully")
        return true
    }
}
