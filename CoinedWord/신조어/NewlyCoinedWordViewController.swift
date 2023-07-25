//
//  NewlyCoinedWordViewController.swift
//  CoinedWord
//
//  Created by 서승우 on 2023/07/20.
//

import UIKit

final class NewlyCoinedWordViewController: UIViewController {

    enum NewlyConinedWordKind: String, CaseIterable {
        case 쫌쫌따리 = "아주 조금씩 하찮은 양을 모으는 모습"
        case 억텐 = "억지 텐션의 줄임말. 억지로 텐션을 올려서 발랄하게 행동할 때"
        case 스불재 = "스스로 불러온 재앙의 줄임말. 자신이 계획한 일로 자신이 고통을 받을 때 씀"
        case 좋댓구알 = "좋아요, 댓글, 구독, 알림 설정 유튜브에서 동영상 보는 사람들이 할 수 있는 네 가지"
        case 어쩔티비 = "어쩌라고 가서 TV나 봐라라는 뜻. ‘저쩔티비’나 ‘어쩔’ 뒤에 전자제품을 붙여 맞받아치면 됨. Ex) 어쩔냉장고"
        case 갓생 = "갓(God) + 생(生) 부지런히하고 열심히 사는 사람에게 쓰는 말"
        case 점메추 = "점심 메뉴 추천의 줄임말"
        case 다꾸 = "다이어리 꾸미기라는 뜻"
        case 킹받다 = "열받다라는 말에 새롭게 접두사로 쓰이고 있는 킹(King)을 붙여 강조"
        case 군싹 = "군침이 싹도네의 줄임말"

        var title: String {
            switch self {
            case .쫌쫌따리: return "쫌쫌따리"
            case .억텐: return "억텐"
            case .스불재: return "스불재"
            case .좋댓구알: return "좋댓구알"
            case .어쩔티비: return "어쩔티비"
            case .갓생: return "갓생"
            case .점메추: return "점메추"
            case .다꾸: return "다꾸"
            case .킹받다: return "킹받다"
            case .군싹: return "군싹"
            }
        }
    }

