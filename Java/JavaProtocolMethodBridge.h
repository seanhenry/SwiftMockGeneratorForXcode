#import <Foundation/Foundation.h>
#import "JavaEnvironment.h"
struct _jobject;
typedef struct _jobject *jobject;

@interface JavaProtocolMethodBridge : NSObject

NS_ASSUME_NONNULL_BEGIN

- (instancetype)initWithJavaEnvironment:(JavaEnvironment *)environment name:(NSString *)name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) jobject javaInstance;

NS_ASSUME_NONNULL_END

@end
