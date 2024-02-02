//
//  ViewController.swift
//  BMICalculator
//
//  Created by emi oiso on 2024/02/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var bmiLabel: UILabel!
    @IBOutlet var resultBMI: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heightTextField.placeholder = "身長をcmで入力してください。"
        weightTextField.placeholder = "体重をkgで入力してください。"
    }
    
    @IBAction func calculationBtnAction(_ sender: Any) {
        let doubleH = Double(heightTextField.text!)
        let doubleW = Double(weightTextField.text!)
        bmiLabel.text = calculation(height: doubleH!, weight: doubleW!)
    
        //ここがわからなかった
        let result = calculation(height: doubleH!, weight: doubleW!)
        //ここもわからなかった
        // BMIの計算結果をもとに肥満度を判定
        setObesityLevel(bmi: result)
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
                resultBMI.text = "低体重"
            } else if bmiValue < 25 {
                resultBMI.text = "普通体重"
            } else if bmiValue < 30 {
                resultBMI.text = "肥満（1度）"
            } else if bmiValue < 35 {
                resultBMI.text = "肥満（2度）"
            } else if bmiValue < 40 {
                resultBMI.text = "肥満（3度）"
            } else {
                resultBMI.text = "肥満（4度）"
            }
        } else {
            // エラーハンドリング: BMIが数値に変換できない場合
            resultBMI.text = "BMIの計算エラー"
        }
    }
}

