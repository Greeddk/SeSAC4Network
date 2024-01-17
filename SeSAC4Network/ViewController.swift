//
//  ViewController.swift
//  SeSAC4Network
//
//  Created by Greed on 1/16/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }

    @objc func translateButtonClicked() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let parameters: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"]
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "myfXUBmrlHZulEVs3kTJ",
            "X-Naver-Client-Secret": "ah27uLISNx"]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseDecodable(decoder: <#T##DataDecoder#>) { response in
            <#code#>
        }
    }

}

