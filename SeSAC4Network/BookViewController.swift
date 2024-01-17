//
//  BookViewController.swift
//  SeSAC4Network
//
//  Created by Greed on 1/17/24.
//

import UIKit
import Alamofire

// MARK: - Book
struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

class BookViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bookCollectionView: UICollectionView!
    
    var bookList: Book = Book(documents: [Document(authors: [""], contents: "", datetime: "", isbn: "", price: 0, publisher: "", salePrice: 0, status: "", thumbnail: "", title: "", url: "")], meta: Meta(isEnd: false, pageableCount: 0, totalCount: 0)) {
        didSet {
            bookCollectionView.reloadData()
        }
    }
    var isSearched: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        setCollectionView()
    }
    
    func callRequest(keyword: String) {
        
        //만약 한글 검색이 안된다면 인코딩 처리
        let query = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=50"
        
        let headers: HTTPHeaders = ["Authorization": APIKey.kakaoAuthor]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let success):
                dump(success.documents)
                
                self.isSearched = true
                self.bookList = success
            case .failure(let failure):
                print("통신오류")
            }
        }
        
    }
}

extension BookViewController {
    
    func setCollectionView() {
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let xib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        
        bookCollectionView.register(xib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - spacing * 3
        let cellHeight = UIScreen.main.bounds.height - spacing * 3
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellHeight / 4)
        
        bookCollectionView.collectionViewLayout = layout
    }
}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(keyword: searchBar.text!)
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let list = bookList.documents
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        if isSearched {
            cell.configureCell(item: bookList.documents[indexPath.item])
        }
        return cell
    }
    
}
