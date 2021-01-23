//
//  TimerModel.swift
//  Web Scraping Tool
//
//  Created by user on 2021/01/23.
//  Copyright © 2021 256hax. All rights reserved.
//

import Foundation

struct TimerModel {
    let defaultCountdownTimer       = 300.0 // Time Interval (sec).
    let timeInterval                = 0.1   // Reset Timing. Shouldn't set "0.0". It'll be starting minus count down (ex: -0.1).
    let resetCountdownTimerLimit    = 0.1   // Reset Timer Limit (sec). Double is better for usability.
}
