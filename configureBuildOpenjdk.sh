#!/bin/bash

if [ "$#" -ne 3 ] ; then
    echo "expected 3 arguments:"
    echo " * path to OpenJDK source folder"
    echo " * path to bootstrap JDK"
    echo " * build number"
    exit 1;
fi

unset JAVA_HOME
unset JDK_HOME
unset JRE_HOME
unset _JAVA_OPTIONS

COMMAND="$1/configure --with-boot-jdk=$2 --with-milestone=tuxjdk --with-build-number=$3 --with-jvm-variants=client"
echo "running $COMMAND..."
echo ""
bash $COMMAND

ECODE=$?
if [ $ECODE -ne 0 ] ; then
    echo "Configure failed, exiting..."
    exit $ECODE
fi

echo "Configure finished successfully, starting make..."
echo ""
make images
