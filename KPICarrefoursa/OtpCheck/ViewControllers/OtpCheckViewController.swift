//
//  OtpCheckViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.10.2022.
//

import UIKit
import CryptoSwift



class OtpCheckViewController: UIViewController, UITextFieldDelegate {
    
    //    func didChangeValidity(isValid: Bool) {
    //        otpButton.isHidden = !isValid
    //    }
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var otpButton: UIButton!
    @IBOutlet weak var otpButtonView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var resendView: UIView!
    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var otpContainerView: UIView!
    
    var jsonmessage: Int = 1
    var userDC: String = ""
    var counter = 120
    var timer = Timer()
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    let otpStackView = OTPStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.otpButtonView.dropShadow(cornerRadius: 12)
        self.loginView.dropShadow(cornerRadius: 12)
        otpContainerView.addSubview(otpStackView)
        otpStackView.delegate = self
        otpStackView.heightAnchor.constraint(equalTo: otpContainerView.heightAnchor).isActive = true
        otpStackView.centerXAnchor.constraint(equalTo: otpContainerView.centerXAnchor).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: otpContainerView.centerYAnchor).isActive = true
        self.phoneLabel.text = User.phoneNumber
        resendtimer()
    }
    
    func resendtimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    @objc func timerAction() {
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
        })
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
    

    override func dismissKeyboard() {
        self.view.endEditing(true)
    }
    //    MARK: Decrypt
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
    func checkOtp() {
        let otpParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"Username\": \"\(User.username)\",\"Code\": \"\(User.otp)\"}"
        let enUrlParams = try! otpParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        let url = URL(string: OtpUrl)!
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
                if json!["Success"] as? Int ?? 0 ==  0{
                    
                    DispatchQueue.main.async {
                        
                        let story = UIStoryboard(name: "OtpAlert", bundle: nil)
                        let controller = story.instantiateViewController(identifier: "OtpAlertViewController") as! OtpAlertViewController
                        self.addChild(controller)
                        self.view.addSubview(controller.view)
                        controller.didMove(toParent: self)
                    }
                    
                } else if json!["Success"] as? Int ?? 0 == 1 {
                    User.JWT = json!["Jwt"] as? String ?? ""
                    print(User.JWT)
                    self.login()
                }
            }
        })
        task.resume()
    }
    func login(){
        
        DispatchQueue.main.async {
            
            if self.jsonmessage == 1 {
                
                self.performSegue(withIdentifier: "sendMain", sender: self)
            }
            else {
                
            }
            
        }
    }
    
    @IBAction func resendBtnPressed(_ sender: Any) {
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
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        print("Final OTP : ",otpStackView.getOTP())
        self.checkOtp()
    }
}
//extension StringProtocol {
//    subscript(offset: Int) -> Element {
//        return self[index(startIndex, offsetBy: offset)]
//    }
//    subscript(_ range: Range<Int>) -> SubSequence {
//        return prefix(range.lowerBound + range.count)
//            .suffix(range.count)
//    }
//    subscript(range: ClosedRange<Int>) -> SubSequence {
//        return prefix(range.lowerBound + range.count)
//            .suffix(range.count)
//    }
//    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
//        return prefix(range.upperBound.advanced(by: 1))
//    }
//    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
//        return prefix(range.upperBound)
//    }
//    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
//        return suffix(Swift.max(0, count - range.lowerBound))
//    }
//}
//extension BidirectionalCollection {
//    subscript(safe offset: Int) -> Element? {
//        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
//        return self[i]
//    }
//}
extension OtpCheckViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
     
    }
}

