# Documentation

All documentation can be found [on the official osquery website](https://osquery.readthedocs.io/en/stable/)

# Installation 

Linux: dpkg-based distros
-------------------------
````
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
$ sudo add-apt-repository "deb [arch=amd64] https://osquery-packages.s3.amazonaws.com/xenial xenial main"
$ sudo apt-get update
$ sudo apt-get install osquery
````

Windows
-------

There is a script available to install osquery on Windows. 
See `/client/script/WindowsInstaller.bat` and `/client/script/WindowsInstaller.ps1`

Manual installation via [Chocolatey](https://chocolatey.org/install)  
`C:\> choco install osquery`

# Configuration


osquery.conf
-------------

Location Ubuntu: `/etc/osquery/osquery.conf`  
Location Windows: `C:\Programdata\osquery\osquery.conf`

osqueryd.flag

## Troubleshoot osquery

### General guide

Troubleshoot with this guide: https://medium.com/@clong/osquery-for-security-b66fffdf2daf

### Problem: Config file

(Requires unix machine) Troubleshoot the config file: sudo osqueryctl config-check ~/Programmeren/GitHub/ai-project/osquery/honeypot.osquery.conf

### Problem: Access Denied

Access denied to C:\ProgramData\osquery\osqueryd
--> Give SYSTEM full permissions to the osqueryd folder

### osqueryd has unsafe permissions

(We added the following flag by default to prevent this) Add the --allow_unsafe flag to the osquery.flags

# Osqueryi
osqueryi is the standalone interactive query console. It can run withoud administrator rights and doesn't make use of a service or daemon. osqueryi can be ran by typing `osqueryi` in your shell.

Following is an example-query that can be run on all os:

`Select * from cpuid;`

To retreive a list of all possible tables on your operating system, run `.table` inside osqueryi.

# Osqueryd
osqueryd is the host monitoring daemon that allows you to schedule queries and record OS state changes.
You can run it by typing `osqueryd`in your shell


