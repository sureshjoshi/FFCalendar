//
//  FFConstants.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case None
    case Right
    case Left
    case Up
    case Down
    case Crazy
}

let k_ARRAY_WEEK_ABREVIATION = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

let k_MINUTES_INTERVAL: Int = 4
let k_MINUTES_PER_LABEL: Int = 60/k_MINUTES_INTERVAL
let k_HEIGHT_CELL_HOUR: Int = 100
let k_HEIGHT_CELL_MIN: Int = k_HEIGHT_CELL_HOUR/k_MINUTES_INTERVAL

let k_DATE_MANAGER_DATE_CHANGED = "br.com.FFCalendar.DateManager.DateChanged"

let k_SPACE_COLLECTIONVIEW_CELL = 2
let k_HEADER_HEIGHT_SCROLL = 100

let k_CELL = "cell"

let k_QNT_BY_PAGING = 7

let isIphone = (UIDevice.currentDevice().userInterfaceIdiom == .Phone)