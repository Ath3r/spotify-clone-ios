//
//  ActionView.swift
//  spotify
//
//  Created by Ather Hussain on 19/06/21.
//

import UIKit

class ActionLabelView: UIView {
    
    weak var delegate: ActionLabelViewDeleagete?
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        clipsToBounds = true
        addSubview(label)
        addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 0, y: height-40, width: width, height: 40)
        label.frame = CGRect(x: 0, y: 0, width: width, height: height-45)
    }
    
    @objc func didTapButton(){
        delegate?.actionLabelViewDidTapButton(self)
    }
    
    func configure(with viewModel: ActionLabelViewViewModel){
        label.text = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
    }
}
