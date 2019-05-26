//
//  SignInViewController.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 4/7/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import TwitterKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //@IBOutlet weak var signInButton: GIDSignInButton!
    //@IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    private var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Para evitar que el teclado se siga mostrando en la pantalla cuando toques en otro lado
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        /* Por si hay una tabla :9
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(NSMutableAttributedString.endEditing))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        */
        
        //GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()

    }
    
    func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        //Se muestra cuando la aplicación ya está cargada
        viewModel.authAccountKit(sender: self) { (succes, error) in
            
        }
    }*/
    
    
    @IBAction func signIn(_ sender: Any) {
        //This is the email sign in
        SignInViewModel.signInWith(email: emailTextField.text, password: passwordTextField.text) { [weak self] (success, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success{
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
        /*"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
         Regular expression for e-mail*/
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        //This is the Facebook SignIn
        SignInViewModel.facebookLogin(viewController: self) { [weak self] (success, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success{
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    @IBAction func authWithTwitter(_ sender: Any) {
        SignInViewModel.authWithTwitter { [weak self] (success, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success{
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Click en cualquier parte oculta el teclado
        view.endEditing(true)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Desaparece cuando das enter
        self.view.endEditing(true)
        
        return true
    }
    
    
}
