//
//  CONSTANT.swift
//  Task-SwiftUI
//
//  Created by hakkı can şengönül on 17.06.2022.
//

import SwiftUI

// MARK: - FORMATTER

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI

var backgroundGradient : LinearGradient {
    return LinearGradient(colors: [Color.pink, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - UX

