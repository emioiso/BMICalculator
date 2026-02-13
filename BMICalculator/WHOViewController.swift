//
//  WHOViewController.swift
//  BMICalculator
//
//  Created by emi oiso on 2026/02/13.
//

import UIKit
import GoogleMobileAds

class WHOViewController: UIViewController {
    @IBOutlet var WHOheightTextField: UITextField!
    @IBOutlet var WHOweightTextField: UITextField!
    @IBOutlet var WHObmiLabel: UILabel!
    @IBOutlet var WHOjudgement: UILabel!
    @IBOutlet var WHOErrorMessageHeight: UILabel!
    @IBOutlet var WHOErrorMessageWeight: UILabel!

    var bannerView:GADBannerView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WHOheightTextField.placeholder = "Please enter your height in feet and inches"
        WHOweightTextField.placeholder = "Please enter your weight in pounds"
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-7923877881339580/7040716720"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    @IBAction func calculationBtnAction(_ sender: Any) {
        // 各入力が空かどうかを個別にチェック
           let heightText = WHOheightTextField.text ?? ""
           let weightText = WHOweightTextField.text ?? ""

           var hasErrors = false

           if heightText.isEmpty {
               WHOErrorMessageHeight.text = "Please enter your height"  // エラーメッセージをクリア
               hasErrors = true
           } else {
               WHOErrorMessageHeight.text = ""
           }

           if weightText.isEmpty {
               WHOErrorMessageWeight.text = "Please enter your weight"
               hasErrors = true
           } else {
               WHOErrorMessageWeight.text = ""  // エラーメッセージをクリア
           }

           if hasErrors {
               WHObmiLabel.text = ""           // BMIラベルをクリア
               WHOjudgement.text = ""          // 判定ラベルをクリア
//               ErrorMessageHeightAndWeight.text = ""
               return
           }

           // 数値変換を試みる
           if let doubleH = Double(heightText), let doubleW = Double(weightText) {
               // すべての入力が適切であればBMIを計算し、結果を表示
               let result = calculation(height: doubleH, weight: doubleW)
               WHObmiLabel.text = result
               setObesityLevel(bmi: result)
//               ErrorMessageHeightAndWeight.text = ""   共通のエラーメッセージをクリア
           } else {
               WHObmiLabel.text = "The input value is invalid."  // 数値変換に失敗した場合のエラー
               WHOjudgement.text = ""
           }

    }
   
    //BMIの計算をしている
    func calculation(height:Double,weight:Double) -> String {
        let h = height / 100
        let w = weight
        var result = w / (h * h)
        result = floor(result * 10) / 10
        return result.description
    }
    
    //BMIの数値によって肥満度を出力する
    func setObesityLevel(bmi: String) {
        
        if let bmiValue = Double(bmi) {
            if bmiValue < 18.5 {
                WHOjudgement.text = "低体重"
            } else if bmiValue < 25 {
                WHOjudgement.text = "普通体重"
            } else if bmiValue < 30 {
                WHOjudgement.text = "肥満（1度）"
            } else if bmiValue < 35 {
                WHOjudgement.text = "肥満（2度）"
            } else if bmiValue < 40 {
                WHOjudgement.text = "肥満（3度）"
            } else {
                WHOjudgement.text = "肥満（4度）"
            }
        } else {
            // エラーハンドリング: BMIが数値に変換できない場合
            WHOjudgement.text = "Error"
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView){
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bannerView)
            view.addConstraints(
                [NSLayoutConstraint(item: bannerView,
                                    attribute: .bottom,
                                    relatedBy: .equal,
                                    toItem: view.safeAreaLayoutGuide,
                                    attribute: .bottom,
                                    multiplier: 1,
                                    constant: 0),
                 NSLayoutConstraint(item: bannerView,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)
                ])
        }
   
    
//    NumberPadを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
}

