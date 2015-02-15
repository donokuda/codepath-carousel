//
//  SignInViewController.swift
//  carousel
//
//  Created by Don Okuda on 2/14/15.
//  Copyright (c) 2015 donokuda. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signInForm: UIView!
    @IBOutlet weak var signInActions: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var originalSignInFormY: CGFloat = 0
    var originalSignInActionsY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        originalSignInFormY = signInForm.center.y
        originalSignInActionsY = signInActions.center.y
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onSignInTapped(sender: AnyObject) {
        view.endEditing(false)
        
        if (emailTextField.text.isEmpty) {
            var alertView = UIAlertView(title: "Email Required", message: "Please enter your email address", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
        } else if (passwordTextField.text.isEmpty) {
            var alertView = UIAlertView(title: "Password Required", message: "Please enter your password", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
        } else {
            var alertView = UIAlertView(title: "Signing In", message: nil, delegate: nil, cancelButtonTitle: nil)
            alertView.show()
            
            delay(2.0) { _ in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
                if (self.emailTextField.text == "don@test.com" && self.passwordTextField.text == "password") {
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                } else {
                    UIAlertView(title: "Unable to Sign In", message: "Incorrect email or passowrd", delegate: self, cancelButtonTitle: "OK").show()
                }
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        animateAlongsideKeyboardAnimation(notification) { keyboardHeight in
            self.signInActions.center.y = self.originalSignInActionsY - keyboardHeight
            self.signInForm.center.y = self.originalSignInFormY - 74
        }
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        animateAlongsideKeyboardAnimation(notification) { _ in
            self.signInActions.center.y = self.originalSignInActionsY
            self.signInForm.center.y = self.originalSignInFormY
        }
    }
    
    func animateAlongsideKeyboardAnimation(notification: NSNotification!, animations: (keyboardHeight: CGFloat) -> ()) {
        var userInfo = notification.userInfo!
        
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            animations(keyboardHeight: kbSize.height)
        }, completion: nil)
    }
}