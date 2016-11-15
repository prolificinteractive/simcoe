//
//  Simcoe+mParticle.swift
//  Simcoe
//
//  Created by John Lin on 6/15/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

extension Simcoe {
    
    /**
     Logs the error with optional additional properties.
     
     - parameter error:      The error to log.
     - parameter properties: The optional additional properties.
     */
    public static func logError(error: String, withAdditionalProperties properties: Properties? = nil) {
        engine.logError(error, withAdditionalProperties: properties)
    }
    
    /**
     Sets the User Attribute.
     
     - parameter key:   The key of the user attribute
     - parameter value: the value of the user attribute
     */
    public static func setUserAttribute(key: String, value: AnyObject) {
        engine.setUserAttribute(key, value: value)
    }
    
    /**
     Logs the error with optional additional properties.
     
     - parameter error:      The error to log.
     - parameter properties: The optional additional properties.
     */
    func logError(error: String, withAdditionalProperties properties: Properties? = nil) {
        let providers: [ErrorLogging] = findProviders()
        
        let propertiesString = properties != nil ? "=> \(properties!.description)" : ""
        write(toProviders: providers, description: "Error: \(error) \(propertiesString)") { errorLogger in
            return errorLogger.logError(error, withAdditionalProperties: properties)
        }
    }
    
    /**
     Sets the User Attribute.
     
     - parameter key:   The key of the user attribute
     - parameter value: the value of the user attribute
     */
    func setUserAttribute(key: String, value: AnyObject) {
        let providers: [UserAttributes] = findProviders()
        
        write(toProviders: providers, description: "Setting user attribute with key: \(key) value:\(value)") { attributeSetter in
            return attributeSetter.setUserAttribute(key, value: value)
        }
    }
    
    private func findProviders<T>() -> [T] {
        return providers
            .map { provider in return provider as? T }
            .flatMap { $0 }
    }

}
