#!/usr/bin/env python2

# Import the email modules we'll need
import smtpd
import asyncore

class AdhocSMTPServer(smtpd.SMTPServer):
  def __init__(*args, **kwargs):
    # Start smtp server
    smtpd.SMTPServer.__init__(*args, **kwargs)

  def process_message(*args, **kwargs):
    pass

if __name__ == "__main__":
  smtp_server = AdhocSMTPServer(('localhost', 2525), None)
  try:
    asyncore.loop()
  except KeyboardInterrupt:
    smtp_server.close()

