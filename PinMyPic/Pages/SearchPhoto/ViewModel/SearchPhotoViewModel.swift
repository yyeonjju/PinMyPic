//
//  SearchPhotoViewModel.swift
//  PinMyPic
//
//  Created by 하연주 on 7/26/24.
//

import Foundation


final class SearchPhotoViewModel {
    
    var page = 0
    
    //input
    //search button clicked -> page 1
    var inputSearchKeyword : Observable<String?> = Observable(nil)
    //prefetch
    var inputPrefetchForPagenation : Observable<Void?> = Observable(nil)
    
    
    //output
    //검색 결과
    var outputSearchResult : Observable<SearchPhoto?> = Observable(nil)
    //에러 메세지
    var outputErrorMessage : Observable<String?> = Observable(nil)
    
    
    init(){
        setupBind()
        
    }
    
    
    private func setupBind(){
        
        inputSearchKeyword.bind(onlyCallWhenValueDidSet: true) {[weak self] keyword in
            guard let self, let keyword else{return}
            page = 1
            self.getSearchList(keyword)
            
        }
        
        inputPrefetchForPagenation.bind(onlyCallWhenValueDidSet: true) {[weak self] _ in
            guard let self, let keyword = self.inputSearchKeyword.value else{return}
            page += 1
            self.getSearchList(keyword)
        }
        
        
    }
    
    
    
    private func getSearchList(_ keyword: String) {
        
        guard !isOnlyWhitespace(keyword) else{return}
            
        APIFetcher.shared.getSearchPhoto(keyword: keyword, page : page) { [weak self] result in
            guard let self else{return}
            switch result {
            case .success(let value):
                if page < 2 {
                    outputSearchResult.value = value
                }else {
                    outputSearchResult.value?.results.append(contentsOf: value.results)
                }

            case .failure(let failure):
                self.outputErrorMessage.value = failure.errorMessage
            }
        }
    }
    
    
}
