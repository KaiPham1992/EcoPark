//
//  NotificationKey.swift
//  EcoPark
//
//  Created by Ngoc Duong on 12/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
enum NotificationKey: String {
    case NOTIF_ALL
    case NOTIF_ALL_CLIENT
    case NOTIF_ALL_BOSS
    
    case NOTIF_CHECK_TIME_OUT
    case NOTIF_BOOKING_EXPIRED_FOR_CUS
    case NOTIF_BOOKING_EXPIRED_FOR_BOSS
    case THE_WALLET_RUNS_OUT_OF_MONEY
    case NOTIF_PLUS
    case NOTIF_CHECK_TIME_END_PARKING
    case NOTIF_RATING_FOR_CUSTOMER
    case NOTIF_RATING_FOR_BOSS_PARKING
    case NOTIF_REGISTER_BOSS_PARKING
    case NOTIF_BOOKING_FOR_BOSS
    
    case NOTIF_EXTRA
    case NOTIF_STATUS_CANCEL
    case NOTIF_CHECK_INTEND_CHEKCIN_TIME
    case NOTIF_PLUS_MONEY_FOR_BOSS
    case NOTIF_CHECKIN_EARLY
    case NOTIF_CHECKED_OUT
    
}
