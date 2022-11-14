//
//  ConfirmViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 8.10.2022.
//

import UIKit
import CryptoSwift

class ConfirmViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var phoneButtonView: UIView!
    @IBOutlet weak var confirmView: UIView!
    
    //MARK: Properties
    var jsonmessage: Int = 1
    var userDC: String = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.phoneView.layer.cornerRadius = 12
        self.confirmView.dropShadow(cornerRadius: 12)
        self.phoneButtonView.dropShadow(cornerRadius: 12)
        self.phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
    }
  
    //    MARK: Decrypt
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
    func checkPhoneNumber() {
        let confirmParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"CodeId\": 0,\"SmsCode\": \"\",\"Username\": \"\(User.username)\",\"PhoneNumber\": \"\(self.phoneNumberTextField.text ?? "")\"}"
        print(confirmParameters)
        User.phoneNumber = self.phoneNumberTextField.text ?? ""
        let enUrlParams = try! confirmParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        let url = URL(string: Confirm)!
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
                print("responseString = \(String(describing: responseString))")
                self.userDC = responseString
                self.userDC = try! self.aesDecrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
                print(self.userDC)
                let data: Data? = self.userDC.data(using: .utf8)
                let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:AnyObject]
                print(json ?? "Empty Data")
                User.CodeId = json!["CodeId"] as? Int ?? 0
                print(User.CodeId)
                if json!["Success"] as? Int ?? 0 ==  0{
                    print("error")
                } else if json!["Success"] as? Int ?? 0 == 1 {
                    self.otp()
                    
                }
            }
        })
        task.resume()
    }
    func otp(){
        
        DispatchQueue.main.async {
            
            if self.jsonmessage == 1 {
                
                self.performSegue(withIdentifier: "sendOtp", sender: self)
            }
            else if self.phoneNumberTextField.text == ""  {
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
    
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
        self.checkPhoneNumber()
    }
}

