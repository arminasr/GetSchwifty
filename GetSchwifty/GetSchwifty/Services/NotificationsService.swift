//
//  NotificationsService.swift
//  GetSchwifty
//
//  Created by Arminas Ruzgas on 18/11/2019.
//  Copyright © 2019 Arminas. All rights reserved.
//

import Foundation
import UserNotifications
import SwiftConferencesDataKit

class NotificationsService: NSObject {
    
    enum NotificationType {
        case conferenceStarting
    }
    
    func notificationRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound],
                                                                completionHandler: {_,_ in })
    }
    
    func scheduleNotification(with notificationType: NotificationType, for conference: Conference) {
        let notificationContent = getNotificationContent(notificationType, conference)
        guard let notificationTrigger = getNotificationTrigger(for: conference) else {
            return
        }

        let request = UNNotificationRequest(identifier: "LocalNotifications",
                                            content: notificationContent,
                                            trigger: notificationTrigger)
        setNotificationActions(request, conference)
    }
    
    private func getNotificationContent(_ notificationType: NotificationsService.NotificationType, _ conference: Conference) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = getTitle(for: notificationType, conference: conference)
        content.body = getBody(for: notificationType, conference: conference)
        content.sound = UNNotificationSound.default
        
        return content
    }
    
    private func getNotificationTrigger(for conference: Conference) -> UNNotificationTrigger? {
        guard let conferenceStartDate = conference.start else {
            return nil
        }
        guard let startDate = Calendar.current.date(bySettingHour: 9,
                                                    minute: 30,
                                                    second: 0,
                                                    of: conferenceStartDate) else {
            return nil
        }
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day, Calendar.Component.hour,.minute,.second,],
                                                          from: startDate)
        return UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                             repeats: false)
    }
    
    private func setNotificationActions(_ request: UNNotificationRequest, _ conference: Conference) {
        UNUserNotificationCenter.current().add(request) { error in
            print("Error: \(String(describing: error?.localizedDescription))")
        }
        
        let moreInfoAction = UNNotificationAction(identifier: "MoreInfo",
                                                  title: "More about \(conference.name)",
            options: [.foreground])
        let deleteAction = UNNotificationAction(identifier: "Delete",
                                                title: "Delete",
                                                options: [.destructive])
        let category = UNNotificationCategory(identifier: "Actions",
                                              actions: [moreInfoAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    private func getTitle(for notificationWithType: NotificationType, conference: Conference) -> String {
        switch notificationWithType {
        case .conferenceStarting:
            return "\(conference.name) starting!"
        }
    }
    
    private func getBody(for notificationWithType: NotificationType, conference: Conference) -> String {
        switch notificationWithType {
        case .conferenceStarting:
            return "Read more about the \(conference.name) and follow it's progress."
        }
    }
}
