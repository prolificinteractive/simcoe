//
//  CartLogging.swift
//  Simcoe
//
//  Created by Michael Campbell on 9/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  Defines functionality for logging cart actions.
 */
public protocol CartLogging: AnalyticsTracking {

    /**
     Logs the addition of a product to the cart.

     - parameter productName:          The name of the product added to the cart.
     - parameter productId:            The productId of the product.
     - parameter quantity:             The quantity of the product added to the cart.
     - parameter price:                The price of the product.
     - parameter additionalProperties: The properties that can be added to a product. See `MPProductKeys`

     - returns: A tracking result.
     */
    func logAddToCart(productName: String,
                      productId: String,
                      quantity: Int,
                      price: Double?,
                      withAdditionalProperties additionalProperties: Properties?) -> TrackingResult

    /**
     Logs the removal of a product from the cart.

     - parameter productName: The name of the product added to the cart.
     - parameter productId:   The productId of the product.
     - parameter quantity:    The quantity of the product added to the cart.
     - parameter price:       The price of the product.
     - parameter properties:  The properties that can be added to a product. See `MPProductKeys`

     - returns: A tracking result.
     */
    func logRemoveFromCart(productName: String,
                           productId: String,
                           quantity: Int,
                           price: Double?,
                           withAdditionalProperties properties: Properties?) -> TrackingResult
    
}
