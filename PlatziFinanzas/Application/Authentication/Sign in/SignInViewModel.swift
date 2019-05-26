//
//  SignInViewModel.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 4/7/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit
import AccountKit
import TwitterKit

typealias SignInHandler = ( (_ success: Bool ,_ error: Error? ) -> Void)

class SignInViewModel : NSObject {
    
    private var handler: SignInHandler?

    static func signInWith(email: String?, password: String?, handler: SignInHandler?) {
        
        guard let email = email, validateAuth(text: email, regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}") else {
            return
        }
        
        guard let password = password, validateAuth(text: password, regex: ".{8}") else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                handler?(false, error)
            }
            
            if result != nil {
                handler?(true, nil)
            }
        }
    }
    
    static private func validateAuth(text: String, regex: String) -> Bool {
        let range = NSRange(location: 0, length: text.count)
        let regex = try? NSRegularExpression(pattern: regex, options: [])
        return regex?.firstMatch(in: text, options: [], range: range) != nil
    }
    
    static func facebookLogin(viewController: UIViewController, handler: SignInHandler?) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: viewController) { (result, error) in
            if let error = error {
                handler?(false, error)
                return
            }
            
            guard let token = FBSDKAccessToken.current()?.tokenString else { return }
            
            let credentials = FacebookAuthProvider.credential(withAccessToken: token)
            
            Auth.auth().signInAndRetrieveData(with: credentials, completion: { (authResult, error) in
                if let error = error {
                    handler?(false, error)
                    return
                }
                
                handler?(true, nil)
            })
        }
    }
    
    static func authWithTwitter(handler: SignInHandler?) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            guard let session = session else {
                handler?(false, nil)
                return
            }
            
            let authToken = session.authToken
            let authSecret = session.authTokenSecret
            
            let credentials = TwitterAuthProvider.credential(
                                                             withToken: authToken,
                                                             secret: authSecret)
            
            Auth.auth().signInAndRetrieveData(with: credentials, completion: { (result, error) in
                if let error = error {
                    handler?(false, error)
                    return
                }
                handler?(true, nil)
            })
        }
    }
    
    /*
    func authAccountKit(sender: UIViewController, handler: SignInHandler?) {
        self.handler = handler
        let viewController = AKFAccountKit(responseType: .accessToken).viewControllerForPhoneLogin() as AKFViewController
        
        viewController.delegate = self
        
        guard let normalView = viewController as? UIViewController else {
            return
        }
        
        sender.present(normalView, animated: true, completion: nil)
    }*/
}

extension SignInViewModel: AKFViewControllerDelegate {
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        let token = accessToken.tokenString
        
        let accountKit = AKFAccountKit(responseType: .accessToken)
        accountKit.requestAccount { [weak self] (account, error) in
            if let error = error {
                self?.handler?(false, error)
                return
            }
            
            guard let phoneNumber = account?.phoneNumber?.phoneNumber else { return }
            self?.handler?(true, nil)
        }
    }
}
