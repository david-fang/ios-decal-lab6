//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    
    var titleLabel: UILabel!
    var usernameTextfield: UITextField!
    var passwordTextfield: UITextField!
    var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 0.7, height: 100))
        titleLabel.text = "Login View Controller"
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        
        usernameTextfield = UITextField()
        usernameTextfield.placeholder = "berkeley.edu account"
        
        passwordTextfield = UITextField()
        passwordTextfield.placeholder = "Password"
        
        loginButton = UIButton()
        loginButton.backgroundColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        loginButton.tintColor = UIColor.white
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        
        contentView.addSubview(usernameTextfield)
        contentView.addSubview(passwordTextfield)
        contentView.addSubview(loginButton)
        
        view.addSubview(titleLabel)
        view.addSubview(contentView)
        
        // TODO: layout your views using frames or AutoLayout
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        let contentViewConstraints = [
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4)
        ]
        
        NSLayoutConstraint.activate(contentViewConstraints)

        let usernameTextfieldConstraints = [
            usernameTextfield.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            usernameTextfield.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            usernameTextfield.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            usernameTextfield.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(usernameTextfieldConstraints)
        
        let passwordTextfieldConstraints = [
            passwordTextfield.heightAnchor.constraint(equalTo: usernameTextfield.heightAnchor),
            passwordTextfield.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            passwordTextfield.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            passwordTextfield.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordTextfield.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(passwordTextfieldConstraints)
        
        let loginButtonConstraints = [
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            loginButton.heightAnchor.constraint(equalTo: usernameTextfield.heightAnchor),
            loginButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            loginButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(loginButtonConstraints)
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ]

        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    // TODO: create an IBAction for your login button
    
    
    func performLogin(sender: UIButton) {
        authenticateUser(username: usernameTextfield.text, password: passwordTextfield.text)
    }
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
