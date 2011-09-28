


// Uncomment the defitions to show additional info.

#define DEBUGMODE 1
#define DEBUG_SHOWSEPARATORS    1


// Definition of DEBUG macro. 
#if DEBUGMODE 

#if DEBUG_SHOWSEPARATORS
#define debug_showSeparator() NSLog(@"----------------------------------------------------------------------------");
#else
#define debug_showSeparator()
#endif

#define ACLog(fmt, ...) NSLog((@"%s[Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);debug_showSeparator() 
#define debug_object( arg ) debug( @"Object: %@", arg );
#define debug_int( arg )    debug( @"integer: %i", arg );
#define debug_float( arg )  debug( @"float: %f", arg );
#define debug_rect( arg )   debug( @"CGRect ( %f, %f, %f, %f)", arg.origin.x, arg.origin.y, arg.size.width, arg.size.height );
#define debug_point( arg )  debug( @"CGPoint ( %f, %f )", arg.x, arg.y );
#define debug_bool( arg )   debug( @"Boolean: %@", ( arg == YES ? @"YES" : @"NO" ) );

#else

#define ACLog(fmt, ...)  
#define debug_showSeparator()     

#define debug_object( arg ) 
#define debug_int( arg ) 
#define debug_rect( arg )   
#define debug_bool( arg )   
#define debug_point( arg )
#define debug_float( arg )
 
#endif
