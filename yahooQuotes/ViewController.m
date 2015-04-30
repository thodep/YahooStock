//
//  ViewController.m
//  yahooQuotes
//
//  Created by tho dang on 2015-04-27.
//  Copyright (c) 2015 TD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
   
    //Create text field
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(20, 60, 280, 20)];
    self.textField.text=@"AAPL";
    //disable auto correction
    self.textField.autocorrectionType =UITextAutocorrectionTypeNo;
    self.textField.returnKeyType = UIReturnKeyDone;
    
    self.textField.delegate=self;
    [self.view addSubview:_textField];
    
    //create my Label
    self.myLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 40)];
    self.myLabel.text=@"$0.0";
    [self.view addSubview:_myLabel];
    
    //create the Button
    UIButton *myButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame=CGRectMake(20, 200, 280, 40);
    [myButton setTitle:@"Get Quotes" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(getQuotes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self getQuotes];
    return NO;
    
}

-(void)getQuotes {
    //create an address for the stock quote API
    NSString *quoteAddress=[NSString stringWithFormat:@"http://download.finance.yahoo.com/d/quotes.csv?s=%@&f=sl1d1t1c1ohgv&e=.csv", _textField.text];
    //Create a URL
    NSURL *theURL=[[NSURL alloc]initWithString:[quoteAddress stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    //Send intial Request to the server
    NSURLRequest *theRequest =[[NSURLRequest alloc]initWithURL:theURL];
    NSURLResponse *response =nil;
    NSError *error= nil;
    //send a request to the server and return information
    NSData *data=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    //store the data returned from NSData and Encode it using UTF8
    NSMutableString *contentString=[[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //Store contents of the string into an array using a comma to seperate each value
    NSArray *arrayData =[contentString componentsSeparatedByString:@","];
    
    float current =[[arrayData objectAtIndex:1]floatValue];
    float open =[[arrayData objectAtIndex:5]floatValue];
    if (current<= open) {
        _myLabel.textColor =[UIColor greenColor];
    }else{
        _myLabel.textColor=[UIColor redColor];
        _myLabel.text=[arrayData objectAtIndex:5];
    }
    
    _myLabel.text=[arrayData objectAtIndex:1];
    //NSLog(@"%@",contentString);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
