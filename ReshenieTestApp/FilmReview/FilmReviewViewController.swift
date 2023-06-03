//
//  FilmReviewViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

final class FilmReviewViewController: UIViewController, FilmReviewModelDelegate {
    func showLoadingView() {
        <#code#>
    }
    
    let filmID: Int
    
    private var filmReviewModel: FilmReviewModel? = nil
    private var filmReviewView: FilmReviewView? = nil
    
    init(filmID: Int) {
        self.filmID = filmID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filmReviewModel = FilmReviewModel(filmID: filmID)
        self.filmReviewModel = filmReviewModel
        filmReviewModel.delagate = self
        
        filmReviewModel.viewDidLoad()
    }
}
