//
//  MovieCollectionViewCell.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    let posterImageView:UIImageView = {
        let mImageView = UIImageView()
        mImageView.backgroundColor = .gray
        mImageView.translatesAutoresizingMaskIntoConstraints = false
        mImageView.layer.cornerRadius = 8
        mImageView.layer.masksToBounds = true
        return mImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        addSubview(posterImageView)
        
        posterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
