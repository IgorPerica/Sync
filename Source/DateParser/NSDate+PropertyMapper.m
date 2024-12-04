#import "NSDate+PropertyMapper.h"

@implementation NSDate (PropertyMapper)

+ (NSDate *)dateFromDateString:(NSString *)dateString {
    NSDate *parsedDate = nil;

    DateType dateType = [dateString dateType];
    switch (dateType) {
        case iso8601: {
            parsedDate = [self dateFromISO8601String:dateString];
        } break;
        case unixTimestamp: {
            parsedDate = [self dateFromUnixTimestampString:dateString];
        } break;
        default: break;
    }

    return parsedDate;
}

+ (NSDate *)dateFromISO8601String:(NSString *)dateString {
    if (!dateString || [dateString isEqual:[NSNull null]]) {
        return nil;
    }

    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    formatter.formatOptions = NSISO8601DateFormatWithInternetDateTime | NSISO8601DateFormatWithFractionalSeconds;
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateFromUnixTimestampNumber:(NSNumber *)unixTimestamp {
    return [self dateFromUnixTimestampString:[unixTimestamp stringValue]];
}

+ (NSDate *)dateFromUnixTimestampString:(NSString *)unixTimestamp {
    NSString *parsedString = unixTimestamp;

    NSString *validUnixTimestamp = @"1441843200";
    NSInteger validLength = [validUnixTimestamp length];
    if ([unixTimestamp length] > validLength) {
        parsedString = [unixTimestamp substringToIndex:validLength];
    }

    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *unixTimestampNumber = [numberFormatter numberFromString:parsedString];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:unixTimestampNumber.doubleValue];

    return date;
}

@end

@implementation NSString (Parser)

- (DateType)dateType {
    if ([self containsString:@"-"]) {
        return iso8601;
    } else {
        return unixTimestamp;
    }
}

@end
