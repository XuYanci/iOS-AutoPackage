#! /bin/bash

# 参数1 原文件包目录
# 参数2 渠道id
# 参数3 友盟渠道id
# 参数4 mask

channeliPaPath=$1     #原文件包目录
targetPath=$1         #生成文件包目录
channelId=$2          #渠道id
channelUmengId=$3     #友盟渠道id
mask=$4               #mask
scriptPath=$PWD       #当前脚本路径
editFile="AppInfo.plist"

if [ ! -n "$channeliPaPath" ] ; then
    echo "目标文件目录不存在"
else
    echo "目标文件夹目录 $channeliPaPath"
fi

if [ ! -n "$channelId" ] ; then
    echo "渠道不存在"
else
    echo "渠道id $channelId"
fi

if [ ! -n "$channelUmengId" ] ; then
    echo "友盟渠道id不存在"
else
    echo "友盟渠道id $channelUmengId"
fi

if [ ! -n "$mask" ] ; then
echo "mask不存在"
else
echo "mask $mask"
fi

if [ ! -n "$scriptPath" ] ; then
echo "脚本路径不存在"
else
echo "脚本路径 $scriptPath"
fi

originIpa=""    #原ipa包

#查找文件夹下面的ipa包
funFindSoursePKFile(){
    $find = 0;
    echo "查找文件夹下面的ipa包";
    cd "$1"
for file in * ; do
    echo $file
    #statements
    if [ $file == "Maxer.ipa" ]  #源文件名
    then
        originIpa="$file"
        $find = 1
        echo "源文件：$originIpa"
    break
#    else
#    echo "$originPath 没有ipa包"
#    exit
    fi
    done

    if [$find == 0]
    then
        echo "$originPath 没有ipa包"
    fi
    cd $scriptPath
}

# 查找目录文件下的ipa 文件
funFindSoursePKFile $channeliPaPath
cd $channeliPaPath
echo "当前路径 $(pwd)"

#解压
cd ${channeliPaPath}
tar -xf ${originIpa}
open ${originPath}
cd $scriptPath
echo "当前路径 $(pwd)"
echo "${originIpa}"
##延时函数
funcDelay(){
    t=0
    echo "wait..."
    while [ $t -lt $1 ]; do
        #statements
        sleep 1s
        t=`expr $t + 1`
    done
    echo "contine..."
}

funcDelay 2
open $targetPath

#修改文件 $1:起始路径 $2:编辑的文件 $3:修改的内容
funFindSPlistFile(){
    cd $1
    echo "$1"
    for file in * ; do
    echo $file
    #statements
    if [ -e $file ];
    then
    echo "源文件：$file"
    cd $file
    echo "当前工作目录 :$(pwd)"
    #statements
    find . -name $2 -ls
    ret=$?
    if [ $ret -eq 0 ]; then
        #statements
        editFilePath=$(pwd)/$2
        echo "找到需要需改的文件 :$editFilePath"
        defaults write $editFilePath channel $3
        # #修改文件
        echo "defaults write $editFilePath channel $3"
        echo "修改文件结果 $?"
    else
        echo "没有找到需要修改的文件"
    exit
fi

else
echo "$1 没有文件"
fi
done
cd $scriptPath
}

funFindSPlistFile1(){
    cd $1
    echo "$1"
    for file in * ; do
        echo $file
    #statements
    if [ -e $file ];
    then
        echo "源文件：$file"
        cd $file
        echo "当前工作目录 :$(pwd)"
        #statements
        find . -name $2 -ls
        ret=$?
    if [ $ret -eq 0 ]; then
        #statements
        editFilePath=$(pwd)/$2
        echo "找到需要需改的文件 :$editFilePath"
        defaults write $editFilePath umeng_channel $3
        # #修改文件
        echo "defaults write $editFilePath umeng_channel $3"
        echo "修改文件结果 $?"
    else
        echo "没有找到需要修改的文件"
        exit
    fi

    else
        echo "$1 没有文件"
    fi
    done
    cd $scriptPath
}

#修改并打包 $1:修改内容
EditPackage(){
    cd $channeliPaPath
    echo $(pwd)

    #结果包名字
    targetfile=$originIpa
    targetfile=${originIpa/.ipa/_$1.ipa}
    echo "完成的文件:$targetfile"
    #打包
    # tar -cf ${targetfile} Payload/
    zip -r ${targetfile} Payload/
    echo "打包完成:$?"
    #完成包位置移动
    dirPath=${channeliPaPath}/$2/

    if [ -d "$dirPath" ]; then
        mv ${targetfile} $dirPath
    else
        mkdir -p $dirPath & mv ${targetfile} $dirPath
    fi

    echo "拷贝完成:$?"
    rm -rf Payload
    echo "删除临时文件完成:$?"
}


funFindSPlistFile "${channeliPaPath}/Payload" "_CodeSignature/${editFile}"  $channelId
funFindSPlistFile1 "${channeliPaPath}/Payload" "_CodeSignature/${editFile}" $channelUmengId
EditPackage $mask  $channelId

