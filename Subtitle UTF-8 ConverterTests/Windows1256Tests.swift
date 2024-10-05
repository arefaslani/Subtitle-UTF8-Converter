//
//  Windows1256Tests.swift
//  Subtitle UTF-8 Converter
//
//  Created by Aref Aslani on 05.10.24.
//

import XCTest
@testable import Subtitle_UTF_8_Converter

final class Windows1256Tests: XCTestCase {
    
    // Test conversion of an empty data
    func testConvertEmptyData() {
        let emptyData = Data()
        let result = Windows1256.convert(emptyData)
        XCTAssertEqual(result, "", "Converting empty data should return an empty string.")
    }
    
    // Test conversion of known Windows-1256 data to UTF-8
    func testConvertKnownWindows1256Data() {
        // Prepare a byte array using known Windows-1256 encoded data (e.g., Arabic characters)
        // These bytes represent Arabic "HELLO" in Windows-1256 encoding
        let windows1256Bytes: [UInt8] = [0xD3, 0xE1, 0xC7, 0xE3] // This corresponds to "سلام" in Farsi
        let data = Data(windows1256Bytes)
        
        let expectedString = "سلام"  // Expected Arabic string in UTF-8

        let result = Windows1256.convert(data)
        XCTAssertEqual(result, expectedString, "Windows-1256 data did not convert to the expected UTF-8 string.")
    }

    // Test conversion of some special characters (e.g., Euro sign, Farsi punctuation)
    func testConvertSpecialCharacters() {
        // The Euro sign and Arabic comma in Windows-1256 encoding
        let windows1256Bytes: [UInt8] = [0x80, 0xA1] // 0x80 is Euro, 0xA1 is Farsi comma
        let data = Data(windows1256Bytes)
        
        let expectedString = "€،"  // Euro sign and Arabic comma in UTF-8

        let result = Windows1256.convert(data)
        XCTAssertEqual(result, expectedString, "Special characters did not convert to the expected UTF-8 string.")
    }

    // Test conversion of a full range of values (0x00 - 0xFF)
    func testConvertFullByteRange() {
        var windows1256Bytes = [UInt8]()
        for i in 0x00...0xFF {
            windows1256Bytes.append(UInt8(i))
        }
        let data = Data(windows1256Bytes)
        
        // Manually create the expected string by converting Windows1256 scalars to a string
        let expectedString = Windows1256.scalars.map { String($0) }.joined()

        let result = Windows1256.convert(data)
        XCTAssertEqual(result, expectedString, "Full byte range did not convert to the expected UTF-8 string.")
    }
}
