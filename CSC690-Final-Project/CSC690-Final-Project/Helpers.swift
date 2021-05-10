import Foundation
import UIKit

// A helper function for creating a NSMutableAtributedString with the center part being colored.
// Used to create strings to show the result of the player and boss taking actions.
func create_text_with_color_in_center(part1: String, part2: String, part3: String, a_color: UIColor) -> NSMutableAttributedString{
    let color_attribute: [NSAttributedString.Key: Any] = [.foregroundColor: a_color]
    let result_string = NSMutableAttributedString(string: part1)
    let string_part_2 =  NSAttributedString(string: part2, attributes: color_attribute)
    let string_part_3 = NSAttributedString(string: part3)
    result_string.append(string_part_2)
    result_string.append(string_part_3)
    return result_string
}
