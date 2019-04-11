//
//  Services.swift
//  Mathematician
//
//  Created by Александр on 11.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation

typealias HasServices = HasSettingsService

var Services: MainServices { // swiftlint:disable:this identifier_name
    return MainServices()
}

final class MainServices: HasServices {
    lazy var settingsService: SettingsServiceProtocol = SettingsService.sharedSettingsService()
}
