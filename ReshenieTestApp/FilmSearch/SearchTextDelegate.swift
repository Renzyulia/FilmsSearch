//
//  SearchTextDelegate.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

final class FilmSearchTextDelegate: NSObject, UITextFieldDelegate {
    weak var delegate: FilmSearchModel?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didTapSearchButton()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != " " {
            delegate?.searchWord = textField.text
        }
    }
}
