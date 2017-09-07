#import <Foundation/Foundation.h>
#import "JavaEnvironment.h"
struct _jobject;
typedef struct _jobject *jobject;

@interface JavaProtocolPropertyBridge : NSObject

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithJavaEnvironment:(JavaEnvironment *)environment
                                   name:(NSString *)name
                                   type:(NSString *)type
                             isWritable:(BOOL)isWritable
                              signature:(NSString *)signature;
@property (nonatomic, readonly) jobject javaInstance;

NS_ASSUME_NONNULL_END

@end
