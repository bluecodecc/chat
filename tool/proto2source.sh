#!/bin/bash

set -e

# SWITCH=$2

OLD_DIR=$(pwd);BASE_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd);cd ${OLD_DIR};
GIT_HOME=${BASE_DIR}/../../

if [ -z "$SWITCH" ]||[ "$SWITCH" -eq 1 ]; then
	echo "========== Client/Server 通信协议 =========="
	
	PROJECT_BASE_DIR=${GIT_HOME}/chat/server/protocol
	JAVA_OUT_DIR=${PROJECT_BASE_DIR}/src/main/java
	mkdir -p $JAVA_OUT_DIR
	
	sysOS=`uname -s`
	if [ $sysOS == "Darwin" ];then
		TOOLS_BASE_DIR=${GIT_HOME}/chat/tool/protoc-3.2.0-osx-x86_64
	elif [ $sysOS == "Linux" ];then
		TOOLS_BASE_DIR=${GIT_HOME}/chat/tool/protoc-3.2.0-linux-x86_64
	else
		echo "Other OS: $sysOS"
		exit -1
	fi
	SYSTEM_PROTO_DIR=${TOOLS_BASE_DIR}/include
	PROTOC_PATH=${TOOLS_BASE_DIR}/bin
	PROTOC=${PROTOC_PATH}/protoc
	chmod +x $PROTOC
	
	PROTO_DIR=${GIT_HOME}/chat/proto
	rm -rf $JAVA_OUT_DIR/cc/bluecode/chat/protocol
	
	echo $PROTOC -I=$SYSTEM_PROTO_DIR -I=$PROTO_DIR --java_out=$JAVA_OUT_DIR $PROTO_DIR/*.proto
	$PROTOC -I=$SYSTEM_PROTO_DIR -I=$PROTO_DIR --java_out=$JAVA_OUT_DIR $PROTO_DIR/*.proto
fi

