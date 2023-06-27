//
//  MapCoordinatesCalculationViewController.swift
//  HW#29_MapCoordinatesCalculation
//
//  Created by Dawei Hao on 2023/6/15.
//

import UIKit
import MapKit

class MapCoordinatesCalculationViewController: UIViewController, UITextFieldDelegate {
    
    let ddTextField = UITextField()
    let ddTextFieldOne = UITextField()
    let dmmTextFieldOne = UITextField()
    let dmmTextFieldTwo = UITextField()
    let dmmTextFieldThree = UITextField()
    let dmmTextFieldFour = UITextField()
    let dmsTextFieldOne = UITextField()
    let dmsTextFieldTwo = UITextField()
    let dmsTextFieldThree = UITextField()
    let dmsTextFieldFour = UITextField()
    let dmsTextFieldFive = UITextField()
    let dmsTextFieldSix = UITextField()
    let annotationTitle = UITextField()
    
    let mkMapView = MKMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateUITwo()
        updateUIThree()
        mkMapViewUpdateUI()
        
        ddTextField.delegate = self
        ddTextFieldOne.delegate = self
        dmmTextFieldOne.delegate = self
        dmmTextFieldTwo.delegate = self
        dmmTextFieldThree.delegate = self
        dmmTextFieldFour.delegate = self
        dmsTextFieldOne.delegate = self
        dmsTextFieldTwo.delegate = self
        dmsTextFieldThree.delegate = self
        dmsTextFieldFour.delegate = self
        dmsTextFieldFive.delegate = self
        dmsTextFieldSix.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //緯度轉換
    func coordinatesConverter () {
        if let latitudeDegree = Double(ddTextField.text ?? ""),
           let longtitudeDegree = Double(ddTextFieldOne.text ?? "") {
            let doubleLatitude = Double(latitudeDegree)
            let doubleLongtitude = Double(longtitudeDegree)
            let integerLatitude = Int(doubleLatitude)
            let integerLongtitude = Int(doubleLongtitude)
            let decimalLongtitude = ((doubleLongtitude) - Double(integerLongtitude)) * 60
            let decimalLatitude = ((doubleLatitude) - Double(integerLatitude)) * 60
            
            //計算秒
            let integerValueForSec = Int(decimalLongtitude)
            let secondLongtitude = (decimalLongtitude - Double(integerValueForSec)) * 60
            
            let integerValueForSecond = Int(decimalLatitude)
            let secondLatitude = (decimalLatitude - Double(integerValueForSecond)) * 60
            
            //DD
            //DD緯度換算
            dmmTextFieldOne.text = String(integerLatitude)
            //DD緯分換算
            dmmTextFieldTwo.text = String(format: "%.3f", floor(decimalLatitude * 100) / 100)
            
            //DMS
            //DMS緯度換算
            dmsTextFieldOne.text = String(integerLatitude)
            //DMS緯分換算
            dmsTextFieldTwo.text = String(format: "%.0f", floor(decimalLatitude * 100) / 100)
            //DMS緯秒換算
            dmsTextFieldThree.text = String(format: "%.2f", floor(secondLatitude * 100 ) / 100)
            
            //DMM
            //DMM經度換算
            dmmTextFieldThree.text = String(integerLongtitude)
            //DMM經分換算
            dmmTextFieldFour.text = String(format: "%.3f", floor(decimalLongtitude * 100) / 100 )
            
            //DMS
            //DMS度分的經度換算
            dmsTextFieldFour.text = String(integerLongtitude)
            //DMS經分換算
            dmsTextFieldFive.text = String(format: "%.0f", floor(decimalLongtitude * 10) / 10)
            //DMS經秒換算
            dmsTextFieldSix.text = String(format: "%.1f", floor(secondLongtitude * 100) / 100 )
        } else { print("Converter input error ")  }
    }
    
