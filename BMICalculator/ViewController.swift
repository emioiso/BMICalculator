//
//  ViewController.swift
//  BMICalculator
//
//  Created by emi oiso on 2024/02/01.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var bmiLabel: UILabel!
    @IBOutlet var judgement: UILabel!
    @IBOutlet var ErrorMessageWeight: UILabel!
    @IBOutlet var ErrorMessageHeight: UILabel!

    var bannerView:GADBannerView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightTextField.placeholder = "身長をcmで入力してください。"
        weightTextField.placeholder = "体重をkgで入力してください。"
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-7923877881339580/7040716720"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    @IBAction func calculationBtnAction(_ sender: Any) {
        // 各入力が空かどうかを個別にチェック
           let heightText = heightTextField.text ?? ""
           let weightText = weightTextField.text ?? ""

           var hasErrors = false

           if heightText.isEmpty {
               ErrorMessageHeight.text = "身長の数値を入力してください。"
               hasErrors = true
           } else {
               ErrorMessageHeight.text = ""  // エラーメッセージをクリア
           }

           if weightText.isEmpty {
               ErrorMessageWeight.text = "体重の数値を入力してください。"
               hasErrors = true
           } else {
               ErrorMessageWeight.text = ""  // エラーメッセージをクリア
           }

           if hasErrors {
               bmiLabel.text = ""           // BMIラベルをクリア
               judgement.text = ""          // 判定ラベルをクリア
//               ErrorMessageHeightAndWeight.text = ""
               return
           }

           // 数値変換を試みる
           if let doubleH = Double(heightText), let doubleW = Double(weightText) {
               // すべての入力が適切であればBMIを計算し、結果を表示
               let result = calculation(height: doubleH, weight: doubleW)
               bmiLabel.text = result
               setObesityLevel(bmi: result)
//               ErrorMessageHeightAndWeight.text = ""   共通のエラーメッセージをクリア
           } else {
               bmiLabel.text = "入力値が不正です"  // 数値変換に失敗した場合のエラー
               judgement.text = ""
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
                judgement.text = "低体重"
            } else if bmiValue < 25 {
                judgement.text = "普通体重"
            } else if bmiValue < 30 {
                judgement.text = "肥満（1度）"
            } else if bmiValue < 35 {
                judgement.text = "肥満（2度）"
            } else if bmiValue < 40 {
                judgement.text = "肥満（3度）"
            } else {
                judgement.text = "肥満（4度）"
            }
        } else {
            // エラーハンドリング: BMIが数値に変換できない場合
            judgement.text = "BMIの計算エラー"
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

