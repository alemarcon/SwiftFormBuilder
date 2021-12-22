//
//  StringUtils.swift
//  SwiftFormBuilder
//
//  Created by Alessandro Marcon on 27/05/2021.
//

import Foundation
import UIKit

class StringUtils: NSObject {
    
    /// With given string and words to make of different style return a NSMutableAttributedString associated
    ///
    /// - Parameters:
    ///   - phrase: Complete phrase
    ///   - phraseFont: Whole phrase font
    ///   - phraseColor: Whole phrase color
    ///   - words: An array of words of phrases to change style
    ///   - wordsFont: The new font
    ///   - wordsColor: The color of the new words
    ///   - wordsKey: An array with other keys to modify the words we want in different style
    /// - Returns: Attributed string
    static func getAttributedString(phrase: String, phraseFont: UIFont, phraseColor: UIColor, words: [String], wordsFont: UIFont, wordsColor: UIColor, wordsKey: [NSAttributedString.Key : Any]) -> NSMutableAttributedString {
        
        let modifiedPhrase = NSMutableAttributedString(string: phrase, attributes: [:])
        let phraseLenght = modifiedPhrase.length
        let phraseRange = NSRange(location: 0, length: phraseLenght)
        
        ///Set all basic phrase attributes
        modifiedPhrase.setAttributes([
            NSAttributedString.Key.font: phraseFont,
            NSAttributedString.Key.foregroundColor : phraseColor
            ], range: phraseRange)
        
        ///Prepare basic attributes array of words specified on method
        var wordsAttribute : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: wordsFont,
            NSAttributedString.Key.foregroundColor : wordsColor
        ]
        
        ///Add others keys
        for (key, value) in wordsKey{
            wordsAttribute[key] = value
        }
        
        ///Apply the new style to selected words
        for word in words{
            let wordRange = (modifiedPhrase.string as NSString).range(of: word)
            modifiedPhrase.setAttributes(wordsAttribute, range: wordRange)
        }
        
        return modifiedPhrase
    }
    
}
