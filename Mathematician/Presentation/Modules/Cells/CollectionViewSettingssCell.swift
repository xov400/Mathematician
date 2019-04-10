//
//  Created by Александр on 04.09.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

final class CollectionViewSettingssCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 10.0, y: 10.0, width: self.frame.width - 20, height: self.frame.height - 20)
    }
}
