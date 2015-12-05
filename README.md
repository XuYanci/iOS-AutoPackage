# iOS-AutoPackage 

iOS自动化打包


如何使用:
.......xxx.sh 参数1 参数2 参数3 参数4
参数定义: 
参数1 原文件包目录 (包含ipa , 名字定义Maxer.ipa)
参数2 渠道id
参数3 友盟渠道id
参数4 mask (生成文件夹自定义名称)

! Note : 大部分自动化打包都是生成文件后放在payload文件夹下面,但苹果会校验导致安装包无法安装,因此放到 Payload/_CodeSignature 即可。(thanks to bin)


结果:
Payload/_CodeSignature 里面新建 channel1 max1 两个文件,打包成ipa文件存放在mask文件夹下。

如何使用: 

// 读取渠道ID
+ (NSString *)channel {
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *CodeSignaturePath = [resourceDirectory stringByAppendingPathComponent:@"/_CodeSignature/"];
    NSArray* fileArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:CodeSignaturePath error:nil];
    
    for (NSString *filename in fileArray) {
        if ([filename rangeOfString:@"max"].location != NSNotFound) {
            return  [filename substringFromIndex:3];
        }
    }
    return @"0";
}

// 读取友盟渠道ID
+ (NSString *)umengChannel {
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *CodeSignaturePath = [resourceDirectory stringByAppendingPathComponent:@"/_CodeSignature/"];
    NSArray* fileArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:CodeSignaturePath error:nil];
    
    for (NSString *filename in fileArray) {
        if ([filename rangeOfString:@"channel"].location != NSNotFound) {
            return  [filename substringFromIndex:7];
        }
    }
    return @"0";
}



