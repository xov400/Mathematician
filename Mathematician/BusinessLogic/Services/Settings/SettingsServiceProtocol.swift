//
//  SettingsServiceProtocol.swift
//  Mathematician
//
//  Created by Александр on 11.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation

protocol HasSettingsService {
    var settingsService: SettingsServiceProtocol { get set }
}

protocol SettingsServiceProtocol {
    var programSettings: ProgramSettings { get set }
}
