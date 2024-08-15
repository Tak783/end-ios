//
//  ListingDetailViewController.swift
//  END-iOS
//
//  Created by Tak Mazarura on 15/08/2024.
//

import CoreFoundational
import CorePresentation
import ENDListingsFeature
import Kingfisher
import SnapKit
import UIKit

final class ListingDetailViewController: UIViewController {
    private let productImageView: UIImageView = {
        return generateProductImageLabel()
    }()
    
    private let productNameLabel: UILabel = {
        return generateProductNameLabel()
    }()
    
    private let productPriceLabel: UILabel = {
        return generateProductPriceLabel()
    }()
    
    var feedViewModel: ListingDetailViewModelling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
}

// MARK: - Set Up View
extension ListingDetailViewController {
    private func setUpView() {
        view.backgroundColor = .systemBackground
        
        setUpSubviews()
        populateViewWithData()
    }
    
    private func populateViewWithData() {
        guard let presentationModel = feedViewModel?.presentationModel else {
            return
        }
        update(
            withListing: presentationModel
        )
    }
    
    private func update(
        withListing listing: ENDProductDetailPresentationModelling
    ) {
        productNameLabel.text = listing.name
        productPriceLabel.text = listing.price
        updateListingImage(withImageURL: listing.imageURL)
    }
}

// MARK: - Set Up Subviews
extension ListingDetailViewController {
    private func setUpSubviews() {
        addSubviewsToView()
        addConstraintsToSubviews()
    }
    
    private func addSubviewsToView() {
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productPriceLabel)
    }
    
    private func addConstraintsToSubviews() {
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(navigationBarHeight() + Layout.smallMargin * 2)
            make.leading.equalToSuperview().offset(Layout.regularMargin)
            make.trailing.equalToSuperview().offset(-Layout.regularMargin)
        }
   
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(Layout.xSmallMargin)
            make.leading.equalToSuperview().offset(Layout.regularMargin)
            make.trailing.equalToSuperview().offset(-Layout.regularMargin)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(productPriceLabel.snp.top).offset(Layout.regularMargin)
            make.leading.equalToSuperview().offset(Layout.regularMargin)
            make.trailing.equalToSuperview().offset(-Layout.regularMargin)
            make.height.height.equalTo(400)
        }
    }
}

// MARK: - Helper Methods
extension ListingDetailViewController {
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
extension ListingDetailViewController {
    private static func generateProductPriceLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }

    private static func generateProductNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
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

// MARK: - View Controller + NavigationBarHeight
extension UIViewController {
    fileprivate func navigationBarHeight() -> CGFloat {
        guard let navigationController = navigationController else {
            return 0
        }
        let navigationBarFrame = navigationController.navigationBar.frame
        let statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        let totalHeight = statusBarFrame.height + navigationBarFrame.height
        return totalHeight
    }
}
