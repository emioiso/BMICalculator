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
    @IBOutlet var ErrorMessageHeightAndWeight: UILabel!

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
        guard let heightText = heightTextField.text, !heightText.isEmpty, let doubleH = Double(heightText) else {
                ErrorMessageHeight.text = "身長の数値を入力してください。"
                bmiLabel.text = "" // BMIラベルをクリア
                judgement.text = "" // 判定ラベルをクリア
                return
            }

            // 体重のチェック
            guard let weightText = weightTextField.text, !weightText.isEmpty, let doubleW = Double(weightText) else {
                ErrorMessageWeight.text = "体重の数値を入力してください。"
                // BMIラベルをクリア
                bmiLabel.text = ""
                judgement.text = "" // 判定ラベルをクリア
                return
            }

            // すべての入力が適切であればBMIを計算し、結果を表示
            ErrorMessageHeight.text = "" // エラーメッセージをクリア
            ErrorMessageWeight.text = "" // エラーメッセージをクリア
            let result = calculation(height: doubleH, weight: doubleW)
            bmiLabel.text = result
            setObesityLevel(bmi: result)
//        guard let heightText = heightTextField.text, !heightText.isEmpty,
//              let weightText = weightTextField.text, !weightText.isEmpty,
//              let doubleH = Double(heightText), let doubleW = Double(weightText) else {
//            // ここでエラーメッセージを表示
//            ErrorMessageWeight.text = "体重の数値を入力してください。"
//                return
//            }
//
//            let result = calculation(height: doubleH, weight: doubleW)
//            bmiLabel.text = result
//            setObesityLevel(bmi: result)
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

