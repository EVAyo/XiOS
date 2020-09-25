#!/bin/sh

#scheme名称
ScheName=$1
if [[ -z "$ScheName" ]]; then
echo "未找到ScheName"
exit 1
fi

#编译配置
BuildConfig=$2
if [[ -z "$BuildConfig" ]]; then
echo "未找到BuildConfig"
exit 1
fi

#导出方式
Export_method=$3
if [[ -z "$Export_method" ]]; then
echo "未找到Export_method"
exit 1
fi

#如果为自定义配置,替换域名
CustomDomian=$4
#if [[ -z "$CustomDomian" ]]; then
#echo ""
#fi

BaseURLPath=`find ~/.jenkins/workspace/qycloud_iOS/Qiyeyun -name 'AllURLHeader.m*'`
echo ${BaseURLPath}

if [[ "$BuildConfig" == "QYCCustomConfig" ]];then
##添加转义字符
#CustomDomian=`echo ${CustomDomian//\//\\\/}`
#echo ${CustomDomian}
##替换域名
#sed -i "" "s/xxxxxx/${CustomDomian}/g" ${BaseURLPath}

echo "1111111111111111111111111111111"
envPlist="/Users/anyuan/.jenkins/workspace/qycloud_iOS/Qiyeyun/Config/envConfig.plist"
/usr/libexec/PlistBuddy -c "Set :Qiyeyun:QYCCustomConfig "${CustomDomian}"" "${envPlist}"
echo "2222222222222222222222222222222222"

fi



#构建(fastlane)
export FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT=60
fastlane beta \
configuration:${BuildConfig} \
scheme:${ScheName} \
export_method:${Export_method}



