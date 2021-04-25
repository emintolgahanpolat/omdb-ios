//
//  MovieTableViewCell.swift
//  omdb
//
//  Created by Emin Tolgahan Polat on 24.04.2021.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    lazy var poster: UIImageView = {
        let mPoster = UIImageView()
        mPoster.translatesAutoresizingMaskIntoConstraints = false
        return mPoster
    }()
    lazy var title : UILabel={
        let mTitle = UILabel()
        mTitle.translatesAutoresizingMaskIntoConstraints = false
        return mTitle

    }()
    
    lazy var year : UILabel={
        let mYear = UILabel()
        mYear.translatesAutoresizingMaskIntoConstraints = false
        return mYear

    }()
    
    lazy var type : UILabel={
        let mType = UILabel()
        mType.translatesAutoresizingMaskIntoConstraints = false
        return mType

    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       setupUI()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI(){
        
        
        contentView.addSubview(poster)
        contentView.addSubview(title)
        contentView.addSubview(year)
        contentView.addSubview(type)
        
        
        poster.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 8).isActive = true
        poster.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        poster.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 2/5).isActive = true
        poster.heightAnchor.constraint(equalTo: poster.heightAnchor,multiplier: 4/3).isActive = true
        
        
        
        title.leftAnchor.constraint(equalTo: poster.rightAnchor,constant: 8).isActive = true
        title.topAnchor.constraint(equalTo: poster.topAnchor,constant: 24).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -8).isActive = true
        
        
        
        year.leftAnchor.constraint(equalTo: poster.rightAnchor,constant: 8).isActive = true
        year.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 8).isActive = true
        year.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -8).isActive = true
        
        type.leftAnchor.constraint(equalTo: poster.rightAnchor,constant: 8).isActive = true
        type.topAnchor.constraint(equalTo: year.bottomAnchor,constant: 8).isActive = true
        type.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -8).isActive = true
        type.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,constant: -24).isActive = true
        
        
        
    }
}
