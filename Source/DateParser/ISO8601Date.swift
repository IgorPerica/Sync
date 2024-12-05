//
//  ISO8601Date.swift
//  Project
//
//  Created by Igor Perica on 05.12.2024..
//

import Foundation

@objc public class ISO8601DateParser: NSObject {
    @objc public func parseISO8601Date(dateAsString: String) -> Date? {
        // Attempt to parse the ISO8601 date string
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        return formatter.date(from: dateAsString)
    }
}