    func coordinatesConverterSec () {
        if let latitudeDegree = Double(dmmTextFieldOne.text ?? ""),
           let latitudeMins = Double(dmmTextFieldTwo.text ?? ""),
           let longtitudeDegree = Double(dmmTextFieldThree.text ?? ""),
           let longtitudeMins = Double(dmmTextFieldFour.text ?? "") {
            
            
            dmsTextFieldOne.text = String(latitudeDegree)
            dmsTextFieldTwo.text = String(latitudeMins)
            
            dmsTextFieldFour.text = String(longtitudeDegree)
            dmsTextFieldFive.text = String(longtitudeMins)
        } else { print("ConverterSec input error ")      }
    }
    
    func coordinatesConverterThird () {
        if let latitudeDegree = Double(dmsTextFieldOne.text ?? ""),
           let latitudeMins = Double(dmsTextFieldTwo.text ?? ""),
           let latitudeSec = Double(dmsTextFieldThree.text ?? ""),
           let longtitudeDegree = Double(dmsTextFieldFour.text ?? ""),
           let longtitudeMins = Double(dmsTextFieldFive.text ?? ""),
           let longtitudeSec = Double(dmsTextFieldSix.text ?? "") {
            
            dmmTextFieldOne.text = String(Int(latitudeDegree))
            dmmTextFieldThree.text = String(Int(longtitudeDegree))
            
            dmmTextFieldTwo.text = String(latitudeMins)
            dmmTextFieldFour.text = String(longtitudeMins)
            
            ddTextField.text = String(latitudeDegree + latitudeMins/60 + latitudeSec/3600)
            ddTextFieldOne.text = String(longtitudeDegree + longtitudeMins/60 + longtitudeSec/3600)
        } else { print("ConverterThird input error ") }
    }
    
    func clearTextField() {
        ddTextField.text = ""
        ddTextFieldOne.text = ""
        dmmTextFieldOne.text = ""
        dmmTextFieldTwo.text = ""
        dmmTextFieldThree.text = ""
        dmmTextFieldFour.text = ""
        dmsTextFieldOne.text = ""
        dmsTextFieldTwo.text = ""
        dmsTextFieldThree.text = ""
        dmsTextFieldFour.text = ""
        dmsTextFieldFive.text = ""
        dmsTextFieldSix.text = ""
    }
    
    
    //經緯度十進位transferButton
    @objc func buttonActionOne(sender: UIButton!) {
        print("ButtonOne tapped")
        coordinatesConverter()
    }
    
    //經緯度 DMM transferButton
    @objc func buttonActionTwo(sender: UIButton!) {
        print("ButtonTwo tapped")
        coordinatesConverterSec()
    }
    
    //經緯度 DMS transferButton
    @objc func buttonActionThree(sender: UIButton!){
        print("ButtonThree tapped")
        coordinatesConverterThird()
    }
    
    @objc func clearButtonOneTapped(sender: UIButton!){
        print("clearButtonOne Tapped")
        clearTextField()
    }
    
    @objc func clearButtonTwoTapped(sender: UIButton!){
        print("clearButtonTwo Tapped")
        clearTextField()
    }
    
    @objc func clearButtonThreeTapped(sender: UIButton!){
        print("clearButtonThree Tapped")
        clearTextField()
    }
    
    @objc func addAnnotationButtonTapped(sender: UIButton!){
        print("add annotation title")
        if let latitudeText = ddTextField.text,
           let longitudeText = ddTextFieldOne.text,
           let latitude = Double(latitudeText),
           let longitude = Double(longitudeText),
           let annotationTitle = annotationTitle.text {
            let annotation = MKPointAnnotation()
            annotation.title = annotationTitle
            annotation.coordinate =  CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mkMapView.addAnnotation(annotation)
            print("added annotation success")
        } else {
            print("Error input")
        }
    }
    
  //  func alertNotification () {
  //      let alertController = UIAlertController(title: "請輸入內容", message: "請輸入緯度和經度", preferredStyle: .alert)
  //      alertController.addAction(UIAlertAction(title: "Ok", style: .default))
  //      self.present(alertController, animated: true)
  //  }
    
