//
//  ViewController.swift
//  SeSAC4Network
//
//  Created by Greed on 1/16/24.
//

import UIKit
import Alamofire

struct Papago: Codable {
    let message: Message
}

struct Message: Codable {
    let result: Result
}

struct Result: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}

class ViewController: UIViewController {
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    @IBOutlet var originLanguageButton: UIButton!
    @IBOutlet var swapLanguageButton: UIButton!
    @IBOutlet var resultLanguageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUI()
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }
    
    @IBAction func originLanguageButtonClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: LanguageViewController.identifier) as! LanguageViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resultLanguageButtonClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: LanguageViewController.identifier) as! LanguageViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
     1. 네트워크 통신 단절 상태
     2. API 콜수
     3. 번역 버튼 클릭 횟수.
     4. 텍스트 비교
     5. LoadingVIew
     */
    @objc func translateButtonClicked() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let parameters: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"]
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseDecodable(of: Papago.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                
                self.targetLabel.text = success.message.result.translatedText
            case .failure(let failure):
                print("통신오류")
            }
        }
        
    }
}

extension ViewController {
    
    func setUI() {
        
        originLanguageButton.setTitle("원본 언어", for: .normal)
        
        swapLanguageButton.setImage(UIImage(systemName: "rectangle.2.swap"), for: .normal)
        
        resultLanguageButton.setTitle("목적 언어", for: .normal)
    }
}


