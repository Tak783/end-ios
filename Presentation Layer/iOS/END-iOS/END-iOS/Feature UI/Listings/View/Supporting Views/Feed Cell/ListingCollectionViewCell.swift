//
//  ListingFeedCollectionViewCell.swift
//  END-iOS
//
//  Created by Tak Mazarura on 15/08/2024.
//

import Foundation
import CorePresentation
import ENDListingsFeature
import Kingfisher
import SnapKit
import UIKit

final class ListingCollectionViewCell: UICollectionViewCell {
    private let productImageView: UIImageView = {
        return generateProductImageLabel()
    }()
    
    private let productNameLabel: UILabel = {
        return generateProductNameLabel()
    }()
    
    private let productPriceLabel: UILabel = {
        return generateProductPriceLabel()
    }()
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
}

// MARK: - Set Up View
extension ListingCollectionViewCell {
    private func setUpView() {
        setUpSubviews()
    }
    
    func update(
        withListing listing: ENDProductPresentationModelling
    ) {
        productNameLabel.text = listing.name
        productPriceLabel.text = listing.price
        updateListingImage(withImageURL: listing.imageURL)
    }
}

// MARK: - Set Up Subviews
extension ListingCollectionViewCell {
    private func setUpSubviews() {
        addSubviewsToView()
        addConstraintsToSubviews()
    }
    
    private func addSubviewsToView() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
    }
    
    private func addConstraintsToSubviews() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Layout.regularMargin)
            make.leading.equalToSuperview().offset(Layout.regularMargin)
            make.trailing.equalToSuperview().offset(-Layout.regularMargin)
            make.height.height.equalTo(200)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(Layout.xSmallMargin)
            make.leading.equalToSuperview().offset(Layout.regularMargin)
            make.trailing.equalToSuperview().offset(-Layout.regularMargin)
        }
   
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(Layout.xSmallMargin)
            make.leading.equalToSuperview().offset(Layout.regularMargin)
            make.trailing.equalToSuperview().offset(-Layout.regularMargin)
        }
    }
}

// MARK: - Helper Methods
extension ListingCollectionViewCell {
    private func updateListingImage(withImageURL imageURL: URL?) {
        guard let imageURL else {
            updateListingImage(givenImageIsPresent: false)
            return
        }
        let source = Source.network(imageURL)
        productImageView.kf.setImage(with: source)
        updateListingImage(givenImageIsPresent: true)
    }
    
    private func updateListingImage(
        givenImageIsPresent imageIsPresent: Bool
    ) {
        productImageView.backgroundColor = imageIsPresent ? .clear : .lightGray
    }
}

// MARK: - View Factory Methods
extension ListingCollectionViewCell {
    private static func generateProductPriceLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }

    private static func generateProductNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }

    private static func generateProductImageLabel() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
}
