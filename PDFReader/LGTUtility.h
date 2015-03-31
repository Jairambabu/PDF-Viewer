//
//  DSUtility.h
//  DocuStrator
//
//  Created by Ravichandran Venkatraman on 26/05/14.
//  Copyright (c) 2014 ConnexInfoSystem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LGTUtility : NSObject

+ (NSString *)uNibName:(NSString*)name;
+ (BOOL)uIsiPhone5;
+ (BOOL)uIsiPad;
+ (NSString*)getTheTimeAndDate;
+ (void)drawShadow:(UIView*)views;
+ (void)drawShadowForInfo:(UIView*)views;
+ (void)drawShadowForStartDepositionButton:(UIView*)views;
+ (NSString*)cacheDirectory:(NSString*)strName;
+ (NSString*)documentDirectory:(NSString*)strName;
+ (BOOL)isIosVersion6;
+ (void)depostionNotStartedErrorMessage;
+ (void)didSelectedDocument;
+ (void)showDocumentMessage;
+ (void)removeItemFromDocumentFolder_NameOfFileOnly:(NSString *)fileNamePath;
+ (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2;

+ (void)exhibitStriker:(UIView*)subView superClassFrmae:(UIView*)superview;
+ (void)textFieldShadow:(UITextField*)txtfield;
+ (void)hideGlowing:(UITextField*)txtfield;
+ (void)viewShadow:(UIView*)viewHighlight :(UIColor*)glowingColor;
+ (void)hideGlowingForButton:(UIButton*)button;
+ (void)drawShadowForExhibitStrikerButton:(UIView*)viewHighlight;

//invite Participant
+ (void)boaderWithBlue:(UIView*)views;
+ (void)roundedView:(UIView*)views;

//IP
+ (void)textFieldRectError:(UITextField*)textField isColor:(BOOL)isColor;
+ (void)textFieldRect:(UITextField*)textField isColor:(BOOL)isColor;

//Get Time
+ (NSString*)getTheTime;
//Get Date
+ (NSString*)getTheDate;
//invite participant Error code
+ (NSString*)inviteParticipantErrorCode:(NSString*)strCode;

//search OCR Document
+ (NSArray*)searchOCRarray:(NSArray*)arrOCRSearchList :(NSArray*)arrDocumentList;


@end
