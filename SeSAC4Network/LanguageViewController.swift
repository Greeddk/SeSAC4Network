//
//  LanguageViewController.swift
//  SeSAC4Network
//
//  Created by Greed on 1/17/24.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet var LanguageListTableView: UITableView!
    
    let lanList = [
        "ko": "한국어",
        "en": "영어",
        "ja": "일본어",
        "zh-CN": "중국어 간체",
        "zh-TW": "중국어 번체",
        "vi": "베트남어",
        "id": "인도네시아어",
        "th": "태국어",
        "de": "독일어",
        "ru": "러시아어",
        "es": "스페인어",
        "it": "이탈리아어",
        "fr": "프랑스어"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    

}

extension LanguageViewController {
    
    func setUI() {
        
        LanguageListTableView.delegate = self
        LanguageListTableView.dataSource = self
        
        LanguageListTableView.rowHeight = 60
    }
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lanList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier, for: indexPath)
        
        let list = Array(lanList.values)
        
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        
        return cell
    }
    
    
}
