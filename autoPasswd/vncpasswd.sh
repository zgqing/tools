#!/bin/bash
set timeout 30  
set password [lindex $argv 0]
spawn vncpasswd
expect "Password:"
send "$password\r"
expect "Verify:"
send "$password\r"
expect "(y/n)?"
send "n\r"
interact
