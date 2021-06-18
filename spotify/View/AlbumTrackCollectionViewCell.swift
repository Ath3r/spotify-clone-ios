//
//  AlbumTrackCollectionViewCell.swift
//  spotify
//
//  Created by Ather Hussain on 18/06/21.
//

import Foundation
import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
        
    private let trackNameLabel: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
        
    private let aristNameLabel: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 6
        
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(aristNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        aristNameLabel.frame = CGRect(
            x: 10,
            y: (contentView.height/2),
            width: contentView.width-15,
            height: (contentView.height/2)
        )
        
        trackNameLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.width-15,
            height: (contentView.height/2)
        )
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        aristNameLabel.text = nil
    }
    
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        aristNameLabel.text = viewModel.artistName
    }
}
