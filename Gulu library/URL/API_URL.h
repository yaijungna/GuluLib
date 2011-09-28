
#define API_RPODUCTION 1

#if API_RPODUCTION 

#define PRODUCTION @"http://www.gulu.com/api/"
#define CHATPORT 8097
#define CHATSERVER @"gulumail.com"

#else

#define PRODUCTION @"http://demo.gd:1337/api/"
#define CHATPORT 8097
#define CHATSERVER @"dev.gulumail.com"

#endif
