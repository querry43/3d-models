#!/usr/bin/env python

import RPi.GPIO as GPIO
import argparse
import json
import os
import sys
import time
import urllib2

class Controller:
    on_pin     = 20
    off_pin    = 21
    abort_pin  = 26
    loop_delay = 0.1
    octoprint  = 'http://printer.underdogma.net'
    api_key    = 'D05E9307A8034C3191ED93D3EBBA72DB'

    def __init__(self):
        GPIO.setmode(GPIO.BCM)
        for i in [self.on_pin, self.off_pin, self.abort_pin]:
            GPIO.setup(i, GPIO.IN, pull_up_down=GPIO.PUD_UP)

    def _send_data(self, location, data):
        d = json.dumps(data)
        print location + ' ' + d

        try:
            response = urllib2.urlopen(
                urllib2.Request(
                    self.octoprint + location,
                    d,
                    { 'X-Api-Key': self.api_key, 'Content-Type': 'application/json' }
                )
            )
            print "response: " + str(response.getcode()) + "\n"
        except urllib2.HTTPError as e:
            print "response: " + str(e.code) + "\n"
            if e.code != 409:
                raise

    def _send_commands(self, commands):
        self._send_data('/api/printer/command', { "commands": commands })

    def _power_on(self):
        self._send_commands(['M80'])

    def _power_off(self):
        self._abort()
        self._send_commands(['M81'])

    def _abort(self):
        self._send_data('/api/job', {"command": "cancel"});

    def run(self):
        while True:
            if GPIO.input(self.on_pin) == False:
                self._power_on()
                while GPIO.input(self.on_pin) == False:
                    time.sleep(self.loop_delay)
        
            if GPIO.input(self.off_pin) == False:
                self._power_off()
                while GPIO.input(self.off_pin) == False:
                    time.sleep(self.loop_delay)
        
            if GPIO.input(self.abort_pin) == False:
                self._abort()
                while GPIO.input(self.abort_pin) == False:
                    time.sleep(self.loop_delay)
        
            time.sleep(self.loop_delay)


parser = argparse.ArgumentParser(description='Control octoprint via buttons on gpio')
parser.add_argument('-l', '--log')
parser.add_argument('-p', '--pidfile')
parser.add_argument('-b', '--background', action='store_true')
args = parser.parse_args()

if args.background:
    pid = os.fork()
    if pid != 0:
        os._exit(0)

if args.log is not None:
    sys.stdout = open(args.log, 'a')
    sys.stderr = open(args.log, 'a')

if args.pidfile is not None:
    file(args.pidfile, 'w').write(str(os.getpid()))

Controller().run()
