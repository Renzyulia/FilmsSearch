//
//  FilmReviewView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

final class FilmReviewView: UIView {
    let posterUrl: URL
    let titleFilm: String
    let reviewFilm: String
    let genres: [String]
    let countries: [String]
    let year: Int
    
    private let posterView = UIImageView()
    private let titleLabel = UILabel()
    private let reviewLabel = UILabel()
    private let genresLabel = UILabel()
    private let countriesLabel = UILabel()
    private let yearLabel = UILabel()
    private let stack = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    init(posterUrl: URL, titleFilm: String, reviewFilm: String, genres: [String], countries: [String], year: Int) {
        self.posterUrl = posterUrl
        self.titleFilm = titleFilm
        self.reviewFilm = reviewFilm
        self.genres = genres
        self.countries = countries
        self.year = year
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScrollView() {
        scrollView.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func configurePosterView() {
        posterView.loadImage(with: posterUrl)
        posterView.contentMode = .scaleAspectFit
        
        contentView.addSubview(posterView)
        
        posterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -247)
        ])
    }
    
    private func configureTitleAndReviewLabels() {
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 52
        
        titleLabel.text = titleFilm
        titleLabel.textColor = .black
        titleLabel.font = UIFont.specialFont(size: 20, style: .bold)
        
        reviewLabel.text = reviewFilm
        reviewLabel.textColor = .gray
        reviewLabel.font = UIFont.specialFont(size: 14, style: .regular)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(reviewLabel)
        
        contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 20),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
    
    private func configureGenresAndCountriesAndYearLabels() {
        let secondStack = UIStackView()
        secondStack.alignment = .leading
        secondStack.axis = .vertical
        secondStack.spacing = 8
        
        configureGenresLabel()
        configureCountriesLabel()
        configureYearLabel()
        
        secondStack.addArrangedSubview(genresLabel)
        secondStack.addArrangedSubview(countriesLabel)
        secondStack.addArrangedSubview(yearLabel)
        
        contentView.addSubview(secondStack)
        
        secondStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 15),
            secondStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            secondStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
    
    private func configureGenresLabel() {
        var genres: String {
            var genres = ""
            
            for genre in genres {
                genres.append(contentsOf: "\(genre), ")
            }
            
            return genres
        }
        
        let listGenres = NSMutableAttributedString(
            string: "Жанры",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .medium),
                .foregroundColor: UIColor.gray
            ]
        )
        
        let secondPart = NSAttributedString(
            string: "\(genres)",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .regular),
                .foregroundColor: UIColor.gray
            ]
        )
        
        listGenres.append(secondPart)
        
        genresLabel.attributedText = listGenres
    }
    
    private func configureCountriesLabel() {
        var countries: String {
            var countries = ""
            
            for country in countries {
                countries.append(contentsOf: "\(country), ")
            }
            
            return countries
        }
        
        let listCountries = NSMutableAttributedString(
            string: "Страны",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .medium),
                .foregroundColor: UIColor.gray
            ]
        )
        
        let secondPart = NSAttributedString(
            string: "\(countries)",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .regular),
                .foregroundColor: UIColor.gray
            ]
        )
        
        listCountries.append(secondPart)
        
        countriesLabel.attributedText = listCountries
    }
    
    private func configureYearLabel() {
        let year = NSMutableAttributedString(
            string: "Год",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .medium),
                .foregroundColor: UIColor.gray
            ]
        )
        
        let secondPart = NSAttributedString(
            string: "\(self.year)",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .regular),
                .foregroundColor: UIColor.gray
            ]
        )
        
        year.append(secondPart)
        
        yearLabel.attributedText = year
    }
}
