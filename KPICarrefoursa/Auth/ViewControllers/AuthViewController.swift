//
//  AuthViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.10.2022.
//

import UIKit
import CryptoSwift

class AuthViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var passwordİmage: UIImageView!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var rememberİmage: UIImageView!
    
    //MARK: Properties
    
    var userDC: String = ""
    var jsonmessage = 1
    let username = ""
    let password = ""
    var isActive: Bool = true
    var isGradientAdded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accountTextField.addDoneButtonOnKeyboard()
        self.passwordTextField.addDoneButtonOnKeyboard()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        //        self.accountTextField.text = "mert.yildiz@bilmsoft.com"
        //        self.passwordTextField.text = "BilmSoft2209"
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            rememberİmage.image = UIImage(systemName: "checkmark.square.fill")
            self.accountTextField.text = UserDefaults.standard.string(forKey: "account")
            self.passwordTextField.text = UserDefaults.standard.string(forKey: "password")
            isActive = false
            loginButton.isEnabled = true
            
        }
  
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.authRadius()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.accountTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    
    func authRadius() {
        self.loginView.layer.cornerRadius = 12
        self.accountView.layer.cornerRadius = 12
        self.passwordView.layer.cornerRadius = 12
        self.loginButtonView.dropShadow(cornerRadius: 12)
        self.loginButtonView.applyGradient(colors: [UIColor(red:0/255, green:71/255, blue:151/255, alpha: 1),  UIColor(red:0/255, green:120/255, blue:255/255, alpha: 1), UIColor(red:0/255, green:71/255, blue:151/255, alpha: 1)] )

        
        self.rememberButton.layer.cornerRadius = 4
        self.rememberButton.layer.borderWidth = 1
        self.rememberButton.layer.borderColor = UIColor.gray.cgColor
        self.passwordİmage.image = UIImage(systemName: "eye.slash")
        if accountTextField.text == "" {
            self.loginButtonView.alpha = 0.5
            loginButton.isEnabled = false
        } else {
            self.loginButtonView.alpha = 1
            loginButton.isEnabled = true
        }
    }
    
    @IBAction func passwordCheck(_ sender: Any) {
        if accountTextField.text?.count ?? 0 >= 6 && passwordTextField.text?.count ?? 0 > 3 {
            loginButtonView.alpha = 1.0
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
            self.loginButtonView.alpha = 1
        }else {
            loginButtonView.alpha = 0.5
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
            
        }
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
    func checkPassword() {
        self.loginButton.isEnabled = false
        let authParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"Username\": \"\(self.accountTextField.text ?? "")\",\"Password\": \"\(self.passwordTextField.text ?? "")\"}"
        User.username = self.accountTextField.text ?? ""
        User.password = self.passwordTextField.text ?? ""
        UserDefaults.standard.set(accountTextField.text, forKey: "account")
        UserDefaults.standard.set(passwordTextField.text, forKey: "password")
        let enUrlParams = try! authParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        let url = URL(string: MemberUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = stringRequest.data(using: String.Encoding.utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
            }
            if let responseString = String(data: data, encoding: .utf8) {
                //                print("responseString = \(String(describing: responseString))")
                self.userDC = responseString
                self.userDC = try! self.aesDecrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
                let data: Data? = self.userDC.data(using: .utf8)
                let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:AnyObject]
                print(json ?? "Empty Data")
                if json!["Success"] as? Int ?? 0 ==  0 {
                    
                    DispatchQueue.main.async {
                        
                        let story = UIStoryboard(name: "Alert", bundle: nil)
                        let controller = story.instantiateViewController(identifier: "CustomAlertView") as! CustomAlertView
                        self.addChild(controller)
                        self.view.addSubview(controller.view)
                        controller.didMove(toParent: self)
                    }
                    
                } else if json!["Success"] as? Int ?? 0 == 1 && json!["isOtp"] as? Int ?? 0 == 0 && json!["isConfirm"] as? Int ?? 0 == 0 {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "sendMain", sender: self)
                    }
                }else if json!["Success"] as? Int ?? 0 == 1 && json!["isOtp"] as? Int ?? 0 == 1 && json!["isConfirm"] as? Int ?? 0 == 0 {
                    self.login()
                    
                    
                } else if json!["Success"] as? Int ?? 0 == 1 && json!["isConfirm"] as? Int ?? 0 == 1 && json!["isOtp"] as? Int ?? 0 == 0 {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "sendConfirm", sender: self)
                    }
                }
            }
        })
        task.resume()
    }
    func login(){
        
        DispatchQueue.main.async {
            
            if self.jsonmessage == 1 {
                self.performSegue(withIdentifier: "sendOtpCheck", sender: self)
                
            }
            else if self.accountTextField.text == "" || self.passwordTextField.text == "" {
                let alert = UIAlertController(title: "Don't empty the field", message: "Please enter again", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else if self.jsonmessage == 0
            {
                let alert = UIAlertController(title: "ID OR PASSWORD ERROR", message: "Please enter again", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        self.checkPassword()
    }
    
    @IBAction func rememberBtnPressed(_ sender: UIButton) {
        
        if isActive {
            isActive = false
            UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            rememberİmage.image = UIImage(systemName: "checkmark.square.fill")
        }
        else {
            isActive = true
            UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
            UserDefaults.standard.set("", forKey: "account")
            UserDefaults.standard.set("", forKey: "password")
            rememberİmage.image = UIImage(systemName: "")
    }
}

@IBAction func LoginTextFieldPressed(_ sender: Any) {
    self.accountTextField.becomeFirstResponder()
}
@IBAction func passwordTextFieldPressed(_ sender: Any) {
    self.passwordTextField.becomeFirstResponder()
}
@IBAction func passwordBtnPressed(_ sender: UIButton) {
    if self.passwordİmage.image == UIImage(systemName: "eye.slash") {
        self.passwordTextField.isSecureTextEntry = false
        self.passwordİmage.image = UIImage(systemName: "eye")
        
    } else if self.passwordİmage.image == UIImage(systemName: "eye") {
        self.passwordİmage.image = UIImage(systemName: "eye.slash")
        self.passwordTextField.isSecureTextEntry = true
        
    }
    
}
}



