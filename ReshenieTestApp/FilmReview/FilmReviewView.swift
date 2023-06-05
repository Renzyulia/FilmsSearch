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
        
        configureScrollView()
        configurePosterView()
        configureTitleAndReviewLabels()
        configureGenresAndCountriesAndYearLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScrollView() {
        scrollView.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.contentInsetAdjustmentBehavior = .never
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
        posterView.contentMode = .scaleAspectFill
        posterView.clipsToBounds = true
        
        contentView.addSubview(posterView)
        
        posterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 4 / 2.85),
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    private func configureTitleAndReviewLabels() {
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 11
        
        titleLabel.text = titleFilm
        titleLabel.textColor = .black
        titleLabel.font = UIFont.specialFont(size: 20, style: .bold)
        
        reviewLabel.text = reviewFilm
        reviewLabel.textColor = .gray
        reviewLabel.font = UIFont.specialFont(size: 14, style: .regular)
        reviewLabel.numberOfLines = 0
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(reviewLabel)
        
        contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 15),
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
            secondStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10),
            secondStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            secondStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            secondStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    private func configureGenresLabel() {
        let listGenres = NSMutableAttributedString(
            string: "Жанры: ",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .medium),
                .foregroundColor: UIColor.gray
            ]
        )
        
        let secondPart = NSAttributedString(
            string: "\(genres.joined(separator: ", "))",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .regular),
                .foregroundColor: UIColor.gray
            ]
        )
        
        listGenres.append(secondPart)
        genresLabel.attributedText = listGenres
    }
    
    private func configureCountriesLabel() {
        let listCountries = NSMutableAttributedString(
            string: "Страны: ",
            attributes: [
                .font: UIFont.specialFont(size: 14, style: .medium),
                .foregroundColor: UIColor.gray
            ]
        )
        
        let secondPart = NSAttributedString(
            string: "\(countries.joined(separator: ", "))",
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
            string: "Год: ",
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
