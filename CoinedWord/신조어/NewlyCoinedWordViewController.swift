//
//  NewlyCoinedWordViewController.swift
//  CoinedWord
//
//  Created by 서승우 on 2023/07/20.
//

import UIKit

final class NewlyCoinedWordViewController: UIViewController {

    let newlyCoinedWords: [String: String] = [
        "쫌쫌따리": "아주 조금씩 하찮은 양을 모으는 모습",
        "억텐": "억지 텐션의 줄임말. 억지로 텐션을 올려서 발랄하게 행동할 때",
        "스불재": "스스로 불러온 재앙의 줄임말. 자신이 계획한 일로 자신이 고통을 받을 때 씀",
        "좋댓구알": "좋아요, 댓글, 구독, 알림 설정 유튜브에서 동영상 보는 사람들이 할 수 있는 네 가지",
        "어쩔티비": "어쩌라고 가서 TV나 봐라라는 뜻. ‘저쩔티비’나 ‘어쩔’ 뒤에 전자제품을 붙여 맞받아치면 됨. Ex) 어쩔냉장고",
        "갓생": "갓(God) + 생(生) 부지런히하고 열심히 사는 사람에게 쓰는 말",
        "점메추": "점심 메뉴 추천의 줄임말",
        "다꾸": "다이어리 꾸미기라는 뜻",
        "킹받다": "열받다라는 말에 새롭게 접두사로 쓰이고 있는 킹(King)을 붙여 강조",
        "군싹": "군침이 싹도네의 줄임말"
    ]


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet weak var keywordStackView: UIStackView!
    @IBOutlet var keywordButtons: [UIButton]!

    @IBOutlet weak var newlyCoinedWordStackView: UIStackView!
    @IBOutlet weak var newlyCoinedWordHeaderView: UIView!
    @IBOutlet weak var newlyCoinedWordLabel: UILabel!
    @IBOutlet weak var newlyCoinedWordFooterView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

    @IBAction func didTapSearchButton(_ sender: UIButton) {
        guard let text = searchBar.searchTextField.text
        else {return}

        newlyCoinedWordSearch(searchText: text)
    }

    @IBAction func didTapKeywordButtons(_ sender: UIButton) {
        guard let newlyCoinedWord = sender.titleLabel?.text
        else {return}

        newlyCoinedWordLabel.text = newlyCoinedWords[newlyCoinedWord]
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

}

extension NewlyCoinedWordViewController: UITextFieldDelegate {

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        guard let text = textField.text
        else {return false}

        newlyCoinedWordSearch(searchText: text)
        
        return true
    }

}

private extension NewlyCoinedWordViewController {

    func newlyCoinedWordSearch(searchText: String) {
        // 검색어가 비었을 때
        if searchText.isEmpty {
            presentAlert(title: "검색어를 입력하세요.")
        // 검색어도 있고 신조어도 있을 때
        } else if newlyCoinedWords.keys.contains(searchText) {
            searchBar.searchTextField.text = nil
            newlyCoinedWordLabel.text = newlyCoinedWords[searchText]
            searchBar.searchTextField.resignFirstResponder()
        }
        // 검색어가 비어있지 않지만 없을 때
        else {
            presentAlert(title: "없는 검색어입니다.")
        }
    }

}

private extension NewlyCoinedWordViewController {

    // border 그리는 메소드
    func drawBorder(
        view: UIView,
        width: CGFloat,
        color: CGColor = UIColor.black.cgColor
    ) {
        view.layer.borderWidth = width
        view.layer.borderColor = color
    }

    // 알럿을 생성하고 띄워주는 메소드
    func presentAlert(title: String) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )

        let cancel = UIAlertAction(
            title: "확인",
            style: .cancel
        )
        alert.addAction(cancel)

        present(alert, animated: true)
    }

}

// UI 설정
private extension NewlyCoinedWordViewController {

    func configureHierarchy() {
        // 검색 바
        configureSearchBar()
        // 검색 버튼
        configureSearchButton()
        // 키워드 버튼들
        configureKeywordButtons()
        // 신조어 스택뷰
        configureNewlyCoinedWordStackView()
        // 신조어 레이블
        configureNewlyCoinedWordLabel()
    }

    func configureSearchBar() {
        searchBar.searchTextField.delegate = self
        searchBar.setImage(
            UIImage(),
            for: UISearchBar.Icon.search,
            state: .normal
        )
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()

        drawBorder(
            view: searchBar,
            width: 3
        )
    }

    func configureSearchButton() {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(
                systemName: "magnifyingglass"
            )
            config.baseForegroundColor = .white
            config.background.backgroundColor = .black
            config.background.cornerRadius = 0

            searchButton.configuration = config
        } else {
            searchButton.setImage(
                UIImage(systemName: "magnifyingglass"),
                for: .normal
            )
            searchButton.tintColor = .white
            searchButton.backgroundColor = .black
        }
    }

    func configureKeywordButtons() {
        keywordButtons.forEach {
            $0.layer.cornerRadius = 10
            drawBorder(view: $0, width: 1.5)
        }
    }

    func configureNewlyCoinedWordStackView() {
        drawBorder(
            view: newlyCoinedWordStackView,
            width: 2
        )
    }

    func configureNewlyCoinedWordLabel() {
        newlyCoinedWordLabel.text = nil
        newlyCoinedWordLabel.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )
        newlyCoinedWordLabel.textAlignment = .center
        newlyCoinedWordLabel.numberOfLines = 4

        drawBorder(
            view: newlyCoinedWordLabel,
            width: 2
        )
    }

}
