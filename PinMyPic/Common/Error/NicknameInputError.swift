//
//  NicknameInputError.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation

enum NicknameInputError : Error {
    case specialCharacterInput(character : String)
    case numberInput
    case lessThanMinAmount
    case moreThanMaxAmount
    case invalidateAmount
    
    func validationNoticeText() -> String {
        switch self {
        case .specialCharacterInput(let invalidCharacter):
            return Texts.NicknameValidationNoticeText.invalidCharacter(invalid: invalidCharacter)
        case .numberInput:
            return Texts.NicknameValidationNoticeText.invalidNumber
        case .lessThanMinAmount, .moreThanMaxAmount, .invalidateAmount:
            return Texts.NicknameValidationNoticeText.invalidCount
        }
    }
    
}
