//
//  ConfirmToOtpViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 10.10.2022.
//

import UIKit
import CryptoSwift

class ConfirmToOtpViewController: UIViewController, UITextFieldDelegate, ConfirmDelegate {
    
    //MARK: Outlets

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var loginViewDetail: UIView!
    @IBOutlet weak var otpButtonDetail: UIButton!
    @IBOutlet weak var otpButtonViewDetail: UIView!
    @IBOutlet weak var phoneLabelDetail: UILabel!
    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var resendView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var ConfirmContainerView: UIView!
    //MARK: Properties
  
    
    var jsonmessage: Int = 1
    var userDC: String = ""
    var counter = 120
    var timer = Timer()
    let otpStackView = ConfirmStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        ConfirmContainerView.addSubview(otpStackView)
        otpStackView.delegate = self
        otpStackView.heightAnchor.constraint(equalTo: ConfirmContainerView.heightAnchor).isActive = true
        otpStackView.centerXAnchor.constraint(equalTo: ConfirmContainerView.centerXAnchor).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: ConfirmContainerView.centerYAnchor).isActive = true
        self.otpButtonViewDetail.dropShadow(cornerRadius: 12)
        self.otpButtonViewDetail.applyGradient(colors: [UIColor(red:0/255, green:71/255, blue:151/255, alpha: 1),  UIColor(red:0/255, green:120/255, blue:255/255, alpha: 1), UIColor(red:0/255, green:71/255, blue:151/255, alpha: 1)] )
        self.loginViewDetail.layer.cornerRadius = 12

//        self.phoneLabelDetail.text = User.phoneNumber
        resendtimer()
    }
    
    
    func resendtimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        
        counter -= 1
        timerLabel.text = "\(counter)s"
        if timerLabel.text == "\(0)s" {
            infoLabel.isHidden = false
            resendLabel.isHidden = false
            resendButton.isHidden = false
            timerLabel.isHidden = true
            resendView.isHidden = false
            timer.invalidate()
        }
    }
   
    
    //    MARK: Decrypt
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
    
    func checkOtpDetail() {
        let otpParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"CodeId\": \(User.CodeId),\"Username\": \"\(User.username)\",\"SmsCode\": \"\(User.otp)\",\"PhoneNumber\": \"\(User.phoneNumber)\"}"
        print(otpParameters)
        let enUrlParams = try! otpParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        let url = URL(string: Confirm)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = stringRequest.data(using: String.Encoding.utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(User.mobilJWT)", forHTTPHeaderField: "Authorization")
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
                if json!["Success"] as? Int ?? 0 ==  0{
                    print("error")
                } else if json!["Success"] as? Int ?? 0 == 1 {
                    User.JWT = json!["Jwt"] as? String ?? ""
                    print(User.JWT)
                    self.login()
                    self.timer.invalidate()
                }
                
            }
        })
        task.resume()
    }
    func login(){
        
        DispatchQueue.main.async {
            
            if self.jsonmessage == 1 {
                
                self.performSegue(withIdentifier: "sendMain", sender: self)
            } else {
                
            }
        
        }
    }
    
    @IBAction func resendBtnPressedDetail(_ sender: Any) {
        let resendParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"Username\": \"\(User.username)\",\"PhoneNumber\": \"\(User.phoneNumber)\"}"
        print(resendParameters)
        let url = URL(string: ResendCode)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let enUrlParams = try! resendParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
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
                if json!["Success"] as? Int ?? 0 ==  0{
                    print("error")
                } else if json!["Success"] as? Int ?? 0 == 1 {
                    User.JWT = json!["Jwt"] as? String ?? ""
                    print(User.JWT)
                    
                    DispatchQueue.main.async {
                        self.counter = 120
                        self.infoLabel.isHidden = true
                        self.resendLabel.isHidden = true
                        self.resendButton.isHidden = true
                        self.timerLabel.isHidden = false
                        self.resendView.isHidden = true
                        self.resendtimer()
                    }
                }
            }
        })
        task.resume()
    }
    
    
    @IBAction func loginBtnPressedDetail(_ sender: Any) {
        print("Final OTP : ",otpStackView.getOTP())
        self.checkOtpDetail()
    }
}
extension ConfirmToOtpViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
     
    }
}




