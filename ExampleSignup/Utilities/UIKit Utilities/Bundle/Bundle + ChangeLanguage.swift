//
//  Bundle + ChangeLanguage.swift
//  ExampleSignup
//
//  Created by Mohammad Zakizadeh on 6/16/20.
//  Copyright © 2020 Communere. All rights reserved.
//

import Foundation
import ObjectiveC

private var associatedLanguageBundle: Character = "0"

class PrivateBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle: Bundle? = objc_getAssociatedObject(self, &associatedLanguageBundle) as? Bundle
        return (bundle != nil) ? (bundle!.localizedString(forKey: key, value: value, table: tableName)) : (super.localizedString(forKey: key, value: value, table: tableName))
        
    }
}

func NSLocalizedString(_ key: String, comment: String) -> String {
    return Foundation.NSLocalizedString(key, comment: comment).replacingOccurrences(of: "\\n", with: "\n")
}

extension Bundle {
    class func setLanguage(_ language: String) {
        var onceToken: Int = 0
        
        if onceToken == 0 {
            object_setClass(Bundle.main, PrivateBundle.self)
        }
        onceToken = 1
        var bundleName = language
        if bundleName == "en" {
            bundleName = "Base"
        }
        objc_setAssociatedObject(Bundle.main, &associatedLanguageBundle, Bundle(path: Bundle.main.path(forResource: bundleName, ofType: "lproj") ?? ""), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
