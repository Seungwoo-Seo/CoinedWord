//
//  AnniversaryViewController.swift
//  CoinedWord
//
//  Created by 서승우 on 2023/07/20.
//

import UIKit

final class AnniversaryViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    // 그림자 설정할 백그라운드 뷰
    @IBOutlet var backgroundViews: [UIView]!

    // D+100
    @IBOutlet weak var dDay100ImageView: UIImageView!
    @IBOutlet weak var dDay100TitleLabel: UILabel!
    @IBOutlet weak var dDay100Label: UILabel!

    // D+200
    @IBOutlet weak var dDay200ImageView: UIImageView!
    @IBOutlet weak var dDay200TitleLabel: UILabel!
    @IBOutlet weak var dDay200Label: UILabel!

    // D+300
    @IBOutlet weak var dDay300ImageView: UIImageView!
    @IBOutlet weak var dDay300TitleLabel: UILabel!
    @IBOutlet weak var dDay300Label: UILabel!

    // D+400
    @IBOutlet weak var dDay400ImageView: UIImageView!
    @IBOutlet weak var dDay400TitleLabel: UILabel!
    @IBOutlet weak var dDay400Label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

    @IBAction func didValueChangedDatePicker(_ sender: UIDatePicker) {
        presentActionSheet(date: sender.date)
    }

}

private extension AnniversaryViewController {

    // 날짜 계산해주는 메소드
    func dayCalculate(value: Int, date: Date) -> Date? {
        return Calendar.current.date(
            byAdding: .day,
            value: value,
            to: date
        )
    }

    // 날짜를 문자로 바꿔주는 메소드
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let result = formatter.string(from: date)

        return result
    }

    // 액션시트를 생성하고 띄워주는 메소드
    func presentActionSheet(date: Date) {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let dDay100 = UIAlertAction(title: "100", style: .default) { _ in
            // 계산해주고
            let dDay = self.dayCalculate(value: 100, date: date)
            let dDayString = self.dateFormatter(date: dDay!)

            // 레이블 변경
            self.dDay100Label.text = dDayString
        }
        let dDay200 = UIAlertAction(title: "200", style: .default) { _ in
            // 계산해주고
            let dDay = self.dayCalculate(value: 200, date: date)
            let dDayString = self.dateFormatter(date: dDay!)

            // 레이블 변경
            self.dDay200Label.text = dDayString
        }
        let dDay300 = UIAlertAction(title: "300", style: .default) { _ in
            // 계산해주고
            let dDay = self.dayCalculate(value: 300, date: date)
            let dDayString = self.dateFormatter(date: dDay!)

            // 레이블 변경
            self.dDay300Label.text = dDayString
        }
        let dDay400 = UIAlertAction(title: "400", style: .default) { _ in
            // 계산해주고
            let dDay = self.dayCalculate(value: 400, date: date)
            let dDayString = self.dateFormatter(date: dDay!)

            // 레이블 변경
            self.dDay400Label.text = dDayString
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        [
            dDay100,
            dDay200,
            dDay300,
            dDay400,
            cancel
        ].forEach { alert.addAction($0) }

        present(alert, animated: true)
    }

}

// UI 설정
private extension AnniversaryViewController {

    func configureHierarchy() {
        configureDatePicker()
        configureBackgroundViews()

        [
            (dDay100ImageView, UIImage(named: "cake")),
            (dDay200ImageView, UIImage(named: "doughnut")),
            (dDay300ImageView, UIImage(named: "churros")),
            (dDay400ImageView, UIImage(named: "icecream"))
        ].forEach {
            configureDDayImageView($0.0, image: $0.1)
        }

        [
            (dDay100TitleLabel, "D + 100"),
            (dDay200TitleLabel, "D + 200"),
            (dDay300TitleLabel, "D + 300"),
            (dDay400TitleLabel, "D + 400"),
        ].forEach {
            configureDDayTitleLabel($0.0, title: $0.1)
        }

        [
            dDay100Label,
            dDay200Label,
            dDay300Label,
            dDay400Label
        ].forEach {
            configureDDayLabel($0)
        }
    }

    func configureDatePicker() {
        datePicker.tintColor = .systemPink
        datePicker.locale = Locale(identifier: "ko_KR")

        if #available (iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }

    // backgroundViews 구성 메소드
    func configureBackgroundViews() {
        for backgroundView in backgroundViews {
            backgroundView.backgroundColor = .clear
            // 그림자 색상
            backgroundView.layer.shadowColor = UIColor.gray.cgColor
            // 햇빛이 비치는 방향
            backgroundView.layer.shadowOffset = CGSize(
                width: 5,
                height: 10
            )
            // 그림자 불투명도
            backgroundView.layer.shadowOpacity = 0.8
            // 그림자 퍼짐의 정도
            backgroundView.layer.shadowRadius = 5
        }
    }

    // dDayImageView 구성 메소드
    func configureDDayImageView(
        _ imageView: UIImageView,
        image: UIImage?
    ) {
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.layer.cornerRadius = 15
    }

    // dDayTitleLabel 구성 메소드
    func configureDDayTitleLabel(
        _ label: UILabel,
        title: String
    ) {
        label.text = title
        label.textColor = .white
        label.font = .systemFont(
            ofSize: 24.0,
            weight: .bold
        )
    }

    // dDayLabel 구성 메소드
    func configureDDayLabel(_ label: UILabel) {
        label.text = nil
        label.textColor = .white
        label.font = .systemFont(
            ofSize: 17.0,
            weight: .medium
        )
    }

}
