//
//  Created by Александр on 04.09.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 1.0, y: 1.0, width: self.frame.width - 2, height: self.frame.height - 2)
        label.font = label.font.withSize(label.bounds.height / 1.7)
    }
}
