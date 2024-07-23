//
//  NicknameSettingViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation


final class NicknameSettingViewModel {

    let userInfoRepository = UserInfoRepository()
    
    //in
    //닉네임 textField 입력 - shouldChangeCharactersIn 시점
    var inputNicknameWillReplaced = Observable("")
    //닉네임 textField 입력 - editingChanged 시점
    var inputNicknameText : Observable<String?> = Observable(nil)
    // viewDidLoad 시점에 랜덤으로 프로필 사진 세팅해줄 때
    var inputViewDidLoadTrigger : Observable<Void?> = Observable(nil)
    //프로필 세팅 유효성을 모두 통과한 시점에 유저 프로필을 저장할 수 있도록
    var inputPermitToSaveProfile : Observable<UserInfo?> = Observable(nil)
    
    
    
    
    //out
    //유효성 알려줄 label
    var outputValidationNoticeText = Observable("")
    //입력한 문자 유효성 여부
    var outputChatacterValidation = Observable(false)
    //입력한 인풋 count 유효성에 대한 문자 자르기 여부
    var outputCountResettingNicknameText = Observable("")
    //랜덤으로 프로필 사진 세팅
    var outputRamdomProfileImageName = Observable("")
    //프로필 세팅하거나 수정완료하고 저장 잘 됐을 때 페이지 이동할 수 있도록
    var outputPermitToPageTransition : Observable<Void?> = Observable(nil)
    
    
    init() {
        inputNicknameWillReplaced.bind { [weak self] value in
            guard let self else {return }
            self.outputChatacterValidation.value = self.whetherToKeepChanging(replacementString: value)
        }
        
        inputNicknameText.bind {[weak self] value in
            guard let self else {return }
            validateNicknameCount(inputValue : value)
        }
        
        inputViewDidLoadTrigger.bind {[weak self] _ in
            guard let self else {return }
            let ramdomProfileImageName = ProfileImageName.returnRandomProfileImageName()
            //랜덤으로 선택된 이미지 화면에 반영
            self.outputRamdomProfileImageName.value = ramdomProfileImageName
        }
        
        inputPermitToSaveProfile.bind(onlyCallWhenValueDidSet: true) { [weak self] value in
            guard let self, let value else {return }
            //realm에 데이터 저장하기
            self.saveUserData(profile : value)
        }
    }
    
    private func saveUserData(profile : UserInfo) {
        print("💚💚profile💚💚", profile)
//        userInfoRepository.createItem(profile)
        outputPermitToPageTransition.value = ()
    }
    
    
    private func whetherToKeepChanging (replacementString string: String) -> Bool {
        var returnResult = false
        
        do{
            returnResult = try validateNicknameInputCharacter(willBeReplaced: string)
        } catch (let nicknammeError as NicknameInputError) {
            print("validateNicknameInputCharacter error", nicknammeError)
            
            outputValidationNoticeText.value = nicknammeError.validationNoticeText()

        }catch {
            print(error)
        }

        return returnResult
    }
    
    
    private func validateNicknameCount(inputValue : String?) {
        do {
            try validateNicknameInputCount(text: inputValue)
            
        } catch (let nicknammeError as NicknameInputError) {
            print("validateNicknameInputCharacter error", nicknammeError)
            
            outputValidationNoticeText.value = nicknammeError.validationNoticeText()
        }catch {
            print(error)
        }
    }
    
    
    ///닉네임 유효성 검증 - 1)  곧 입력될 문자 판벌 (shouldChangeCharactersIn 시점)
    private func validateNicknameInputCharacter(willBeReplaced : String) throws -> Bool {
        let invalidSpecialCharaters = Constants.NicknameValidation.invalidSpecialCharaters

        if let index = invalidSpecialCharaters.firstIndex(of: willBeReplaced) {
            throw NicknameInputError.specialCharacterInput(character: invalidSpecialCharaters[index])
        }
        
        if let _ = Int(willBeReplaced) {
            throw NicknameInputError.numberInput
        }
        
        outputValidationNoticeText.value = ""
        return true
    }
    
    ///닉네임 유효성 검증 - 2)  입력된 후 count 판별 (.editingChanged 시점)
    private func validateNicknameInputCount(text : String?) throws {
        let textMinCount = Constants.NicknameValidation.textMinCount
        let textMaxCount = Constants.NicknameValidation.textMaxCount
        
        guard let text else {return }
        
        if (text.count) < textMinCount {
            throw NicknameInputError.lessThanMinAmount
        }

        if (text.count) > textMaxCount {
            outputCountResettingNicknameText.value = String(text.dropLast())
            throw NicknameInputError.moreThanMaxAmount
        }
        
        outputValidationNoticeText.value = ""
    }

}
