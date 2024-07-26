//
//  SearchPhotoViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/26/24.
//

import Foundation


final class SearchPhotoViewModel {
    
    //input
    //search button clicked
    var inputSearchButtonClicked : Observable<String?> = Observable(nil)
    
    
    
    
    
    //output
    //검색 결과
    var outputSearchResult : Observable<SearchPhoto?> = Observable(nil)
    //에러 메세지
    var outputErrorMessage : Observable<String?> = Observable(nil)
    
    
    
    
    init(){
        setupBind()
        
    }
    
    
    private func setupBind(){
        
        inputSearchButtonClicked.bind(onlyCallWhenValueDidSet: true) {[weak self] keyword in
            guard let self, let keyword else{return}
            
            if !isOnlyWhitespace(keyword) {
                self.getSearchList(keyword)
            }
        }
        
        
    }
    
    
    
    private func getSearchList(_ keyword: String) {
        APIFetcher.shared.getCurrenWeather(keyword: keyword) { [weak self] result in
            guard let self else{return}
            switch result {
            case .success(let value):
                outputSearchResult.value = value
            case .failure(let failure):
                self.outputErrorMessage.value = failure.errorMessage
            }
        }
    }
    
    
}
