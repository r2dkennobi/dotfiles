#!/usr/bin/env python2

# Import the email modules we'll need
import urllib, json, socket

if __name__ == "__main__":
  # Grab external IP address
  data = json.loads(urllib.urlopen("http://ip.jsontest.com/").read())
  # Setup socket to grab local IP address
  s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  s.connect(('8.8.8.8', 80))

  print("External: " + data['ip'])
  print("Internal: " + s.getsockname()[0])

  s.close()
