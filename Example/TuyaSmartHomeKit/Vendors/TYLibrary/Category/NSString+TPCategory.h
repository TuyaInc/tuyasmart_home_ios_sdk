//
//  NSString+TPCategory.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/16.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TPCategory)


- (NSDictionary*)tp_tbQueryContentsUsingEncoding:(NSStringEncoding)encoding;

/**
 * Determines if the string contains only whitespace and newlines.
 */
- (BOOL)tp_isWhitespaceAndNewlines;


/**
 * Parses a URL query string into a dictionary where the values are arrays.
 */
- (NSDictionary*)tp_queryContentsUsingEncoding:(NSStringEncoding)encoding;

/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)tp_stringByAddingQueryDictionary:(NSDictionary*)query;

/**
 * Parses a URL, adds urlEncoded query parameters to its query, and re-encodes it as a new URL.
 *
 * This method encodes keys and values of query using [NSString urlEncoded] and calls
 * stringByAddingQueryDictionary with the resulting dictionary.
 *
 * @throw NSInvalidArgumentException If any value or key does not respond to urlEncoded.
 */
- (NSString*)tp_stringByAddingURLEncodedQueryDictionary:(NSDictionary*)query;

/**
 * Returns a URL Encoded String
 */
- (NSString*)tp_urlEncoded;

/**
 * Returns a URL Dncoded String
 */
- (NSString *)tp_urlDecoded;

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 */
- (NSComparisonResult)tp_versionStringCompare:(NSString *)other;

- (NSString *)tp_trim;


/**
   十六进制字符串转换成NSData
 */
- (NSData *)tp_dataFromHexString;




@end
