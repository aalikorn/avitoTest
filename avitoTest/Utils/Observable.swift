//
//  Observable.swift
//  avitoTest
//
//  Created by Даша Николаева on 08.09.2024.
//

import Foundation

class Observable<T> {
    
    init (_ value: T) {
        self.value = value
    }
    
    private var valueChanged: ((T) -> Void)?
    
    var value: T {
        didSet {
            valueChanged?(value)
        }
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.valueChanged = listener
        listener(value)
    }
}
