//
//  DSUtility.m
//  DocuStrator
//
//  Created by Jairam Babu on 6/11/14.
//  Copyright (c) 2014 JairamBabu. All rights reserved.
//
//

#pragma NSLog(...)

#import "LGTUtility.h"

@implementation LGTUtility
#pragma mark- Device and IOS
+ (NSString *)uNibName:(NSString*)name {
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ///For iPad
    {
        return [name stringByAppendingString:@"_iPad"];
    }
    else ///For iPhone
    {
        return [name stringByAppendingString:@"_iPhone"];
    }
}

+(BOOL)isIosVersion6{
    float currentVersion = 6.1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= currentVersion)
    {
        
        return YES;
        
    }
    else{
        
        return NO;
        
    }
    return NO;
}

+ (BOOL)uIsiPad {
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) { ///For iPad
        return TRUE;
    }
    
    return FALSE;
}

+ (BOOL)uIsiPhone5 { ///Check for iPhone 5/5s screen
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if(result.height == 568) { ///iPhone 5
        return TRUE;
    }
    
    return FALSE;
}
//get the Date and Time
+(NSString*)getTheTimeAndDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Mon, 11 Jul 2011 00:00:00 +0200
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
    [dateFormatter setDateFormat:@"dd/MM/YYYY hh:mm:ss a"];
    
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    
    return strDate;
    
}
//get the time
+(NSString*)getTheTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSString *strTime = [dateFormatter stringFromDate:[NSDate date]];
    return strTime;
    
}
//get the Date
+(NSString*)getTheDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
    [dateFormatter setDateFormat:@"MM/dd/YYYY"];
    
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
    
}

+(void)roundedView:(UIView*)views{
    
    views.layer.cornerRadius=3.0;
    views.layer.borderWidth = 1;
    views.layer.borderColor=[[UIColor clearColor] CGColor];
    
}
+(void)drawShadow:(UIView*)views{
    
    views.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    views.layer.shadowOpacity=6.0;
    views.layer.shadowRadius=8.0;
    views.layer.cornerRadius=1.0;
    views.layer.borderWidth = 1;
    views.layer.borderColor=[[UIColor clearColor] CGColor];
    
}
+(UIColor*)blueColorForNotificationTitle{
    
    return [UIColor colorWithRed:94.0/255.0 green:135.0/255.0 blue:176.0/255.0 alpha:1.0];
    
}

+(UIColor*)blueColorUsingThisApp{
    
    return [UIColor colorWithRed:94.0/255.0 green:135.0/255.0 blue:176.0/255.0 alpha:0.8];
    
}

+(UIColor*)orangeColorUsingThisApp{
    
    return [UIColor colorWithRed:255.0/255.0 green:159.0/255.0 blue:0.0/255.0 alpha:0.8];
    
}
+(void)boaderWithBlue:(UIView*)views{
    
    views.layer.cornerRadius=5.0;
    views.layer.borderWidth = 1;
    views.layer.borderColor=[UIColor colorWithRed:94.0/255.0 green:135.0/255.0 blue:176.0/255.0 alpha:1.0].CGColor;
    [views clipsToBounds];
}
+(void)drawShadowForInfo:(UIView*)views{
    
    //views.layer.backgroundColor=[UIColor clearColor].CGColor;
    views.layer.shadowColor=[UIColor colorWithRed:94.0/255.0 green:135.0/255.0 blue:176.0/255.0 alpha:1.0].CGColor;
    
    views.layer.shadowOpacity=1.0;
    views.layer.shadowRadius=2.0;
    views.layer.cornerRadius=1.0;
    views.layer.borderWidth = 1;
    views.layer.borderColor=[UIColor colorWithRed:94.0/255.0 green:135.0/255.0 blue:176.0/255.0 alpha:1.0].CGColor;
}

+(void)drawShadowForStartDepositionButton:(UIView*)views{
    
    //views.layer.cornerRadius=1.0;
    // views.layer.borderWidth = 1;
    //views.layer.borderColor=[UIColor colorWithRed:94.0/255.0 green:135.0/255.0 blue:176.0/255.0 alpha:1.0].CGColor;
    [self viewShadow:views :[LGTUtility blueColorUsingThisApp]];
}
+(NSString*)cacheDirectory:(NSString*)strName{
    
    NSString *strPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *strFilePath=[strPath stringByAppendingPathComponent:strName];
    
    return strFilePath;
}
+(NSString*)documentDirectory:(NSString*)strName{
    
    NSString *strPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *strFilePath=[strPath stringByAppendingPathComponent:strName];
    
    return strFilePath;
}

