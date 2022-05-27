//
//  NordNumberUtil.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import Foundation


public class NordNumberUtil {

    public static let NORD_CHARS = Array<String>(arrayLiteral: "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
            "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z");
    public static let NORD_CHARS_A_TO_B = Array<String>(arrayLiteral: "A", "B");
    public static let NORD_CHARS_A_TO_D = Array<String>(arrayLiteral: "A", "B", "C", "D");
    private static let NORD_NUMBERS_0_TO_9 = Array<String>(arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
    private static let NORD_NUMBERS_1_TO_8 = Array<String>(arrayLiteral: "1", "2", "3", "4", "5", "6", "7", "8");
    private static let NORD_NUMBERS_1_TO_2 = Array<String>(arrayLiteral: "1", "2");
    private static let NORD_NUMBERS_0_TO_2 = Array<String>(arrayLiteral: "0", "1", "2");
    private static let NORD_NUMBERS_1_TO_5 = Array<String>(arrayLiteral: "1", "2", "3", "4", "5");
    private static let NORD_NUMBERS_1_TO_4 = Array<String>(arrayLiteral: "1", "2", "3", "4");

    public static let NORD_NUMBER_VALUES_1_TO_5 = Array<String>(arrayLiteral: "11", "12", "13", "14", "15", "21", "22",
            "23", "24", "25", "31", "32", "33", "34", "35", "41", "42", "43", "44", "45", "51", "52", "53", "54", "55");

    public static let NORD_NUMBER_VALUES_1_TO_4 = Array<String>(arrayLiteral: "11", "12", "13", "14", "21", "22", "23",
            "24", "31", "32", "33", "34", "41", "42", "43", "44");

    public static func isNordChar( x: String) -> Bool{
        return isElementOf(x: x, amount: NORD_CHARS);
    }

    public static func isNumber( x: String,  from: Int,  to: Int) -> Bool {
        let number = Int(x);
        if number != nil {
            return number! >= from && number! <= to;
        }
        return false;
    }

    public static func isNumber1To8(x: String) -> Bool{
        return isNumber(x: x, from: 1, to: 8);
    }

    public static func isNumber1To128(x: String) -> Bool{
        return isNumber(x: x, from: 1, to: 128);
    }
    
    public static func isNumber1To50( x: String)->Bool {
        return isNumber(x: x, from: 1, to: 50);
    }

    public static func isElementOf( x: String, amount: Array<String>) -> Bool{
        for a in amount {
            if a == x{
                return true;
            }
        }
        return false;
//        return amount.stream().filter(n -> n.charAt(0) == x).findFirst().isPresent();
    }

    public static func isNordCharAToD( x: String) ->Bool{
        return isElementOf(x: x, amount: NORD_CHARS_A_TO_D);
    }

    public static func isNordCharAToB( x: String) ->Bool{
        return isElementOf(x: x, amount: NORD_CHARS_A_TO_B);
    }

    public static func isNordNumber1To8( x: String) -> Bool{
        return isElementOf(x: x, amount: NORD_NUMBERS_1_TO_8);
    }

    public static func isNordNumber1To2( x: String) -> Bool {
        return isElementOf(x: x, amount: NORD_NUMBERS_1_TO_2);
    }

    public static func isNordNumber0To2( x: String) -> Bool{
        return isElementOf(x: x, amount: NORD_NUMBERS_0_TO_2);
    }

    public static func isNordNumber1To4( x: String) -> Bool{
        return isElementOf(x: x, amount: NORD_NUMBERS_1_TO_4);
    }

    public static func isNordNumber1To5( x: String) -> Bool{
        return isElementOf(x: x, amount: NORD_NUMBERS_1_TO_5);
    }

    public static func isNordNumber0To9( x: String)-> Bool {
        return isElementOf(x: x, amount: NORD_NUMBERS_0_TO_9);
    }
}
