//
//  UIEdgeInsets.swift
//  PTC_IOS_TEST
//
//  Created by Alizain on 18/06/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

final class PaddedLabel: UILabel {

    private let paddingInsets: UIEdgeInsets

    public init(horizontalInset: CGFloat = 0, verticalInset: CGFloat = 0) {
        self.paddingInsets = UIEdgeInsets(top: verticalInset,
                                          left: horizontalInset,
                                          bottom: verticalInset,
                                          right: horizontalInset)

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let paddedRect = bounds.inset(by: paddingInsets)
        let textRect = super.textRect(forBounds: paddedRect, limitedToNumberOfLines: numberOfLines)

        let invertedInsets = paddingInsets.inverted()
        return textRect.inset(by: invertedInsets)
    }

    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: paddingInsets))
    }
}


fileprivate extension UIEdgeInsets {

    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top,
                            left: -left,
                            bottom: -bottom,
                            right: -right)
    }
}
