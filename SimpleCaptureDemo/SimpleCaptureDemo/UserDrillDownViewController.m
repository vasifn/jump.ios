/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2010, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation and/or
   other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#import "UserDrillDownViewController.h"
#import "JRCapture.h"

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface NSDictionary (OrderedKeys)
- (NSArray*)allKeysOrdered;
@end

@implementation NSDictionary (OrderedKeys)
- (NSArray*)allKeysOrdered
{
    NSArray *allKeys = [self allKeys];
    return [allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}
@end

typedef enum propertyTypes
{
    PTString,
    PTDate,
    PTBool,
    PTNumber,
    PTInteger,
    PTObject,
} PropertyType;

@interface EntityData : NSObject
@property (strong) UITextField *textField;
@property (strong) UILabel     *label;
@property          PropertyType propertyType;
@property (strong) NSString    *propertyValue;
@property          BOOL         canEdit;
@property          BOOL         wasChanged;
@end

@implementation EntityData
@synthesize textField;
@synthesize propertyType;
@synthesize propertyValue;
@synthesize wasChanged;
@synthesize canEdit;
@synthesize label;

@end

@implementation UserDrillDownViewController
@synthesize tableViewHeader;
@synthesize tableViewData;
@synthesize myTableView;
@synthesize captureData;
@synthesize myUpdateButton;


- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
        andDataObject:(NSObject*)object forKey:(NSString*)key
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
//        self.tableViewData   = object;
//        self.tableViewHeader = key;

        self.captureData = object;

        if ([object isKindOfClass:[NSArray class]])
            self.tableViewData = object;
        else if ([object respondsToSelector:@selector(dictionaryFromObject)])
            self.tableViewData = [(id<JRJsonifying>)object dictionaryFromObject];
        else
            self.tableViewData = nil;

        self.tableViewHeader = key;//NSStringFromClass([object class]);
        propertyArray = [NSMutableArray arrayWithCapacity:10];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                     target:self
                                                     action:@selector(editButtonPressed:)];

    self.navigationItem.rightBarButtonItem         = editButton;
    self.navigationItem.rightBarButtonItem.enabled = YES;

    self.navigationItem.rightBarButtonItem.style   = UIBarButtonItemStyleBordered;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)editButtonPressed:(id)sender
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                     target:self
                                                     action:@selector(doneButtonPressed:)];

    self.navigationItem.rightBarButtonItem         = doneButton;
    self.navigationItem.rightBarButtonItem.enabled = YES;

    self.navigationItem.rightBarButtonItem.style   = UIBarButtonItemStyleBordered;

    for (EntityData *data in propertyArray)
    {
        if (data.canEdit)
        {
            data.textField.hidden      = NO;
            data.label.hidden          = YES;
            data.textField.placeholder = data.label.text;
        }
    }

    //myUpdateButton.enabled = NO;
    isEditing = YES;
    [myTableView reloadData];
}

- (void)doneButtonPressed:(id)sender
{
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                     target:self
                                                     action:@selector(editButtonPressed:)];

    self.navigationItem.rightBarButtonItem         = editButton;
    self.navigationItem.rightBarButtonItem.enabled = YES;

    self.navigationItem.rightBarButtonItem.style   = UIBarButtonItemStyleBordered;

    for (EntityData *data in propertyArray)
    {
        if (data.canEdit)
        {
            data.textField.hidden      = YES;
            data.label.hidden          = NO;
            if (data.textField.text && ![data.textField.text isEqualToString:@""])
                data.label.text = data.textField.placeholder;
        }
    }

    //myUpdateButton.enabled = NO;
    isEditing = NO;

    [firstResponder resignFirstResponder], firstResponder = nil;
    [myTableView reloadData];
}

- (IBAction)updateButtonPressed:(id)sender
{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    firstResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return tableViewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableViewHeader)
        return 30.0;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (isEditing)
        return 260;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableViewData isKindOfClass:[NSArray class]])
        return [((NSArray*)tableViewData) count];
    else if ([tableViewData isKindOfClass:[NSDictionary class]])
        return [[((NSDictionary*)tableViewData) allKeysOrdered] count];
    else
        return 0;
}

