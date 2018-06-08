//
//  TYPeoplePickerController.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/11/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPeoplePickerController.h"
#import "NBPhoneNumber.h"
#import "NBPhoneNumberUtil.h"

#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>


#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>
#import "TPViewConstants.h"

@interface TYPeoplePickerController() <ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>

@end

@implementation TYPeoplePickerController

- (void)show {
    
    if (IOS9) {
        
        CNContactPickerViewController *picker = [CNContactPickerViewController new];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey,CNContactEmailAddressesKey];

        [tp_topMostViewController() presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        ABPeoplePickerNavigationController *picker = [ABPeoplePickerNavigationController new];
        picker.peoplePickerDelegate = self;
        
        picker.displayedProperties = @[@(kABPersonPhoneProperty),@(kABPersonEmailProperty)];
        picker.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        
        [tp_topMostViewController() presentViewController:picker animated:YES completion:nil];
        
    }
}

//iOS9 iOS10
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    NSLog(@"sss %@",contactProperty.contact.familyName);
    
    
    id contactPropertyValue = contactProperty.value;
    
    
    if ([contactPropertyValue isKindOfClass:[NSString class]]) {
    
        
        [self.delegate peoplePickerController:self didselectCountryModel:nil phoneNumber:contactPropertyValue];
        
        
    } else if ([contactPropertyValue isKindOfClass:[CNPhoneNumber class]])  {
        
        CNPhoneNumber *phoneNumberValue = contactProperty.value;
        
        NSString *phone = phoneNumberValue.stringValue;
        
        NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
        NSError *anError = nil;
        NBPhoneNumber *myNumber = [phoneUtil parse:phone
                                     defaultRegion:[TPUtils getISOcountryCode]
                                             error:&anError];
        if (anError) {
            NSLog(@"Error : %@", [anError localizedDescription]);
            return;
        }
        
        NSString *nationalNumber = @"";
        NSString *phoneNumber = [phoneUtil format:myNumber
                                     numberFormat:NBEPhoneNumberFormatE164
                                            error:&anError];
        NSNumber *countryCode = [phoneUtil extractCountryCode:phoneNumber nationalNumber:&nationalNumber];
        NSString *regionCode = [phoneUtil getRegionCodeForCountryCode:countryCode];
        
        
        TPCountryModel *countryCodeModel = [TPCountryService getCountryModel:regionCode];
        
        [self.delegate peoplePickerController:self didselectCountryModel:countryCodeModel phoneNumber:nationalNumber];
        
        
    }
}



#pragma mark - ABPeoplePickerNavigationControllerDelegate
//iOS8
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    
    ABMultiValueRef emailMulti = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    if (emailMulti) {
        
        
        long index = ABMultiValueGetIndexForIdentifier(emailMulti, identifier);
        if (index < 0) {
            CFRelease(emailMulti);
            return;
        }
        
        NSString *email = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(emailMulti, index));
        
        CFRelease(emailMulti);
        
        [self.delegate peoplePickerController:self didselectCountryModel:nil phoneNumber:email];
        
        return;
        
    }
    
    
    ABMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (!phoneMulti) {
        return;
    }
    
    long index = ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);
    if (index < 0) {
        CFRelease(phoneMulti);
        return;
    }
    
//    NSString *name = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName(person));
    NSString *phone = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneMulti, index));
    
    CFRelease(phoneMulti);
    
    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
    NSError *anError = nil;
    NBPhoneNumber *myNumber = [phoneUtil parse:phone
                                 defaultRegion:[TPUtils getISOcountryCode]
                                         error:&anError];
    if (anError) {
        NSLog(@"Error : %@", [anError localizedDescription]);
        return;
    }
    
    NSString *nationalNumber = @"";
    NSString *phoneNumber = [phoneUtil format:myNumber
                                 numberFormat:NBEPhoneNumberFormatE164
                                        error:&anError];
    NSNumber *countryCode = [phoneUtil extractCountryCode:phoneNumber nationalNumber:&nationalNumber];
    NSString *regionCode = [phoneUtil getRegionCodeForCountryCode:countryCode];
    
    
    TPCountryModel *countryCodeModel = [TPCountryService getCountryModel:regionCode];
    
    
    //15088667998 / 150-8866-7998 / 8615088667998 / +86 150-8866-7998
    //0571-87150683 / +86 (0)571-87150683
//    NSLog(@"name:%@ countryCode:%@ nationalNumber:%@", name, countryCode, nationalNumber);
    
    if ([self.delegate respondsToSelector:@selector(peoplePickerController:didselectCountryModel:phoneNumber:)]) {
        [self.delegate peoplePickerController:self didselectCountryModel:countryCodeModel phoneNumber:nationalNumber];
    }
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
}


@end
