//
//  AutoAddPaddingButtton.swift
//  CoinedWord
//
//  Created by 서승우 on 2023/07/24.
//

import UIKit

final class AutoAddPaddingButtton : UIButton {

    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(
                width: baseSize.width + 16,
                height: baseSize.height
            )
        }
    }

}
