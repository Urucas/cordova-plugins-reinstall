#!/bin/bash
echo_fail()
{
  echo -e "\033[31m✗ \033[0m${1}";
  exit 1
}

remove_plugin() {
  REMOVE=$(cordova plugin rm $1)
  echo $REMOVE
}

add_plugin() {
  ADD=$(cordova plugin add $1)
  echo $ADD
}

main() {
  PLUGINS=$(cordova plugin list)
  while read -r line; do
    for plugin in $line; do
      PLUGIN=$plugin
      break
    done
    remove_plugin "$PLUGIN"
    add_plugin "$PLUGIN"
  done <<< "$PLUGINS"
}

if [ -z $(which cordova) ];
then
  echo_fail "Cordova cli not installed"
fi

main
