//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by Nikita Shakalov on 9/27/23.
//

import UIKit

class HeroHeaderUIView: UIView {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
