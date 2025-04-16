#!/bin/bash
[ -z "$1" ] || [ "$1" == "latest" ] && rover_version="latest" || rover_version="v$1"

run() {
  echo "Fetching $rover_version of Rover CLI..."

  curl -sSL https://rover.apollo.dev/nix/$rover_version -o installer

  if [ "$(head -n1 installer)" != "#!/bin/bash" ]; then
    echo "There was a problem fetching $rover_version of Rover CLI:"
    cat installer
    return 1
  fi

  sh installer --force

  if [ $? -ne 0 ]; then
    echo "Failed to install Rover CLI"
    return $?
  fi

  echo "$HOME/.rover/bin" >> $GITHUB_PATH
}

run
exit_code=$?

if [ -f installer ]; then
  rm installer
fi

exit $exit_code
