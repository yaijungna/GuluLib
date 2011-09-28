//
//  GuluCreateNewPlace.m
//  GULUAPP
//
//  Created by alan on 11/9/1.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluCreateNewPlace.h"
#import "API_URL_POST.h"

@implementation GuluCreateNewPlace

@synthesize name,phonenumber,city,address,lng,lan,photoID;

- (id)initWithInfo:(NSString *)Name 
       phonenumber:(NSString *)Phonenumber
           address:(NSString *)Address
              city:(NSString *)City
               lng:(NSString *)Lng
               lan:(NSString *)Lan
               pid:(NSString *)PhotoID
{
    self = [super init];
    if (self) {
        self.name=Name;
        self.phonenumber=Phonenumber;
        self.address=Address;
        self.city=City;
        self.lan=Lan;
        self.lng=Lng;
        self.photoID=PhotoID;
        
    }
    
    return self;
}

- (void)dealloc
{
    
    [name release];
    [phonenumber release];
    [address release];
    [lng release];
    [lan release];
    [photoID release];
    [city release];
    
    [super dealloc];
}

- (void)startCreatingPlace
{
    self.request=[[[GuluGeneralHTTPClient alloc] init] autorelease];
    request.delegate=self;
   
    NSMutableDictionary *dict=[[[NSMutableDictionary alloc] init] autorelease];

    [dict setObject:name forKey:@"name"];
	[dict setObject:lan forKey:@"latitude"];
	[dict setObject:lng forKey:@"longitude"];
	[dict setObject:address forKey:@"address"];
    [dict setObject:city forKey:@"city"];
	[dict setObject:phonenumber forKey:@"phone"];
	[dict setObject:photoID forKey:@"photo_id"];
    
    [self createRequest:URL_POST_CREATE_RESTAURANT info:dict];
    [self startRequest];
}



@end
