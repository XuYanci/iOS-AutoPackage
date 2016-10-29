#!bin/sh

#清理工程
xcodebuild clean -project autopackage.xcodeproj -configuration Release -alltargets

echo 'xcodebuild clean~~~~'

#添加渠道号
/usr/libexec/PlistBuddy -c 'Add :Channel string "Channel001"'  Info.plist

#压缩打包
xcodebuild archive -project autopackage.xcodeproj -scheme autopackage -archivePath bin/autopackage.xcarchive

echo 'xcodebuild archive~~~~'

file="bin/autopackage.ipa"

#删除目标
rm bin/autopackage.ipa

#生成目标ipa文件
xcodebuild -exportArchive -archivePath bin/autopackage.xcarchive -configuration Release -exportPath bin/autopackage -exportFormat ipa -exportProvisioningProfile 'xsb iOS Distribution' 

echo 'xcodebuild export archive to ipa~~~~'
