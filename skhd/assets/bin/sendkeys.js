#!/usr/bin/osascript -l JavaScript

function run(argv) {
  if (argv.length === 0) {
    return;
  }
  var sysEvent = Application('System Events');
  sysEvent.keystroke(argv[0]);
}
