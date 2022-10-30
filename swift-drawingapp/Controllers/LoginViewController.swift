//
//  LoginViewController.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/25.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    
    func loginViewController(_ viewController: LoginViewController, loginWithID: String)
}

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLoginButton(_ button: UIButton) {
        guard let id = textField.text else { return }
        delegate?.loginViewController(self, loginWithID: id)
        dismiss(animated: true)
    }
}
