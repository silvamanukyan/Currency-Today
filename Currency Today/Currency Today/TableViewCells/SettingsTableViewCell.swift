//
//  SettingsTableViewCell.swift
//  Currency Today
//
//  Created by Student on 07.07.25.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
 
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .systemTeal
        return view
    }()
    private let Label: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.textColor = .black
        return title
    }()
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImage)
        contentView.addSubview(Label)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 10
        iconContainer.frame = CGRect(
            x: 15,
            y: 5,
            width: size,
            height: size)
        
        let imageSize:CGFloat = size/1.5
        iconImage.frame = CGRect(
            x: (size - imageSize)/2,
            y: (size - imageSize)/2,
            width: imageSize,
            height: imageSize)
        
        Label.frame = CGRect(
            x: 25 + iconContainer.frame.size.width,
            y: 5,
            width: contentView.frame.size.width,
            height: size)
    }
    
    public func configure(with model : SettingsOption){
        iconContainer.backgroundColor = model.backgroundColor
        iconImage.image = model.backgroundImage
        Label.text = model.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
