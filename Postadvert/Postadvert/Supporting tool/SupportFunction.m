//
//  SupportFunction.m
//  Postadvert
//
//  Created by Mtk Ray on 7/27/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "SupportFunction.h"

@implementation SupportFunction


+(NSInteger) GetCountryIdFromConutryName:(NSString*)countryName
{
    if ([[countryName uppercaseString] isEqualToString:[@"Australia" uppercaseString]]) {
        return 14;
    }
    
    if ([[countryName uppercaseString] isEqualToString:[@"Canada" uppercaseString]]) {
        return 36;
    }
    
    if ([[countryName uppercaseString] isEqualToString:[@"United Kingdom" uppercaseString]]) {
        return 75;
    }
    
    if ([[countryName uppercaseString] isEqualToString:[@"Malaysia" uppercaseString]]) {
        return 151;
    }
    
    if ([[countryName uppercaseString] isEqualToString:[@"Singapore" uppercaseString]]) {
        return 190;
    }
    
    if ([[countryName uppercaseString] isEqualToString:[@"United States" uppercaseString]]) {
        return 223;
    }
    
    
    //Default singapore
    return 190;
}

+ (NSInteger) getWallIdFromCountryID:(NSInteger)countryID andItemName:(NSString*)itemName
{
    NSLog(@"Item Name %@", itemName);
    if ([[itemName uppercaseString] isEqualToString:[@"BlogShop Xpress" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 1;
                break;
            case 14:
                
                return 7;
                break;
            case 36:
                return 13;
                break;
            case 75:
                return 19;
                break;
            case 151:
                return 25;
                break;
            case 223:
                return 31;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Business Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 42;
                break;
            case 14:
                
                return 50;
                break;
            case 36:
                return 58;
                break;
            case 75:
                return 66;
                break;
            case 151:
                return 74;
                break;
            case 223:
                return 82;
                break;
        }

    }
    if ([[itemName uppercaseString] isEqualToString:[@"Cars Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 39;
                break;
            case 14:
                
                return 47;
                break;
            case 36:
                return 55;
                break;
            case 75:
                return 63;
                break;
            case 151:
                return 71;
                break;
            case 223:
                return 79;
                break;
        }

    }
    if ([[itemName uppercaseString] isEqualToString:[@"Cars Xpress" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 4;
                break;
            case 14:
                
                return 10;
                break;
            case 36:
                return 16;
                break;
            case 75:
                return 22;
                break;
            case 151:
                return 28;
                break;
            case 223:
                return 34;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Co-broke Xpress" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 2;
                break;
            case 14:
                
                return 8;
                break;
            case 36:
                return 14;
                break;
            case 75:
                return 20;
                break;
            case 151:
                return 26;
                break;
            case 223:
                return 32;
                break;
        }

    }

    if ([[itemName uppercaseString] isEqualToString:[@"Jobs Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 41;
                break;
            case 14:
                
                return 49;
                break;
            case 36:
                return 57;
                break;
            case 75:
                return 65;
                break;
            case 151:
                return 73;
                break;
            case 223:
                return 81;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Jobs Xpress" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 6;
                break;
            case 14:
                
                return 12;
                break;
            case 36:
                return 18;
                break;
            case 75:
                return 24;
                break;
            case 151:
                return 30;
                break;
            case 223:
                return 36;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Mobile Xpress" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 3;
                break;
            case 14:
                
                return 9;
                break;
            case 36:
                return 15;
                break;
            case 75:
                return 21;
                break;
            case 151:
                return 27;
                break;
            case 223:
                return 33;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Pets Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 40;
                break;
            case 14:
                
                return 48;
                break;
            case 36:
                return 56;
                break;
            case 75:
                return 64;
                break;
            case 151:
                return 72;
                break;
            case 223:
                return 80;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Pets Xpress" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 5;
                break;
            case 14:
                
                return 11;
                break;
            case 36:
                return 17;
                break;
            case 75:
                return 23;
                break;
            case 151:
                return 29;
                break;
            case 223:
                return 35;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Property Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 37;
                break;
            case 14:
                
                return 45;
                break;
            case 36:
                return 53;
                break;
            case 75:
                return 61;
                break;
            case 151:
                return 69;
                break;
            case 223:
                return 77;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Sports Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 44;
                break;
            case 14:
                
                return 52;
                break;
            case 36:
                return 60;
                break;
            case 75:
                return 68;
                break;
            case 151:
                return 76;
                break;
            case 223:
                return 84;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Tech Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 38;
                break;
            case 14:
                
                return 46;
                break;
            case 36:
                return 54;
                break;
            case 75:
                return 62;
                break;
            case 151:
                return 70;
                break;
            case 223:
                return 78;
                break;
        }

    }
    
    if ([[itemName uppercaseString] isEqualToString:[@"Travel Xchange" uppercaseString]]) {
        switch (countryID) {
            case 190:
                return 43;
                break;
            case 14:
                
                return 51;
                break;
            case 36:
                return 59;
                break;
            case 75:
                return 67;
                break;
            case 151:
                return 75;
                break;
            case 223:
                return 83;
                break;
        }
    }
    
    return 1;
}

@end
