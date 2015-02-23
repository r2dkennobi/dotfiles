#!/usr/bin/env python2

# Import the email modules we'll need
import urllib, json
import smtplib
from email.mime.text import MIMEText

if __name__ == "__main__":
  # Grab external IP address
  data = json.loads(urllib.urlopen("http://ip.jsontest.com/").read())
  print(data['ip'])

  from_addr = 'dragonbddy@something.com'
  to_addr = 'kyokoyam@ucsd.edu'

  # Create a text/plain message
  msg = MIMEText(data['ip'])

  # me == the sender's email address
  # you == the recipient's email address
  msg['Subject'] = 'The current IP address of the dragon board'
  msg['From'] = from_addr
  msg['To'] = to_addr

  # Send the message via our own SMTP server, but don't include the
  # envelope header.
  try:
    s = smtplib.SMTP('localhost', 2525)
    #s.connect()
    s.sendmail(from_addr, to_addr, msg.as_string())
    s.quit()
  except smtplib.SMTPException:
    print("SMTP error")
