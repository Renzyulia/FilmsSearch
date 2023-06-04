//
//  FilmSearchModel.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

final class FilmSearchModel {
    weak var delegate: FilmSearchModelDelegate?
    
    func didTapBackButton() {
        delegate?.notifyCompletion()
    }
}

protocol FilmSearchModelDelegate: AnyObject {
    func notifyCompletion()
}
