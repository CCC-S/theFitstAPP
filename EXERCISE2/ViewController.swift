//
//  ViewController.swift
//  EXERCISE2
//
//  Created by empcjs chin on 2017/11/17.
//  Copyright © 2017年 empcjs chin. All rights reserved.
//

import UIKit
import Foundation

infix operator =~ : ATPrecedence
precedencegroup ATPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

//for regex matching
struct MyRegex {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern,
                                         options: .caseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input,
                                        options: [],
                                        range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}

func =~ (lhs: String, rhs: String) -> Bool {
    return MyRegex(rhs).match(input: lhs) //需要前面定义的MyRegex配合
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var profilePhoto: UIImage!
    let photoImageView = UIImageView(frame: CGRect(x:10, y:30, width:100, height:100))
    let IDTextField = UITextField(frame: CGRect(x:100, y: 120, width: 200, height: 30))
    let nameTextField = UITextField(frame: CGRect(x:100, y: 160, width: 110, height: 30))
    var dateTextField = UITextField(frame: CGRect(x:100, y: 200, width: 200, height: 30))
    
    let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:44))
    let doneToolBarButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done,target:self,action:#selector(ViewController.cancelDatePicker))
    let datePicker = UIDatePicker()
    
    let sexTextField = UITextField(frame: CGRect(x:220, y: 160, width: 80, height: 30))
    let sexPickerView = UIPickerView()
    let sexValue = ["MALE", "FEMALE", "UNKNOWN"]
    
    let schoolTextField = UITextField(frame: CGRect(x:100, y: 240, width: 200, height: 30))
    let schoolPickerView = UIPickerView()
    let schoolValue = ["SCHOOL1", "SCHOOL2","SCHOOL3"]
    
    
    let phoneNumTextField = UITextField(frame: CGRect(x:100, y: 280, width: 200, height: 30))
    let verificationCodeTextField = UITextField(frame: CGRect(x:100, y: 320, width: 130, height: 30))
    let getVCButton = UIButton(frame: CGRect(x: 240, y: 320, width: 60, height: 30))
    let regButton = UIButton(frame: CGRect(x: 40, y: 420, width: 240, height: 44))
    
    var verificationCode: UInt32 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        profilePhoto = UIImage(named: "b.png")
        photoImageView.image = profilePhoto
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = photoImageView.frame.width/2
        photoImageView.isUserInteractionEnabled = true
        self.view.addSubview(photoImageView)
        
        IDTextField.borderStyle = UITextBorderStyle.roundedRect
        IDTextField.placeholder = "Student ID"
        IDTextField.autocorrectionType = UITextAutocorrectionType.no
        IDTextField.returnKeyType = UIReturnKeyType.done
        IDTextField.keyboardType = UIKeyboardType.numberPad
        IDTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        IDTextField.delegate = self
        self.view.addSubview(IDTextField)
        
        
        nameTextField.borderStyle = UITextBorderStyle.roundedRect
        nameTextField.placeholder = "Name"
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        nameTextField.delegate = self
        self.view.addSubview(nameTextField)
        
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.placeholder = "Date Of Birth"
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolBar
        dateTextField.delegate = self
        self.view.addSubview(dateTextField)
        
        //set up the toolbar in the date picker view: add a button in it.
        toolBar.items = [doneToolBarButton]
        
        
        datePicker.datePickerMode = .date
        
        sexTextField.borderStyle = UITextBorderStyle.roundedRect
        sexTextField.placeholder = "Gender"
        sexTextField.autocorrectionType = UITextAutocorrectionType.no
        sexTextField.returnKeyType = UIReturnKeyType.done
        sexTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        sexTextField.delegate = self
        self.view.addSubview(sexTextField)
        sexPickerView.dataSource = self
        sexPickerView.delegate = self
        sexTextField.inputView = sexPickerView
        
        
        schoolTextField.borderStyle = UITextBorderStyle.roundedRect
        schoolTextField.placeholder = "School"
        schoolTextField.autocorrectionType = UITextAutocorrectionType.no
        schoolTextField.returnKeyType = UIReturnKeyType.done
        schoolTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        schoolTextField.delegate = self
        self.view.addSubview(schoolTextField)
        schoolPickerView.dataSource = self
        schoolPickerView.delegate = self
        schoolTextField.inputView = schoolPickerView
        


        phoneNumTextField.borderStyle = UITextBorderStyle.roundedRect
        phoneNumTextField.placeholder = "Phone Number"
        phoneNumTextField.autocorrectionType = UITextAutocorrectionType.no
        phoneNumTextField.returnKeyType = UIReturnKeyType.done
        phoneNumTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        phoneNumTextField.keyboardType = UIKeyboardType.numberPad
        phoneNumTextField.delegate = self
        self.view.addSubview(phoneNumTextField)

        verificationCodeTextField.borderStyle = UITextBorderStyle.roundedRect
        verificationCodeTextField.placeholder = "VC"
        verificationCodeTextField.autocorrectionType = UITextAutocorrectionType.no
        verificationCodeTextField.adjustsFontSizeToFitWidth = true
        verificationCodeTextField.returnKeyType = UIReturnKeyType.done
        verificationCodeTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        verificationCodeTextField.keyboardType = UIKeyboardType.numberPad
        verificationCodeTextField.delegate = self
        self.view.addSubview(verificationCodeTextField)
        
        let photoImageVIewTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.checkBigImage))
        photoImageView.addGestureRecognizer(photoImageVIewTap)
        
        getVCButton.setTitle("Get VC", for: UIControlState())
        getVCButton.backgroundColor = UIColor.black
        getVCButton.layer.cornerRadius = 5
        getVCButton.layer.borderWidth = 1
        getVCButton.layer.borderColor = UIColor.black.cgColor
        getVCButton.addTarget(self, action: #selector(ViewController.getVerificationCode), for: .touchUpInside)
        self.view.addSubview(getVCButton)

        
        regButton.setTitle("Register", for: UIControlState())
        regButton.backgroundColor = UIColor.black
        regButton.layer.cornerRadius = 5
        regButton.layer.borderWidth = 1
        regButton.layer.borderColor = UIColor.black.cgColor
        regButton.addTarget(self, action: #selector(ViewController.jumpToNewViewController), for: .touchUpInside)
        self.view.addSubview(regButton)
        
        self.hideKeyboardWhenTappedAround()
        
       
    }

    @objc
    func checkBigImage(){
        let bigImageView = UIImageView(image: profilePhoto)
        bigImageView.isUserInteractionEnabled = true
        bigImageView.tag = 100
        
        let pan = UIPanGestureRecognizer(target:self,action:#selector(ViewController.pan))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        bigImageView.addGestureRecognizer(pan)
        self.view.addSubview(bigImageView)
        
        let cancalBigImageVIewTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.cancalBigImage))
        bigImageView.addGestureRecognizer(cancalBigImageVIewTap)
    }
    
    @objc
    func pan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let myView = recognizer.view {
            myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
    
    @objc
    func cancalBigImage(){
        self.view.viewWithTag(100)?.removeFromSuperview()
    }
    
    @objc
    func jumpToNewViewController(){
        if phoneNumTextField.text! =~ "^[0-9]{11}$" {
            if nameTextField.text! =~ "[\u{4e00}-\u{9fa5}]{2,4}" {
                if self.IDTextField.text! =~ "^[0-9]{13}" {
                    if self.verificationCodeTextField.text! == String(verificationCode) {
                        let newViewController = TabBarController()
                        self.present(newViewController, animated: true, completion: nil)
                    }
                }
           }
        }
    }
    
    @objc
    func getVerificationCode(){
        if self.phoneNumTextField.text! =~ "^1[0-9]{10}$" {
            verificationCode = arc4random_uniform(900000) + 100000;
            print(verificationCode)
        }
    }
    
    
    
    @objc
    func cancelDatePicker(){
        if self.view.endEditing(false) {
            if self.view == sexPickerView || self.view == schoolPickerView {
                
            }
            else {
                let date = datePicker.date
                let dformatter = DateFormatter()
                dformatter.dateFormat = "yyyy/MM/dd"
                let datestr = dformatter.string(from: date)
                
                dateTextField.text = datestr
            }
        }
    }
    
    @objc
    func cancelOtherPicker(){
        self.view.endEditing(false)
    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        label.text = textField.text
//        return true
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sexPickerView {
            return sexValue.count
        }
        else if pickerView == schoolPickerView{
            return schoolValue.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView == sexPickerView {
            return sexValue[row]
        }
        else if pickerView == schoolPickerView{
            return schoolValue[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        if pickerView == sexPickerView {
            sexTextField.text = sexValue[row]
        }
        else if pickerView == schoolPickerView{
            schoolTextField.text = schoolValue[row]
        }
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