    let newlyCoinedWordDic: [String: String] = [
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

    // 검색 바
    @IBOutlet weak var searchBar: UISearchBar!
    // 검색 버튼
    @IBOutlet weak var searchButton: UIButton!

    // 키워드 스택뷰
    @IBOutlet weak var keywordStackView: UIStackView!
    // 키워드 버튼들
    @IBOutlet var keywordButtons: [AutoAddPaddingButtton]!

    // 신조어 스택뷰
    @IBOutlet weak var newlyCoinedWordStackView: UIStackView!
    // 신조어 헤더뷰
    @IBOutlet weak var newlyCoinedWordHeaderView: UIView!
    // 신조어 레이블
    @IBOutlet weak var newlyCoinedWordLabel: UILabel!
    // 신조어 푸터뷰
    @IBOutlet weak var newlyCoinedWordFooterView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

    @IBAction func didTapSearchButton(_ sender: UIButton) {
        guard let text = searchBar.searchTextField.text
        else {
            presentAlert(title: "검색어 에러")
            return
        }

        newlyCoinedWordSearch(searchText: text)
    }

    @IBAction func didTapKeywordButtons(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text
        else {
            presentAlert(title: "키워드 에러")
            return
        }

        newlyCoinedWordSearch(searchText: text)
        randomizationKeywordStackViewFlow()
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

// UI 디폴트 설정
private extension NewlyCoinedWordViewController {

    // 검색 바 구성하기
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

    // 검색 버튼 구성하기
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

    // 키워드 버튼들 구성하기
    func configureKeywordButtons() {
        keywordButtons.forEach {
            $0.layer.cornerRadius = 10
            drawBorder(view: $0, width: 1.5)
        }
    }

    // 신조어 스택뷰 구성하기
    func configureNewlyCoinedWordStackView() {
        drawBorder(
            view: newlyCoinedWordStackView,
            width: 2
        )
    }

    // 신조어 레이블 구성하기
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

}

// 동작
private extension NewlyCoinedWordViewController {

    // border 그려주기
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

// 비즈니스 로직
// 검색
private extension NewlyCoinedWordViewController {

    // 신조어 검색하기
    func newlyCoinedWordSearch(searchText: String) {
        // 공백만 있어도 isEmpty 속성이 통하지 않기 때문에
        // 공백을 제거해준다.
        let searchText = searchText.trimmingCharacters(
            in: .whitespaces
        )

        // 검색어가 비었을 때
        if searchText.isEmpty {
            presentAlert(title: "검색어를 입력하세요.")
            // 검색어도 있고 신조어도 있을 때
        } else if newlyCoinedWordDic.keys.contains(searchText) {
            searchBar.searchTextField.text = nil
            newlyCoinedWordLabel.text = newlyCoinedWordDic[searchText]
            searchBar.searchTextField.resignFirstResponder()
            // 검색어가 비어있지 않지만 없을 때
        } else {
            presentAlert(title: "없는 검색어입니다.")
        }
    }

}

// 랜덤 구성
private extension NewlyCoinedWordViewController {

    // 랜덤으로 신조어들을 가져오기
    // 1. 딕셔너리에서 가져올 때
    var getRandomNewlyConinedWordsAtDictionary: [String] {
        // 신조어 딕셔너리에서 키값만 뽑기
        let newlyConinedWords = newlyCoinedWordDic.keys.map { $0 }

        // 랜덤 신조어를 담을 Set 생성
        // Set으로 생성한 이유는 중복을 제거하기 위해서
        var randomNewlyConinedWords: Set<String?> = []

        // 0...4 범위 설정
        // 최대로 스택뷰에 추가할 버튼의 갯수가 5개이기 때문!
        for _ in 0...4 {
            randomNewlyConinedWords.insert(
                newlyConinedWords.randomElement()
            )
        }

        // 옵셔널 제거해주기
        let result = randomNewlyConinedWords.compactMap { $0 }

        return result
    }

    // 2. 열거형에서 가져올 때
    var getRandomNewlyConinedWordsAtEnum: [NewlyConinedWordKind] {
        let newlyConinedWords = NewlyConinedWordKind.allCases

        var randomNewlyConinedWords: Set<NewlyConinedWordKind?> = []

        for _ in 0...4 {
            randomNewlyConinedWords.insert(
                newlyConinedWords.randomElement()
            )
        }

        let result = randomNewlyConinedWords.compactMap { $0 }

        return result
    }

    // keywordStackView를 랜덤으로 구성하기
    func randomizationKeywordStackView<T: Sequence>(
        sequence: T
    ) {
        let count: Int

        if let sequence = sequence as? [String] {
            // 랜덤으로 가져온 신조어 갯수만큼만 hidden을 false로
            count = sequence.count

            for i in (0...count-1) {
                keywordButtons[i].isHidden = false
                keywordButtons[i].setTitle(
                    sequence[i],
                    for: .normal
                )
            }

            // 이후 버튼들은 false로
            for button in keywordButtons.suffix(from: count) {
                button.isHidden = true
            }
        } else if let sequence = sequence as? [NewlyConinedWordKind] {
            count = sequence.count

            // 랜덤으로 가져온 신조어 갯수만큼만 hidden을 false로
            for i in (0...count-1) {
                keywordButtons[i].isHidden = false
                keywordButtons[i].setTitle(
                    sequence[i].title,
                    for: .normal
                )
            }

            // 이후 버튼들은 false로
            for button in keywordButtons.suffix(from: count) {
                button.isHidden = true
            }
        } else {
            presentAlert(
                title: "딕셔너리 배열도 아니고 열거형 배열도 아닙니다."
            )
        }
    }

    // keywordStackView를 랜덤으로 구성하는 흐름
    func randomizationKeywordStackViewFlow(flag: Bool = false) {
        let sequence: any Sequence

        if flag {
            // 딕셔너리 값 사용하고 싶을 때
            sequence = getRandomNewlyConinedWordsAtDictionary
        } else {
            // 열거형 값 사용하고 싶을 때
            sequence = getRandomNewlyConinedWordsAtEnum
        }

        randomizationKeywordStackView(sequence: sequence)
    }

}
