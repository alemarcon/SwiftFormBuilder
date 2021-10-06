//
//  String+Extension.swift
//  VTRFormBuilder
//
//  Created by Alessandro Marcon on 26/05/2021.
//

import Foundation
import UIKit
import CommonCrypto
import CryptoKit

extension String {
    
    /// Verifica che una stringa sia un indirizzo e-mail sintatticamente valido
    ///
    /// - Parameter email: email description
    /// - Returns: TRUE if is a valid mail, FALSE otherwise
    func isValidEmailAddress() -> Bool {
        if( self.count > 0 ) {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        } else {
            return false
        }
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func isValidFirstLastName() -> Bool {
        if( self.count > 0 ) {
            return self.range(of: #"^[a-zA-Z]+[^0-9]+$"#, options: .regularExpression) != nil ? true : false
//            return self.range(of: #"\b([A-ZÀ-ÿa-z][-,a-z. ']+[ ]*)+"#, options: .regularExpression) != nil ? true : false
        } else {
            return false
        }
    }
    
    /// Check if password is valid. For now, the only requisite is that
    /// password must be at least 8 chars long
    func isValidPassword() -> Bool {
        
        var regex = ""
        
        let _uppercasedLetterRegex: String = "(?=.*?[A-Z])"
        let _lowercasedLetterRegex: String = "(?=.*?[a-z])"
        let _specialChars: String = "(?=.*?[#?!@$%^&*£|)(-_;,=])"
        let _numbers: String = "(?=.*?[0-9])"
        
        if( VTRPasswordRule.needUppercasedLetter ) {
            regex = _uppercasedLetterRegex
        }
        
        if( VTRPasswordRule.needLowercasedLetter ) {
            regex = "\(regex)\(_lowercasedLetterRegex)"
        }
        
        if( VTRPasswordRule.needSpecialChar ) {
            regex = "\(regex)\(_specialChars)"
        }
        
        if( VTRPasswordRule.needNumber ) {
            regex = "\(regex)\(_numbers)"
        }
        
        regex = "\(regex).{\(VTRPasswordRule.minLength),\(VTRPasswordRule.maxLength)}"
        
        if( self.count >= VTRPasswordRule.minLength && self.count <= VTRPasswordRule.maxLength ) {
            //^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*£|)(-;]).{8,}$ // Include at least 1 number
            if( regex.isEmpty ) {
                return true
            } else {
                return self.range(of: #"^\#(regex)$"#, options: .regularExpression) != nil ? true : false
            }
        } else {
            return false
        }
    }
    
    /// Check is fiscal code is valid or not.
    /// - Returns: TRUE if is a syntactical valid fiscal code, FALSE otherwise
    func isValidFiscalCode() -> Bool {
        return self.range(of: #"^([A-Za-z]{6}[0-9LMNPQRSTUVlmnpqrstuv]{2}[ABCDEHLMPRSTabcdehlmprst]{1}[0-9LMNPQRSTUVlmnpqrstuv]{2}[A-Za-z]{1}[0-9LMNPQRSTUVlmnpqrstuv]{3}[A-Za-z]{1})$|([0-9]{11})$"#, options: .regularExpression) != nil ? true : false
    }
    
    /// Check if is a regular phone number. To be a regular phone number can contains only numbers, or + sign and no more
    /// - Returns: TRUE if phone number is valid, FALSE otherwise
    func isValidPhoneNumber() -> Bool {
        return self.range(of: #"^[+]*[0-9]{1,4}[0-9]*$"#, options: .regularExpression) != nil ? true : false
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont, lineHeight: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: style],
                                            context: nil)
        
        return ceil(boundingBox.height)
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        
        return ceil(boundingBox.width)
    }
    
    
    func htmlToStringWithFont(font:UIFont, hasLink:Bool) -> NSAttributedString? {
        guard let data = NSString(string: self.replacingOccurrences(of: "<![CDATA[", with: "").replacingOccurrences(of: "]]>", with: "")).data(using: String.Encoding.utf8.rawValue) else { return nil }
            do {
                let attrStr = try NSAttributedString(data: data,
                                              options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                              documentAttributes: nil)
                let range = NSRange(location: 0, length: attrStr.length)
                let str = NSMutableAttributedString(attributedString: attrStr)
                str.addAttributes([NSAttributedString.Key.font: font], range: range)
                str.addAttribute(NSAttributedString.Key.underlineStyle, value: 0, range: range)
                if !hasLink {
                    str.removeAttribute(.link, range: range)
                    str.removeAttribute(.foregroundColor, range: range)
                    str.removeAttribute(.underlineStyle, range: range)
                }
                return NSAttributedString(attributedString: str.attributedSubstring(from: range))
            } catch {}
        return nil
    }
    
    public func htmlAttributedString(regularFont: UIFont, boldFont: UIFont, color: UIColor, lineSpacing: CGFloat = 1.0, alignCenter: Bool = false) -> NSAttributedString {
        
        let encoding = String.Encoding.utf16
        guard let descriptionData = self.replacingOccurrences(of: "<![CDATA[", with: "").replacingOccurrences(of: "]]>", with: "").data(using: encoding) else {
            return NSAttributedString()
        }
        guard let attributedString = try? NSMutableAttributedString(data: descriptionData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return NSAttributedString()
        }

        let fullRange = NSMakeRange(0, attributedString.length)

        var regularRanges: [NSRange] = []
        var boldRanges: [NSRange] = []

        attributedString.beginEditing()
        attributedString.enumerateAttribute(NSAttributedString.Key.font, in: fullRange, options: .longestEffectiveRangeNotRequired) { (value, range, stop) in
            guard let font = value as? UIFont else {
                return
            }
            if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                boldRanges.append(range)
            } else {
                regularRanges.append(range)
            }
        }

        for range in regularRanges {
            attributedString.addAttribute(NSAttributedString.Key.font, value: regularFont, range: range)
        }

        for range in boldRanges {
            attributedString.addAttribute(NSAttributedString.Key.font, value: boldFont, range: range)
        }

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: fullRange)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        
        if( alignCenter ) {
            let centered = NSMutableParagraphStyle()
            centered.alignment = .center
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: centered, range: fullRange)
        }

        attributedString.endEditing()

        return attributedString
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    var containsSpecialCharacter: Bool {
       let regex = ".*[^A-Za-z0-9].*"
       let testString = NSPredicate(format:"SELF MATCHES %@", regex)
       return testString.evaluate(with: self)
    }
    
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
    
    var md5: String {
        if #available(iOS 13.0, *) {
            let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
            return computed.map { String(format: "%02hhx", $0) }.joined()
        }else {
            let data = Data(self.utf8)
            let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
                var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
                CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
                return hash
            }
            return hash.map { String(format: "%02x", $0) }.joined()
        }
    }
}
