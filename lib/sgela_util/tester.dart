import 'dart:io';
import 'dart:html' as html;
void main() {
  // Check if the code is running on a web environment.
  if (html.window != null) {
    print('Running on the web');
  } else {
    print('Not running on the web');
  }
}