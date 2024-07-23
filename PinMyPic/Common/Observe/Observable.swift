//
//  Observable.swift
//  PinMyPic
//
//  Created by 하연주 on 7/22/24.
//

import Foundation

final class Observable<T : Any> {
    
    private var closure : ((T)->Void)?
    
    var value : T  {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    

    //onlyCallWhenValueDidSet : 인스턴스 생성될 때는 실행하지 않고 value 변경 시점에만 클로저 실행할 수 있도록 하는 파라미터
    func bind(onlyCallWhenValueDidSet : Bool = false, closure : @escaping (T) -> Void ) {
        if !onlyCallWhenValueDidSet{
            closure(value)
        }

        self.closure = closure
    }
}
