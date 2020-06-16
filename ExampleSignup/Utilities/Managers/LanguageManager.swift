//
//  LanguageManager.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import UIKit

enum SupportedLanguages: CaseIterable {
    case english
    case persian
    case arabic
}

@objc enum LanguageDirections: Int {
    case rtl
    case ltr
}

//sourcery: AutoMockable
protocol LanguageManagerProtocol {
    var currentLanguage: SupportedLanguages { get set }
    var allSupportedLanguages: [SupportedLanguages] { get }
}

class LanguageManager: LanguageManagerProtocol {
    // MARK: - Properties
    static let shared: LanguageManager = LanguageManager()
    
    // Swift 4.2: var allSupportedLanguages = SupportedLanguages.allCases
    var allSupportedLanguages: [SupportedLanguages] = [.english, .persian]
    var currentLanguage: SupportedLanguages {
        set {
            UserDefaultsConfig.currentLanguage = newValue.identifier
            UIView.appearance().semanticContentAttribute = newValue.direction.semantic
            Bundle.setLanguage(newValue.identifier)
        }
        get {
            let identifier = UserDefaultsConfig.currentLanguage
            return SupportedLanguages(identifier: identifier)
        }
    }
    
    // MARK: - Methods
    private init() { self.currentLanguage = .persian}
    
    class func isAValidLanguageIdentifier(_ identifier: String) -> Bool {
        for language in shared.allSupportedLanguages where language.identifier == identifier {
            return true
        }
        return false
    }
}

extension SupportedLanguages {
    var text: String {
        switch self {
        case .arabic:
            return "arabi"
        case .english:
            return "English"
        case .persian:
            return "فارسی"
        }
    }
    
    var identifier: String {
        switch self {
        case .arabic:
            return "ar"
        case .english:
            return "en"
        case .persian:
            return "fa"
        }
    }
    
    var direction: LanguageDirections {
        switch self {
        case .english:
            return .ltr
        case .persian:
            return .rtl
        case .arabic:
            return .rtl
        }
    }
    
    var locale: String {
        switch self {
        case .english:
            return "en-GB"
        case .persian:
            return "fa-IR"
        case .arabic:
            return ""
        }
    }
    
    init (identifier: String?) {
        switch identifier ?? "fa" {
        case "en":
            self = .english
        case "fa":
            self = .persian
        default:
            self = .persian
        }
    }
}

extension LanguageDirections {
    var semantic: UISemanticContentAttribute {
        switch self {
        case .ltr:
            return .forceLeftToRight
        case .rtl:
            return .forceRightToLeft
        }
    }
}
