//
//  ConvertTableViewCell.swift
//  Currency Today
//
//  Created by Student on 07.07.25.
//

import UIKit

class ConvertTableViewCell: UITableViewCell {

    static let identifier = "ConvertTableViewCell"
    
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .systemTeal
        return view
    }()
    private let countryTitle: UILabel = {
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
        contentView.addSubview(countryTitle)
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
        countryTitle.frame = CGRect(
            x: 25 + iconContainer.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 -
            iconContainer.frame.size.width,
            height: contentView.frame.size.height)
        let imageSize:CGFloat = size/1.5
        iconImage.frame = CGRect(
            x: (size - imageSize)/2,
            y: (size - imageSize)/2,
            width: imageSize,
            height: imageSize)
    }
    
    public func configure(with modal : ConvertOption){
        iconContainer.backgroundColor = modal.backgroundColor
        iconImage.image = modal.backgroundImage
        countryTitle.text = modal.name
       
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
