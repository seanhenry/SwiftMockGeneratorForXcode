#import "JavaProtocolMethodBridge.h"
#import "jni.h"
#import "JavaEnvironment.h"

@implementation JavaProtocolMethodBridge {
    JNIEnv *env;
    jclass protocolMethodClass;
    jobject instance;
}

- (instancetype)initWithJavaEnvironment:(JavaEnvironment *)environment name:(NSString *)name {
    self = [super init];
    if (self != nil) {
        env = environment.env;
        protocolMethodClass = (*env)->FindClass(env, "codes/seanhenry/mockgenerator/entities/ProtocolMethod");
        jmethodID constructor = (*env)->GetMethodID(env, protocolMethodClass, NULL, "(Ljava/lang/String;)V");
        instance = (*env)->NewObject(env, protocolMethodClass, constructor, (*env)->NewStringUTF(env, name.UTF8String));
    }
    return self;
}

- (jobject)javaInstance {
    return instance;
}

@end