#define HIGHER_SUBTITLE 10
#define NORMAL_SUBTITLE 21
#define UP_A_LITTLE_HIGHER(r) CGRectMake(r.frame.origin.x, HIGHER_SUBTITLE, r.frame.size.width, r.frame.size.height)
#define WHERE_IT_SHOULD_BE(r) CGRectMake(r.frame.origin.x, NORMAL_SUBTITLE, r.frame.size.width, r.frame.size.height)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger keyLabelTag   = 1;
    static NSInteger valueLabelTag = 2;
    static NSInteger textFieldTag  = 3;

    UITableViewCellStyle style = UITableViewCellStyleDefault;
    NSString *reuseIdentifier  = [NSString stringWithFormat:@"cachedCell_%d", indexPath.row];

    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];

        CGRect frame;
        frame.origin.x    = 10;
        frame.origin.y    = 5;
        frame.size.height = 18;
        frame.size.width  = (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) ? 280 : 440;;

        UILabel *keyLabel = [[UILabel alloc] initWithFrame:frame];
        keyLabel.tag      = keyLabelTag;

        keyLabel.backgroundColor = [UIColor clearColor];
        keyLabel.font            = [UIFont systemFontOfSize:13.0];
        keyLabel.textColor       = [UIColor grayColor];
        keyLabel.textAlignment   = UITextAlignmentLeft;

        [keyLabel setAutoresizingMask:UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth];

        [cell.contentView addSubview:keyLabel];

        frame.origin.y     += 16;
        frame.size.height  += 8;
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:frame];
        valueLabel.tag      = valueLabelTag;

        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.font            = [UIFont boldSystemFontOfSize:16.0];
        valueLabel.textColor       = [UIColor blackColor];
        valueLabel.textAlignment   = UITextAlignmentLeft;

        [valueLabel setAutoresizingMask:UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth];

        [cell.contentView addSubview:valueLabel];

        frame.origin.y     += 2;
        frame.size.height  -= 4;

        UITextField *textField = [[UITextField alloc] initWithFrame:frame];
        textField.tag          = textFieldTag;

        textField.backgroundColor = [UIColor clearColor];
        textField.font            = [UIFont systemFontOfSize:14.0];
        textField.textColor       = [UIColor blackColor];
        textField.textAlignment   = UITextAlignmentLeft;
        textField.hidden          = YES;
        textField.borderStyle     = UITextBorderStyleLine;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.delegate        = self;

        [textField setAutoresizingMask:UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth];

        [cell.contentView addSubview:textField];

        EntityData *data = [[EntityData alloc] init];
        [propertyArray insertObject:data atIndex:(NSUInteger)indexPath.row];
    }

    EntityData *data = [propertyArray objectAtIndex:(NSUInteger)indexPath.row];

    UILabel *titleLabel    = (UILabel*)[cell.contentView viewWithTag:keyLabelTag];
    UILabel *subtitleLabel = (UILabel*)[cell.contentView viewWithTag:valueLabelTag];
    UITextField *textField = (UITextField*)[cell.contentView viewWithTag:textFieldTag];

    NSString* subtitle  = nil;
    NSString* cellTitle = nil;

    cell.textLabel.text       = nil;
    cell.detailTextLabel.text = nil;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType  = UITableViewCellAccessoryNone;

    NSString *key;
    NSObject *value = nil;

 /* If our data is an array, */
    if ([tableViewData isKindOfClass:[NSArray class]])
    {
     /* get the current item in our array */
        value = [((NSArray *)tableViewData) objectAtIndex:(NSUInteger)indexPath.row];

        if ([value respondsToSelector:@selector(dictionaryFromObject)])
            value = [(id<JRJsonifying>)value dictionaryFromObject];
    }
 /* If our data is a dictionary, */
    else if ([tableViewData isKindOfClass:[NSDictionary class]])
    {
     /* get the current key and item for that key */
        key   = [[((NSDictionary *)tableViewData) allKeysOrdered] objectAtIndex:(NSUInteger)indexPath.row];
        value = [((NSDictionary *)tableViewData) objectForKey:key];

        if ([value respondsToSelector:@selector(dictionaryFromObject)])
            value = [(id<JRJsonifying>)value dictionaryFromObject];

     /* and set the cell title as the key */
        cellTitle = key;
    }
    else { /* Shouldn't happen */ }

 /* If our item is an array or dictionary... */
    if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]])
    {
     /* If our array or dictionary has 1 or more items, add the accessory view and set the subtitle. */
        if ([((NSArray*)value) count])
        {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setSelectionStyle: UITableViewCellSelectionStyleBlue];

         /* Lets not say, "1 items".  That's just silly. */
            if ([((NSArray*)value) count] == 1)
                subtitle = @"1 item";
            else
                subtitle = [NSString stringWithFormat:@"%d items", [((NSDictionary*)value) count]];
        }
     /* And, if it's empty, let's indicate that as well. */
        else
        {/* cellTitle will be null if our data is an array, but why have an array of empty arrays? */
            subtitle = cellTitle ? [NSString stringWithFormat:@"No known %@", cellTitle] : @"[none]";
        }

        data.propertyType = PTObject;
        data.canEdit      = NO;
    }
 /* If our item is a string, */
    else if ([value isKindOfClass:[NSString class]])
    {/* set the subtitle as our value, or, if empty, say so. */
        if ([((NSString*)value) length])
            subtitle = (NSString*)value;
        else
            subtitle = [NSString stringWithFormat:@"No known %@", cellTitle];

        data.propertyType = PTString;
        data.canEdit      = YES;
        data.propertyValue    = subtitle;
        textField.placeholder = subtitle;
    }
 /* If our item is a number, */
    else if ([value isKindOfClass:[NSNumber class]])
    {/* make it a string, and set the subtitle as that. */
        subtitle = [((NSNumber *)value) stringValue];

        data.propertyType     = PTNumber;
        data.canEdit          = YES;
        data.propertyValue    = subtitle;
        textField.placeholder = subtitle;
    }
    else { /* I dunno... Just hopin' it won't happen... */ }

    if (textField.text && ![textField.text isEqualToString:@""])
        subtitleLabel.text = textField.text;
    else
        subtitleLabel.text = subtitle;

    titleLabel.text    = cellTitle;

    data.textField = textField;
    data.label     = subtitleLabel;

    if (!cellTitle)
        subtitleLabel.frame = UP_A_LITTLE_HIGHER(subtitleLabel);
    else
        subtitleLabel.frame = WHERE_IT_SHOULD_BE(subtitleLabel);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSString *key        = nil;
    NSObject *value      = nil;
    NSObject *captureObj = nil;

 /* Get the key, if there is one, and the value. */
    if ([tableViewData isKindOfClass:[NSArray class]])
    {
        value      = [((NSArray *)tableViewData) objectAtIndex:(NSUInteger)indexPath.row];
        captureObj = [((NSArray *)tableViewData) objectAtIndex:(NSUInteger)indexPath.row];
    }
    else if ([tableViewData isKindOfClass:[NSDictionary class]])
    {
        key        = [[((NSDictionary *)tableViewData) allKeysOrdered] objectAtIndex:(NSUInteger)indexPath.row];
        value      = [((NSDictionary *)tableViewData) objectForKey:key];
        captureObj = [captureData performSelector:NSSelectorFromString(key)];
    }

    if ([value respondsToSelector:@selector(dictionaryFromObject)])
        value = [(id<JRJsonifying>)value dictionaryFromObject];

 /* If our value isn't an array or dictionary, don't drill down. */
    if (![value isKindOfClass:[NSArray class]] && ![value isKindOfClass:[NSDictionary class]])
        return;

 /* If our value is an *empty* array or dictionary, don't drill down. */
    if (![(NSArray *)value count]) /* Since we know value is either an array or dictionary, and both classes respond */
        return;                    /* to the 'count' selector, we just cast as an array to avoid IDE complaints */

    UserDrillDownViewController *drillDown =
                                        [[UserDrillDownViewController alloc] initWithNibName:@"UserDrillDownViewController"
                                                                                       bundle:[NSBundle mainBundle]
                                                                                andDataObject:captureObj
                                                                                       forKey:key];

    [[self navigationController] pushViewController:drillDown animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    tableViewHeader, tableViewHeader = nil;
    tableViewData, tableViewData = nil;
}
@end
