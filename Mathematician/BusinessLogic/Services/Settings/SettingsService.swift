//
//  SettingsService.swift
//  Mathematician
//
//  Created by Александр on 11.04.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation

final class SettingsService: SettingsServiceProtocol {

    private static var shared: SettingsService?

    private let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private let settingsFile = "settings.json"

    var programSettings: ProgramSettings {
        get {
            return loadSettings()
        }
        set(programSettings) {
            saveSettings(settings: programSettings)
        }
    }

    static func sharedSettingsService() -> SettingsService {
        if shared == nil {
            shared = SettingsService()
        }
        return shared!
    }

    private init() {
    }

    private func saveSettings(settings: ProgramSettings) {
        do {
            let json = try JSONEncoder().encode(settings)
            try json.write(to: documentsURL.appendingPathComponent(settingsFile))
        } catch {
            print("Could't create file \(settingsFile) because of error: \(error)")
        }
    }

    private func loadSettings() -> ProgramSettings {
        do {
            let data = try Data(contentsOf: documentsURL.appendingPathComponent(settingsFile))
            let settings = try JSONDecoder().decode(ProgramSettings.self, from: data)
            return settings
        } catch {
            print("Settings isn't be read")
            return ProgramSettings()
        }
    }
}
