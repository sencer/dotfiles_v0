#!/usr/bin/env python
# encoding: utf-8

from twisted.internet import gtk2reactor, protocol as p
reactor = gtk2reactor.install()
import os
import sys
import subprocess
import pynotify

class ListenNotifications(p.Protocol):
  def __init__(self):
    self.notifier = Notifier()

  def dataReceived(self, data):
    self.notifier.message(data.split())
    self.notifier.show()

class ListenerFactory(p.Factory):
  def buildProtocol(self, addr):
    return ListenNotifications()

class Notifier:
  def __init__(self):
    self.notify = pynotify.Notification('dummy', 'dummy')
    self.notify.set_urgency(pynotify.URGENCY_CRITICAL)
    self.notify.set_timeout(2000)
    self.notify.add_action("attr", "Copy path", self.clipboard)
    self.path = None

  def message(self, args):
    self.notify.update('Job Completed', 'Job %s on %s is completed.' % (args[0], args[1]))
    self.path = args[2]

  def clipboard(self, d1, d2):
    os.system("echo '%s' | xsel -bi" % self.path)

  def show(self):
    self.notify.show()

def main():
  try:
    pynotify.init('PBSManager')
    reactor.listenTCP(6666, ListenerFactory())
    ssh = subprocess.Popen( [ '/usr/bin/ssh', '-S', 'none', '-qNCR',
      '6666:localhost:6666', 'ofis' ], shell = False)
    reactor.run()
  finally:
    ssh.terminate()

if __name__ == '__main__':
  main()
