//
//  GuluBasicModel.m
//  GULUAPP
//
//  Created by alan on 11/9/19.
//  Copyright 2011年 gulu.com. All rights reserved.
//

#import "GuluBasicModel.h"

@implementation GuluBasicModel

@synthesize propsAndAttsDict;

- (id)init
{
    self = [super init];
    if (self) {
        [self propertiesAndAttributesList];
    }
    
    return self;
}

- (void)dealloc
{
    [propsAndAttsDict release];
    [super dealloc];
    
}

#pragma mark -


-(void)propertiesAndAttributesList
{
    self.propsAndAttsDict=[[[NSMutableDictionary alloc] init] autorelease];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) 
    {
        objc_property_t oneProp = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(oneProp)];
        NSString *attrs = [NSString stringWithUTF8String: property_getAttributes(oneProp)];
        
        // Read only attributes are assumed to be derived or calculated
		// See http://developer.apple.com/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/chapter_8_section_3.html
        if ([attrs rangeOfString:@",R,"].location == NSNotFound)
        {
            NSArray *attrParts = [attrs componentsSeparatedByString:@","];
            if (attrParts != nil)
            {
                if ([attrParts count] > 0)
                {
                    NSString *propType = [[attrParts objectAtIndex:0] substringFromIndex:1] ;
                    propType = [propType stringByReplacingOccurrencesOfString:@"\""withString:@""];
                    propType = [propType stringByReplacingOccurrencesOfString:@"@"withString:@""];
                    [propsAndAttsDict setObject:propType forKey:propName];
                }
            }
        }
        
    }
    
    free(properties);
}

-(void)switchDataIntoModel:(NSDictionary *)dataDictionary
{
    if([dataDictionary isKindOfClass:[NSDictionary class]])
    {
        for(NSString *propName in propsAndAttsDict)
        {
            NSString *propType=[propsAndAttsDict objectForKey:propName];
            
            Class propClass = NSClassFromString(propType);
            id data= [dataDictionary objectForKey:propName];
            
            if([data isEqual:[NSNull null]]){
                data=nil;}
            
            if ([propClass isKindOfClass:[NSString class]] && data==nil) {
                data=@"";
            }
            
            if(data)
            {
                if([propClass isSubclassOfClass:[GuluBasicModel class]])
                {
                    id valueObjectOfProp=[[[propClass alloc] init] autorelease];
                    [(GuluBasicModel *)valueObjectOfProp switchDataIntoModel:data];
                    [self setValue:valueObjectOfProp forKey:propName];
                }
                else
                {
                    [self setValue:data forKey:propName];
                }
            }
        }
    }
}


-(void)showMyInfo:(BOOL)showMemberObject
{
    NSArray *propertiesListArray=[propsAndAttsDict allKeys];
    
    NSString *className = [[self class] description];
    
    NSLog(@"    ***** [%@] HEAD*****",className);
    
    for(NSString *propName in propertiesListArray)
    {
        if([propName isEqualToString:@"propertiesListArray"]){
            continue;}
        
        id temp=[self valueForKey:propName];
        
        if([[temp superclass] isSubclassOfClass:[GuluBasicModel class]] && showMemberObject)
        {
            [temp showMyInfo:showMemberObject];
        }
        else
        {
            if([temp isKindOfClass:[NSDictionary class]] && !showMemberObject)
            {
                NSLog(@"        %@ = <NSDictionary>",propName);
            }
            else if([temp isKindOfClass:[NSArray class]] && !showMemberObject)
            {
                NSLog(@"        %@ = <NSArray>",propName);
            }
            else
            {
                NSLog(@"        %@ = %@",propName,temp);
            }
        }
    }
    
    NSLog(@"    ***** [%@] END*****",className);
}


@end