+(void)removeItemFromDocumentFolder_NameOfFileOnly:(NSString *)fileNamePath
{
    
    NSError *error;
    if([[NSFileManager defaultManager]fileExistsAtPath:[self documentDirectory:fileNamePath]])
    {
        //[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", [self cacheDirectory], filename] error:nil];
        
        [[NSFileManager defaultManager] removeItemAtPath:[self documentDirectory:fileNamePath] error:&error];
        
    }
    
    
}
//compare image
+ (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2
{
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    
    return [data1 isEqual:data2];
}

+(void)exhibitStriker:(UIView*)subView superClassFrmae:(UIView*)superview{
    
    
    float maxX_Position=superview.frame.size.width-subView.frame.size.width-5;///maximum x to move
    float maxY_Position=superview.frame.size.height-subView.frame.size.height-5;///maximum y to move
    if(subView.frame.origin.x<5)
    {
        
        subView.frame=CGRectMake(5,subView.frame.origin.y,subView.frame.size.width,subView.frame.size.height);
        
    }
    if(subView.frame.origin.x>maxX_Position)
    {
        
        subView.frame=CGRectMake(maxX_Position,subView.frame.origin.y,subView.frame.size.width,subView.frame.size.height);
        
    }
    if(subView.frame.origin.y<5){
        
        subView.frame=CGRectMake(subView.frame.origin.x,5,subView.frame.size.width,subView.frame.size.height);
    }
    if(subView.frame.origin.y>maxY_Position){
        
        subView.frame=CGRectMake(subView.frame.origin.x,maxY_Position,subView.frame.size.width,subView.frame.size.height);
    }
    subView.frame=CGRectMake(subView.frame.origin.x,subView.frame.origin.y,subView.frame.size.width, subView.frame.size.height);
    subView.frame=CGRectMake(subView.frame.origin.x,subView.frame.origin.y,subView.frame.size.width,subView.frame.size.height);
    
    
}

+(void)viewShadow:(UIView*)viewHighlight :(UIColor*)glowingColor
{
    
    viewHighlight.clipsToBounds = YES;
    viewHighlight.backgroundColor = [UIColor whiteColor];
    // UIColor  *glowingColor = glowingColor;
    viewHighlight.layer.masksToBounds = NO;
    viewHighlight.layer.cornerRadius = 1.0f;
    viewHighlight.layer.borderWidth = 1.0f;
    viewHighlight.layer.borderColor =[UIColor whiteColor].CGColor;
    
    viewHighlight.layer.shadowColor =glowingColor.CGColor;
    viewHighlight.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:viewHighlight.bounds cornerRadius:4.f].CGPath;
    viewHighlight.layer.shadowOpacity = 0;
    viewHighlight.layer.shadowOffset = CGSizeZero;
    viewHighlight.layer.shadowRadius = 5.f;
    viewHighlight.layer.shouldRasterize = YES;
    viewHighlight.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self showGlowingForButton:viewHighlight];
}
+(void)showGlowingForButton:(UIView*)viewHighlight
{
    [self animateBorderColorFrom:(id)viewHighlight.layer.borderColor to:(id)viewHighlight.layer.shadowColor shadowOpacityFrom:(id)[NSNumber numberWithFloat:0.f] to:(id)[NSNumber numberWithFloat:1.f] :viewHighlight];
}
+(void)hideGlowingForButton:(UIView*)viewHideHighlight
{
    
    [self animateBorderColorFrom:(id)viewHideHighlight.layer.borderColor to:[UIColor clearColor] shadowOpacityFrom:(id)[NSNumber numberWithFloat:1.f] to:(id)[NSNumber numberWithFloat:0.f] :viewHideHighlight];
    
    
}


//set textfield
+(void)textFieldShadow:(UITextField*)txtfield
{
    txtfield.borderStyle = UITextBorderStyleNone;
    txtfield.clipsToBounds = YES;
    
    txtfield.backgroundColor = [UIColor whiteColor];
    
    
    
    [self showGlowing:txtfield];
}
+(void)hideGlowing:(UITextField*)txtfield
{
    txtfield.layer.borderColor=[UIColor clearColor].CGColor;
    txtfield.layer.borderWidth=0.0;
    
}
+(void)showGlowing:(UITextField*)txtfield
{
    txtfield.layer.borderColor=[self blueColorForNotificationTitle].CGColor;
    txtfield.layer.borderWidth=1.0;
    
}
+ (void)animateBorderColorFrom:(id)fromColor to:(id)toColor shadowOpacityFrom:(id)fromOpacity to:(id)toOpacity :(UIView*)viewHighlight
{
    CABasicAnimation *borderColorAnimation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderColorAnimation.fromValue = fromColor;
    borderColorAnimation.toValue = toColor;
    
    CABasicAnimation *shadowOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    shadowOpacityAnimation.fromValue = fromOpacity;
    shadowOpacityAnimation.toValue = toOpacity;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.0f / 3.0f;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = @[borderColorAnimation, shadowOpacityAnimation];
    [viewHighlight.layer addAnimation:group forKey:nil];
    
}
+(void)textFieldRectError:(UITextField*)textField isColor:(BOOL)isColor{
    
    if(isColor==YES)
    {
        textField.layer.borderColor=[UIColor redColor].CGColor;
        textField.layer.borderWidth=1.0;
        textField.returnKeyType=UIReturnKeyDefault;
        textField.keyboardType=UIKeyboardTypeDefault;
        
    }else{
        
        textField.layer.borderColor=[UIColor clearColor].CGColor;
        textField.layer.borderWidth=0.0;
        
    }
}






@end