    func mkMapViewUpdateUI () {
        mkMapView.frame = CGRect(x: 16, y: 673, width: 361, height: 150)
        mkMapView.layer.cornerRadius = 20
        self.view.addSubview(mkMapView)

        if let latitudeText = ddTextField.text,
           let longitudeText = ddTextFieldOne.text,
           let latitude = Double(latitudeText),
           let longitude = Double(longitudeText) {
            mkMapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 10, longitudinalMeters: 10)
        } else {
            print("unsuccess")
        }
    }

    
    func updateUITwo () {
        //ddTextField
        ddTextField.frame = CGRect(x: 161, y: 145, width: 203, height: 34)
        ddTextField.placeholder = "請輸入數值"
        ddTextField.borderStyle = .roundedRect
        ddTextField.textColor = .darkGray
        ddTextField.backgroundColor = .systemGray6
        ddTextField.font = UIFont.systemFont(ofSize: 12)
        ddTextField.keyboardType = .decimalPad
        self.view.addSubview(ddTextField)
        
        //ddTextFieldOne
        ddTextFieldOne.frame = CGRect(x: 161, y: 185, width: 203, height: 34)
        ddTextFieldOne.placeholder = "請輸入數值"
        ddTextFieldOne.borderStyle = .roundedRect
        ddTextFieldOne.textColor = .darkGray
        ddTextFieldOne.backgroundColor = .systemGray6
        ddTextFieldOne.font = UIFont.systemFont(ofSize: 12)
        ddTextFieldOne.keyboardType = .decimalPad
        self.view.addSubview(ddTextFieldOne)
        
        //dmmTextFieldOne
        dmmTextFieldOne.frame = CGRect(x: 70, y: 312, width: 110, height: 34)
        dmmTextFieldOne.placeholder = "請輸入數值"
        dmmTextFieldOne.borderStyle = .roundedRect
        dmmTextFieldOne.textColor = .darkGray
        dmmTextFieldOne.backgroundColor = .systemGray6
        dmmTextFieldOne.font = UIFont.systemFont(ofSize: 12)
        dmmTextFieldOne.keyboardType = .decimalPad
        self.view.addSubview(dmmTextFieldOne)
        
        //dmmTextFieldTwo
        dmmTextFieldTwo.frame = CGRect(x: 70, y: 354, width: 110, height: 34)
        dmmTextFieldTwo.placeholder = "請輸入數值"
        dmmTextFieldTwo.borderStyle = .roundedRect
        dmmTextFieldTwo.textColor = .darkGray
        dmmTextFieldTwo.backgroundColor = .systemGray6
        dmmTextFieldTwo.font = UIFont.systemFont(ofSize: 12)
        dmmTextFieldTwo.keyboardType = .decimalPad
        self.view.addSubview(dmmTextFieldTwo)
        
        //dmmTextFieldThree
        dmmTextFieldThree.frame = CGRect(x: 253, y: 312, width: 110, height: 34)
        dmmTextFieldThree.placeholder = "請輸入數值"
        dmmTextFieldThree.borderStyle = .roundedRect
        dmmTextFieldThree.textColor = .darkGray
        dmmTextFieldThree.backgroundColor = .systemGray6
        dmmTextFieldThree.font = UIFont.systemFont(ofSize: 12)
        dmmTextFieldThree.keyboardType = .decimalPad
        self.view.addSubview(dmmTextFieldThree)
        
        //dmmTextFieldFour
        dmmTextFieldFour.frame = CGRect(x: 253, y: 354, width: 110, height: 34)
        dmmTextFieldFour.placeholder = "請輸入數值"
        dmmTextFieldFour.borderStyle = .roundedRect
        dmmTextFieldFour.textColor = .darkGray
        dmmTextFieldFour.backgroundColor = .systemGray6
        dmmTextFieldFour.font = UIFont.systemFont(ofSize: 12)
        dmmTextFieldFour.keyboardType = .decimalPad
        self.view.addSubview(dmmTextFieldFour)
        
        //dmsTextFieldOne
        dmsTextFieldOne.frame = CGRect(x: 70, y: 482, width: 110, height: 34)
        dmsTextFieldOne.placeholder = "請輸入數值"
        dmsTextFieldOne.borderStyle = .roundedRect
        dmsTextFieldOne.textColor = .darkGray
        dmsTextFieldOne.backgroundColor = .systemGray6
        dmsTextFieldOne.font = UIFont.systemFont(ofSize: 12)
        dmsTextFieldOne.keyboardType = .decimalPad
        self.view.addSubview(dmsTextFieldOne)
        
        //dmsTextFieldTwo
        dmsTextFieldTwo.frame = CGRect(x: 70, y: 524, width: 110, height: 34)
        dmsTextFieldTwo.placeholder = "請輸入數值"
        dmsTextFieldTwo.borderStyle = .roundedRect
        dmsTextFieldTwo.textColor = .darkGray
        dmsTextFieldTwo.backgroundColor = .systemGray6
        dmsTextFieldTwo.font = UIFont.systemFont(ofSize: 12)
        dmsTextFieldTwo.keyboardType = .decimalPad
        self.view.addSubview(dmsTextFieldTwo)
        
        //dmsTextFieldThree
        dmsTextFieldThree.frame = CGRect(x: 70, y: 569, width: 110, height: 34)
        dmsTextFieldThree.placeholder = "請輸入數值"
        dmsTextFieldThree.borderStyle = .roundedRect
        dmsTextFieldThree.textColor = .darkGray
        dmsTextFieldThree.backgroundColor = .systemGray6
        dmsTextFieldThree.font = UIFont.systemFont(ofSize: 12)
        dmsTextFieldThree.keyboardType = .decimalPad
        self.view.addSubview(dmsTextFieldThree)
        
        //dmsTextFieldFour
        dmsTextFieldFour.frame = CGRect(x: 253, y: 482, width: 110, height: 34)
        dmsTextFieldFour.placeholder = "請輸入數值"
        dmsTextFieldFour.borderStyle = .roundedRect
        dmsTextFieldFour.textColor = .darkGray
        dmsTextFieldFour.backgroundColor = .systemGray6
        dmsTextFieldFour.font = UIFont.systemFont(ofSize: 12)
        dmsTextFieldFour.keyboardType = .decimalPad
        self.view.addSubview(dmsTextFieldFour)
        
        //dmsTextFieldFive
        dmsTextFieldFive.frame = CGRect(x: 253, y: 524, width: 110, height: 34)
        dmsTextFieldFive.placeholder = "請輸入數值"
        dmsTextFieldFive.borderStyle = .roundedRect
        dmsTextFieldFive.textColor = .darkGray
        dmsTextFieldFive.backgroundColor = .systemGray6
        dmsTextFieldFive.font = UIFont.systemFont(ofSize: 12)
        dmsTextFieldFive.keyboardType = .decimalPad
        self.view.addSubview(dmsTextFieldFive)
        
        //dmsTextFieldSix
        dmsTextFieldSix.frame = CGRect(x: 253, y: 569, width: 110, height: 34)
        dmsTextFieldSix.placeholder = "請輸入數值"
        dmsTextFieldSix.borderStyle = .roundedRect
        dmsTextFieldSix.textColor = .darkGray
        dmsTextFieldSix.backgroundColor = .systemGray6
        dmsTextFieldSix.font = UIFont.systemFont(ofSize: 12)
        dmsTextFieldSix.keyboardType = .decimalPad
        self.view.addSubview(dmsTextFieldSix)
        
        annotationTitle.frame = CGRect(x: 170, y: 632, width: 200, height: 30)
        annotationTitle.placeholder = "請輸入座標名稱"
        annotationTitle.textColor = .darkGray
        annotationTitle.borderStyle = .roundedRect
        annotationTitle.font = UIFont.systemFont(ofSize: 12)
        annotationTitle.keyboardType = .default
        self.view.addSubview(annotationTitle)
    }
    
    
    func updateUI () {
        let gradientView = UIView(frame: self.view.bounds)
        gradientView.gradientViewColor()
        self.view.addSubview(gradientView)
        
        // self.view.gradinetViewColor ()
        let boxOne = UIView(frame: CGRect(x: 16, y: 87, width: 361, height: 150))
        boxOne.alpha = 0.25
        boxOne.gradientBackgroundColor(colors: [UIColor.white.cgColor, UIColor.white.cgColor])
        boxOne.layer.shadowColor = UIColor.black.cgColor
        boxOne.layer.shadowOpacity = 0.1
        boxOne.layer.shadowOffset = .zero
        boxOne.layer.shadowRadius = 360
        boxOne.clipsToBounds = false
        self.view.addSubview(boxOne)
        
        let boxTwo = UIView(frame: CGRect(x: 16, y: 246, width: 361, height: 160))
        boxTwo.alpha = 0.25
        boxTwo.gradientBackgroundColor(colors: [UIColor.white.cgColor, UIColor.white.cgColor])
        boxTwo.layer.shadowColor = UIColor.black.cgColor
        boxTwo.layer.shadowOpacity = 0.1
        boxTwo.layer.shadowOffset = .zero
        boxTwo.layer.shadowRadius = 100
        boxTwo.clipsToBounds = false
        self.view.addSubview(boxTwo)
        
        let boxThree = UIView(frame: CGRect(x: 16, y: 416, width: 361, height: 205))
        boxThree.alpha = 0.25
        boxThree.gradientBackgroundColor(colors: [UIColor.white.cgColor, UIColor.white.cgColor])
        boxThree.layer.shadowColor = UIColor.black.cgColor
        boxThree.layer.shadowOpacity = 0.1
        boxThree.layer.shadowOffset = .zero
        boxThree.layer.shadowRadius = 360
        boxThree.clipsToBounds = false
        self.view.addSubview(boxThree)
    }
    
    func updateUIThree() {
        //Custom title mix
        //title One
        let titleOne = UILabel.customTitleLabel(frame: CGRect(x: 30, y: 103, width: 150, height: 20), text: "經緯度十進位(DD)", textColor: .white, fontSize: 18)
        self.view.addSubview(titleOne)
        //title Two
        let titleTwo = UILabel.customTitleLabel(frame: CGRect(x: 30, y: 265, width: 160, height: 20), text: "經緯度,度分(DMM)", textColor: .white, fontSize: 18)
        self.view.addSubview(titleTwo)
        //title Three
        let titleThree = UILabel.customTitleLabel(frame: CGRect(x: 30, y: 437, width: 160, height: 20), text: "經緯度,度分(DMS)", textColor: .white, fontSize: 18)
        self.view.addSubview(titleThree)
        
        //ddSubLabelOne 緯度(Latitude)
        let ddSubLabelOne = UILabel.customSubTitleLabel(frame: CGRect(x: 30, y: 154, width: 92, height: 17), text: "緯度(Latitude)", textColor: .white, fontSize: 14)
        self.view.addSubview(ddSubLabelOne)
        //ddSubLabelTwo 經度(Longitude)
        let ddSubLabelTwo = UILabel.customSubTitleLabel(frame: CGRect(x: 30, y: 194, width: 108, height: 17), text: "經度(Longitude)", textColor: .white, fontSize: 14)
        self.view.addSubview(ddSubLabelTwo)
        
        //dmmLabelOne
        let dmmSubLabelOne = UILabel.customSubTitleLabel(frame: CGRect(x: 30, y: 321, width: 29, height: 17), text: "緯度", textColor: .white, fontSize: 14)
        self.view.addSubview(dmmSubLabelOne)
        //dmmLabelTwo
        let dmmSubLabelTwo = UILabel.customSubTitleLabel(frame: CGRect(x: 30, y: 363, width: 33, height: 17), text: "緯分", textColor: .white, fontSize: 14)
        self.view.addSubview(dmmSubLabelTwo)
        //dmmLabelThree
        let dmmSubLabelThree = UILabel.customSubTitleLabel(frame: CGRect(x: 202, y: 321, width: 29, height: 17), text: "經度", textColor: .white, fontSize: 14)
        self.view.addSubview(dmmSubLabelThree)
        //dmmLabelFour
        let dmmSubLabelFour = UILabel.customSubTitleLabel(frame: CGRect(x: 202, y: 363, width: 29, height: 17), text: "經分", textColor: .white, fontSize: 14)
        self.view.addSubview(dmmSubLabelFour)
        
        //dmsLabelOne
        let dmsLabelOne = UILabel.customSubTitleLabel(frame: CGRect(x: 30, y: 491, width: 29, height: 17), text: "緯度", textColor: .white, fontSize: 14)
        self.view.addSubview(dmsLabelOne)
        //dmsLabelTwo
        let dmsLabelTwo = UILabel.customSubTitleLabel(frame: CGRect(x: 30, y: 533, width: 29, height: 17), text: "緯分", textColor: .white, fontSize: 14)
        self.view.addSubview(dmsLabelTwo)
        //dmsLabelThree
        let dmsLabelThree = UILabel.customSubTitleLabel(frame: CGRect(x: 30, y: 578, width: 29, height: 17), text: "緯秒", textColor: .white, fontSize: 14)
        self.view.addSubview(dmsLabelThree)
        //dmsLabelFour
        let dmsLabelFour = UILabel.customSubTitleLabel(frame: CGRect(x: 202, y: 491, width: 29, height: 17), text: "經度", textColor: .white, fontSize: 14)
        self.view.addSubview(dmsLabelFour)
        //dmsLabelFive
        let dmsLabelFive = UILabel.customSubTitleLabel(frame: CGRect(x: 202, y: 533, width: 29, height: 17), text: "經分", textColor: .white, fontSize: 14)
        self.view.addSubview(dmsLabelFive)
        //dmsLabelSix
        let dmsLabelSix = UILabel.customSubTitleLabel(frame: CGRect(x: 202, y: 578, width: 29, height: 17), text: "經秒", textColor: .white, fontSize: 14)
        self.view.addSubview(dmsLabelSix)
        
        let actionOne: Selector = #selector(MapCoordinatesCalculationViewController.buttonActionOne)
        let transferButtonOne = UIButton.customButton(frame: CGRect(x: 197, y: 97, width: 86, height: 32), title: "Transfer", titleColor: UIColor.white, cornerRadius: 10, fontSize: 14, startColor: UIColor.systemRed, endColor: UIColor.systemPurple, tags: 1, action: actionOne, target: self, viewController: self)
        transferButtonOne.layer.shadowColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.view.addSubview(transferButtonOne)
        
        //DMM's transferButton
        let actionTwo: Selector = #selector(MapCoordinatesCalculationViewController.buttonActionTwo)
        let transferButtonTwo = UIButton.customButton(frame: CGRect(x: 197, y: 259, width: 86, height: 32), title: "Transfer", titleColor: UIColor.white, cornerRadius: 10, fontSize: 14, startColor: UIColor.systemRed, endColor: UIColor.systemPurple, tags: 1, action: actionTwo, target: self, viewController: self)
        self.view.addSubview(transferButtonTwo)
        
        let actionThree: Selector = #selector(MapCoordinatesCalculationViewController.buttonActionThree(sender:))
        let transferButtonThree = UIButton.customButton(frame: CGRect(x: 197, y: 431, width: 86, height: 32), title: "Transfer", titleColor: UIColor.white, cornerRadius: 10, fontSize: 14, startColor: UIColor.systemRed, endColor: UIColor.systemPurple, tags: 1, action: actionThree, target: self, viewController: self)
        self.view.addSubview(transferButtonThree)
        
        let actionFour: Selector = #selector(MapCoordinatesCalculationViewController.clearButtonOneTapped(sender:))
        let clearButtonOne = UIButton.customButton(frame: CGRect(x: 280, y: 97, width: 86, height: 32), title: "Clear", titleColor:UIColor.white, cornerRadius: 0, fontSize: 14, startColor: UIColor.clear, endColor: UIColor.clear, tags: 1, action: actionFour, target: self, viewController: self)
        self.view.addSubview(clearButtonOne)
        
        let actionFive: Selector = #selector(MapCoordinatesCalculationViewController.clearButtonTwoTapped(sender:))
        let clearButtonTwo = UIButton.customButton(frame: CGRect(x: 280, y: 259, width: 86, height: 32), title: "Clear", titleColor:UIColor.white, cornerRadius: 0, fontSize: 14, startColor: UIColor.clear, endColor: UIColor.clear, tags: 1, action: actionFive, target: self, viewController: self)
        self.view.addSubview(clearButtonTwo)
        
        let actionSix: Selector = #selector(MapCoordinatesCalculationViewController.clearButtonThreeTapped(sender:))
        let clearButtonThree = UIButton.customButton(frame: CGRect(x: 280, y: 431, width: 86, height: 32), title: "Clear", titleColor: UIColor.white, cornerRadius: 0, fontSize: 14, startColor: UIColor.clear, endColor: UIColor.clear, tags: 1, action: actionSix, target: self, viewController: self)
        self.view.addSubview(clearButtonThree)
        
        let actionSeven: Selector = #selector(MapCoordinatesCalculationViewController.addAnnotationButtonTapped(sender:))
        let addAnnotation = UIButton.customButton(frame: CGRect(x: 70, y: 632, width: 86 , height: 30), title: "Add", titleColor: UIColor.white, cornerRadius: 10, fontSize: 14, startColor: UIColor.systemRed, endColor: UIColor.systemPurple, tags: 1, action: actionSeven, target: self, viewController: self)
        self.view.addSubview(addAnnotation)
    }
}
    
    extension UIView {
        func gradientViewColor () {
            _ = UIView(frame: CGRect(x: 0, y: 0, width: 393, height: 1000))
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [
                UIColor(red: 5/255, green: 237/255, blue: 197/255, alpha: 1).cgColor,UIColor(red: 28/255, green: 134/255, blue: 178/255, alpha: 1).cgColor,
                UIColor.systemPurple.cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.locations = [0, 0.5, 1]
            self.layer.addSublayer(gradientLayer)
            self.layer.masksToBounds = true
        }
        
        func gradientBackgroundColor(colors: [CGColor]) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = colors
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.cornerRadius = 15
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    extension UILabel {
        //custom titleLabel
        static func customTitleLabel(frame: CGRect, text: String, textColor: UIColor, fontSize: CGFloat) -> UILabel {
            let label = UILabel(frame: frame)
            label.text = text
            label.textColor = textColor
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
            return label
        }
        //custom subTitleLabel
        static func customSubTitleLabel(frame: CGRect, text: String, textColor: UIColor, fontSize: CGFloat) -> UILabel {
            let subLabel = UILabel(frame: frame)
            subLabel.text = text
            subLabel.textColor = textColor
            subLabel.font = UIFont.systemFont(ofSize: fontSize)
            return subLabel
        }
    }
    
    extension UIButton {
        static func customButton(frame: CGRect, title: String, titleColor: UIColor, cornerRadius: CGFloat, fontSize: CGFloat, startColor: UIColor, endColor: UIColor, tags: Int, action: Selector, target: Any?, viewController: UIViewController) -> UIButton {
            let button = UIButton(frame: frame)
            button.layer.cornerRadius = cornerRadius
            button.titleLabel?.font = .systemFont(ofSize: fontSize)
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.tag = tags
            button.addTarget(target, action: action, for: .touchUpInside)
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = button.bounds
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.cornerRadius = cornerRadius
            button.layer.insertSublayer(gradientLayer, at: 0)
            
            // Set direction from left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1 , y: 1)
            
            //add button in the viewController
            viewController.view.addSubview(button)
            return button
        }
    }
