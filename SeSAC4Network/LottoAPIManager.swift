//
//  LottoAPIManager.swift
//  SeSAC4Network
//
//  Created by Greed on 1/16/24.
//

import Foundation
import Alamofire

struct LottoAPIManager {
    
    func callRequest(number: String, completionhandler: @escaping (String) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                print(success.drwtNo1)
                print(success.drwNoDate)
                
//                self.dateLabel.text = success.drwNoDate
                completionhandler(success.drwNoDate)
                
            case .failure(let failure):
                print("오류 발생")
            }
        }
    }
}
