#import <Foundation/Foundation.h>
#import "JavaEnvironment.h"
@class JavaProtocolMethodBridge;

@interface JavaXcodeMockGeneratorBridge : NSObject

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithJavaEnvironment:(JavaEnvironment *)environment;
- (void)addProtocolMethod:(JavaProtocolMethodBridge *)method;
- (NSString *)generate;

NS_ASSUME_NONNULL_END

@end
