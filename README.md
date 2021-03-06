---
title: Shell-Learning-iOS如何打渠道包
date: 2016-10-24 10:42:05
tags: shell iOS自动打包
category: shell
---

### 基于Xcode workSpace 生成渠道包 ###
... 待续
### 基于Xcode 命令行工具 自动生成渠道包 ###

``使用说明:`

  	sudo sh autop_xcodebuild.sh
  	
  	
`应用示例:`
  
 <pre><code>
/*! 读取渠道ID */
- (NSString *)channel {
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *CodeSignaturePath = [resourceDirectory stringByAppendingPathComponent:@"/_CodeSignature/AppInfo.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithContentsOfFile:CodeSignaturePath];
    return [data objectForKey:@"channel"];
}
</code></pre>

  
`附注说明 :` 

使用xcodebuild 自动化打包, 以及plistbuddy填充info.plist渠道键值对
   
- [xcodebuild doc in developer apple](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xcodebuild.1.html)
- plistbuddy command 
  
  
`示例工程`

[https://github.com/XuYanci/iOS-AutoPackage](https://github.com/XuYanci/iOS-AutoPackage)

### 基于ipa母包自动生成渠道包 ###

`使用说明`

./autop.sh 源包路径  目标包路径  目标包渠道id标识 目标包mask

示例:

./autop.sh  ./  ./Release/ channel001

过程:

1.解压AutoPackageDemo.ipa源文件

2.在Payload/_CodeSignature 里面新建 AppInfo.plist文件,
并填充key为channelid,value为channel001的键值对

3.压缩生成目标文件


`应用示例:`
<pre><code>
/*! 读取渠道ID */
- (NSString *)channel {
    NSString *resourceDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *CodeSignaturePath = [resourceDirectory stringByAppendingPathComponent:@"/_CodeSignature/AppInfo.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithContentsOfFile:CodeSignaturePath];
    return [data objectForKey:@"channel"];
}
</code></pre>

`附注说明 :` 

经过试验,若将AppInfo.plist放到Payload目录下,会导致生成的包安装失败。
若将AppInfo.plist放到Playload/_CodeSignature里面,则生成的包安装成功。


`示例工程`

[https://github.com/XuYanci/iOS-AutoPackage](https://github.com/XuYanci/iOS-AutoPackage)











