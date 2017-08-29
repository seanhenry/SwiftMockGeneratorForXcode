#import "JavaEnvironment.h"
#import "jni.h"

@implementation JavaEnvironment {
    JavaVM* jvm;
    JNIEnv* env;
    JavaVMInitArgs args;
    JavaVMOption options[1];
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        NSString *classpath = [[NSBundle bundleForClass:[self class]] pathForResource:@"MockGeneratorUseCases" ofType:@"jar"];
        classpath = [@"-Djava.class.path=" stringByAppendingString:classpath];
        args.version = JNI_VERSION_1_8;
        args.nOptions = 1;
        options[0].optionString = (char *)classpath.UTF8String;
        args.options = options;
        args.ignoreUnrecognized = JNI_TRUE;
        JNI_CreateJavaVM(&jvm, (void **)&env, &args);
    }
    return self;
}

- (JNIEnv *)env {
    return env;
}

- (void)dealloc {
    (*jvm)->DestroyJavaVM(jvm);
}

@end
