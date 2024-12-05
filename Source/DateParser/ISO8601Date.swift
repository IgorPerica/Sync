//
//  ISO8601Date.swift
//  Project
//
//  Created by Igor Perica on 05.12.2024..
//

import Foundation

@objc public class ISO8601DateParser: NSObject {

    static let sharedInstance = ISO8601DateParser()
    let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    @objc public class func parseISO8601Date(dateAsString: String) -> Date? {
        // Attempt to parse the ISO8601 date string
        return sharedInstance.dateFormatter.date(from: dateAsString)
    }
}
