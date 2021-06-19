//
//  PlayerControlsView.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import Foundation
import UIKit

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private var isPlaying = true
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "backward.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 34,
                weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "forward.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 34,
                weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let pausePlayButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "pause",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 34,
                weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor =  .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(pausePlayButton)
        
        clipsToBounds = true
        
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        pausePlayButton.addTarget(self, action: #selector(didTapPausePlay), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize: CGFloat = 60.0
        
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width, height: 44)
        
        pausePlayButton.frame = CGRect(
            x: (width-buttonSize)/2,
            y: volumeSlider.bottom+30,
            width: buttonSize,
            height: buttonSize
        )
        backButton.frame = CGRect(
            x: pausePlayButton.left-80-buttonSize,
            y: pausePlayButton.top,
            width: buttonSize,
            height: buttonSize
        )
        nextButton.frame = CGRect(
            x: pausePlayButton.right+80,
            y: pausePlayButton.top,
            width: buttonSize,
            height: buttonSize
        )
    }
    
    @objc private func didTapBack(){
        delegate?.playerControlsViewDidTapBackwardsButton(self)
    }
    
    @objc private func didTapPausePlay(){
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPause(self)
        let pause = UIImage(
            systemName: "pause",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 34,
                weight: .regular)
        )
        let play = UIImage(
            systemName: "play.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 34,
                weight: .regular)
        )
        
        pausePlayButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    @objc private func didTapNext(){
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }
    
    func configure(with viewModel: PlayerControlsViewViewModel){
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
}
