//
//  Created by Александр on 04.09.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation

final class ProgramSettings: Codable {
    var rightAnswers: UInt = 0
    var questions: UInt = 0
    var maxValue: UInt32 = 10
    var useAddition = true
    var useSubstraction = true
    var useMultiplication = true
    var useDivision = true
}
