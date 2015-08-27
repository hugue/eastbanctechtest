//
//  Country.h
//  TestTableView
//
//  Created by hugues on 20/08/15.
//  Copyright (c) 2015 hugues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Country : NSManagedObject

@property (nonatomic, retain) NSMutableString * name;
@property (nonatomic, retain) NSMutableString * pathToImage;
@property (nonatomic, retain) NSMutableString * currency;
@property (nonatomic)         NSInteger displayOrder;
@property (nonatomic, retain) NSNumber * currencyValue;

- (id) initWithName: (NSString *)name andImage: (NSString *) pathToImage andCurrency : (NSString *) currency;

@end
