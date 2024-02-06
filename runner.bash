#!/bin/bash

# Run the Node.js script

run_project(){
    if ! node ./dist/main.js; then
    echo "Error: Node.js script failed"
    exit 1
    fi
}
# The URL to open in the default browser
url="http://localhost:3000/swagger"

# Use the appropriate command to open the URL in the default browser
if [[ "$OSTYPE" == "darwin"* ]]; then
  open "$url"
  run_project
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
  start "$url"
  run_project
else
  echo "Unsupported operating system: $OSTYPE"
  exit 1
fi
