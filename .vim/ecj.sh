#!/usr/bin/sh
ecj $1
arg1=$1
java_name=${arg1%.*}
dx --dex --output="$java_name.dex" "$java_name.class"
dalvikvm -cp "$java_name.dex" "$java_name"
