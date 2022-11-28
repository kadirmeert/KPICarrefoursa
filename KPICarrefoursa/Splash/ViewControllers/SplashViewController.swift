//
//  SplashViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 13.10.2022.
//

import UIKit
import CryptoSwift

class SplashViewController: UIViewController {
    
    var userDC: String = ""
    var splash = splashModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "sendAuth", sender: self)
//        self.checkMobilTokenData()
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
//    func checkMobilTokenData() {
//        let splashParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"Username\": \"ios\",\"Password\": \"P%(&FI6%(G1V4MtloM8$\"}"
//        let enUrlParams = try! splashParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
//        print(enUrlParams)
//        let stringRequest = "\"\(enUrlParams)\""
//        print(stringRequest)
//        let url = URL(string: AuthenticaUrl)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = stringRequest.data(using: String.Encoding.utf8)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//            guard let data = data, error == nil else {
//                print("error=\(String(describing: error))")
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(String(describing: response))")
//
//            }
//            if let responseString = String(data: data, encoding: .utf8) {
//                print("responseString = \(String(describing: responseString))")
//                self.userDC = responseString
//                self.userDC = try! self.aesDecrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
//                print(self.userDC)
//                let data: Data? = self.userDC.data(using: .utf8)
//                let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:AnyObject]
//                print(json ?? "Empty Data")
//                if json!["Success"] as? Int ?? 0 ==  0{
//                    print("error")
//                } else if json!["Success"] as? Int ?? 0 == 1 {
//
//                    DispatchQueue.main.async {
//                        User.mobilJWT =  json!["MobileToken"]? as String ?? ""
//
//                    }
//                }
//            }
//        })
//        task.resume()
    }



