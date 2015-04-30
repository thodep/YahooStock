//
//  ViewController.h
//  yahooQuotes
//
//  Created by tho dang on 2015-04-27.
//  Copyright (c) 2015 TD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
// UITextField
@property(strong,nonatomic) UITextField *textField;
//String

@property(strong,nonatomic)NSString *quotes;

//UILabel
@property(strong,nonatomic)UILabel *myLabel;

//quote method
-(void)getQuotes;

@end

