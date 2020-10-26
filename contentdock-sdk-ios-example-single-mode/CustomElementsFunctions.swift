

import UIKit
import CDockFramework

@objc(CustomElementsFunctionsSwift)

/**
 In this class you can handle callback from ContentDock SDK
 */
class CustomElementsFunctionsSwift: NSObject {
    

    /**
     This function calls when user custom elements initilized.
     Name of this function you can set in ContentDock admin panel
     - parameters:
        - elementView: UIView for your custom element
     */
    @objc class func myElementFunction(_ elementView: UIView) {
        
    }
    
    
    /**
     Calls when user custom element been layouted(size changed, positions change and etc...)
     - parameters:
        - elementView: UIView for your redrawed element
     */
    @objc class func layoutSubviews(_ elementView: UIView) {

    }
    
    
    /**
     Calls before device will rotate.
     - parameters:
        - orientation: Orientation that device will rotate to. You can use it as
        UIInterfaceOrientation(rawValue: orientation.intValue)
     */
    @objc class func willRotateTo(_ orientation: NSNumber) {
        if let newOrientation: UIInterfaceOrientation = UIInterfaceOrientation(rawValue: orientation.intValue) {
            if newOrientation == .landscapeLeft || newOrientation == .landscapeRight {
                //do something cool
            }
        }
    }
    
    
    /**
     Calls after device been  rotated.
     */
    @objc class func didRotate() {
        if UIDevice.current.orientation.isLandscape {
            //do something cool
        } else {
            //do something others cool
        }
    }
    
    
    /**
     Calls if project need login.
     - parameters:
        - loginView: UIView where you can draw your own login UI
        After you get login info from user, call please CDockSDK.login(...)
     */
    @objc class func SDKLogin(_ loginView: UIView) {
        let v = VLogin(frame: loginView.bounds)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loginView.addSubview(v)
    }
}


class VLogin: UIView {
    
    let tfLogin = UITextField()
    let tfPassword = UITextField()
    
    let lblHeadline = UILabel()
    let lblLogin = UILabel()
    let lblPassword = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        
        lblHeadline.frame = CGRect(x: 0, y: 20, width: self.width(), height: 40)
        lblHeadline.textAlignment = .center
        lblHeadline.text = "сontentDock® SDK Example Single Mode"
        lblHeadline.backgroundColor = UIColor.clear
        lblHeadline.setCenterX(self.width()/2)
        self.addSubview(lblHeadline)
        
        
        lblLogin.frame = CGRect(x: 10, y: 90, width: 200, height: 40)
        lblLogin.text = "User name"
        lblLogin.backgroundColor = UIColor.clear
        lblLogin.setCenterX(self.width()/2)
        self.addSubview(lblLogin)
        
        
        tfLogin.frame = CGRect(x: 10, y: 130, width: 200, height: 40)
        tfLogin.backgroundColor = UIColor.white
        tfLogin.setCenterX(self.width()/2)
        tfLogin.borderStyle = .line
        self.addSubview(tfLogin)
        
        lblPassword.frame = CGRect(x: 10, y: 170, width: 200, height: 40)
        lblPassword.text = "Password"
        lblPassword.backgroundColor = UIColor.clear
        lblPassword.setCenterX(self.width()/2)
        self.addSubview(lblPassword)
        
        tfPassword.frame = CGRect(x: 220, y: 210, width: 200, height: 40)
        tfPassword.isSecureTextEntry = true
        tfPassword.backgroundColor = UIColor.white
        tfPassword.setCenterX(self.width()/2)
        tfPassword.borderStyle = .line
        self.addSubview(tfPassword)
        
        
        
        let btnLogin = UIButton(type: .system)
        btnLogin.frame = CGRect(x: 10, y: 280, width: 200, height: 50)
        btnLogin.setTitle("login", for: .normal)
        btnLogin.addTarget(self, action: #selector(self.onBtnLoginTapped), for: UIControl.Event.touchUpInside)
        btnLogin.setCenterX(self.width()/2)
        
        self.addSubview(btnLogin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onBtnLoginTapped() {
        CDockSDK.login(with: tfLogin.text ?? "", password: tfPassword.text ?? "", domain: CDockSDK.domain() ?? "") { isSuccess in
            if isSuccess == false {
                let alert = UIAlertController(title: "Login", message: "Login failed!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true);
            }
        }
    }
}


