//
//  AppStoreReviewManager.swift
//  Line Jumpr
//
//  Created by Tony Martini on 3/7/21.
//

import StoreKit

enum AppStoreReviewManager {
  static func requestReviewIfAppropriate() {
    SKStoreReviewController.requestReview()
  }
}
