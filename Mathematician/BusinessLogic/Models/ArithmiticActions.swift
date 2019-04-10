//
//  Created by Александр on 04.09.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

enum ArithmeticActions: Character {
    case addition = "+"
    case substraction = "-"
    case multiplication = "*"
    case division = "/"

    static var actions: [ArithmeticActions] {
        return [self.addition, self.substraction, self.multiplication, self.division]
    }
}
