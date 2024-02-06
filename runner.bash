#!/bin/bash
MsgTitle="Hi there"
MsgText="Wellcome to Erfan-Yousefi's code"
# Detect the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  command="zenity"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  command="osascript"
else
  command="powershell"
fi
# dialog box method
show_dialog(){
  if [[ "$command" == "zenity" ]]; then
    # Use zenity on Linux
    $command --info --title="$1" --text="$2"
  elif [[ "$command" == "osascript" ]]; then
    # Use osascript on macOS
    $command -e "display dialog \"$2\" with title \"$1\""
  else
    # Use powershell on Windows
    $command "& '$2' | Out-Message -Encoding UTF8"
  fi
}
# Run the Node.js script
run_project(){
    if ! node "./dist/main.js"; then
      ErrorText="Error: Node.js script failed"
      # Show the dialog box
      show_dialog "Warning" "$ErrorText"
      exit 1
    fi
}

# The URL to open in the default browser
url="http://localhost:3000/swagger"

# Use the appropriate command to open the URL in the default browser
if [[ "$OSTYPE" == "darwin"* ]]; then
  open "$url"
  show_dialog "Wellcome" "$MsgText"
  run_project
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
  start "$url"
  show_dialog "Wellcome" "$MsgText"
  run_project
else
  echo "Unsupported operating system: $OSTYPE"
  show_dialog "Warning" "Unsupported operating system: $OSTYPE"
  exit 1
fi


