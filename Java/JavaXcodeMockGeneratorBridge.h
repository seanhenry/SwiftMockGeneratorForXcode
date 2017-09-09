#import <Foundation/Foundation.h>
#import "JavaEnvironment.h"
@class JavaProtocolMethodBridge;
@class JavaProtocolPropertyBridge;

@interface JavaXcodeMockGeneratorBridge : NSObject

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithJavaEnvironment:(JavaEnvironment *)environment;
- (void)addProtocolMethod:(JavaProtocolMethodBridge *)method;
- (void)addProtocolProperty:(JavaProtocolPropertyBridge *)prop;
- (NSString *)generate;

NS_ASSUME_NONNULL_END

@end
