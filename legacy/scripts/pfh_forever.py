#!/usr/bin/python
import os
import Quartz
import subprocess
import sys
import time

kPOLL_INTERVAL_SECONDS = 15

def get_screen_unlock_status():
    d = Quartz.CGSessionCopyCurrentDictionary()

    if d.get("CGSSessionScreenIsLocked", False):
        return "locked"
    else:
        return "unlocked"

def get_system_command_output(command):
    p = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    p_status = p.wait()
    return str(output).rstrip()

def get_current_timestamp():
    return get_system_command_output("date +%s").rstrip()

while True:
    timestamp = get_current_timestamp()
    if get_screen_unlock_status() == "locked":
        foreground_app_details = "locked##"

    else:
        foreground_app_details = get_system_command_output("osascript scripts/print_foreground_app_details.scpt")

    #print timestamp + "##" + foreground_app_details
    sys.stdout.write(timestamp + "##" + foreground_app_details + '\n')
    sys.stdout.flush()

    time.sleep(kPOLL_INTERVAL_SECONDS)

