# Documentation

Osquery is monitoring software developed by Facebook and the open-source community. 
All documentation can be found [on the official osquery website](https://osquery.readthedocs.io/en/stable/)

It's an excellent **system monitor**, but if you wish to monitor specific behavior of applications (a webserver / database / ...) it might be worth it to link Osquery with [Prometheus](https://prometheus.io/).

Osquery makes use of virtual tables which can be queried using an easy SQL-like syntax. 

# Installation 

There is a script available to install osquery on Windows. 
You need to change the IP in the script to point at your elasticsearch server. 
See `/client/script/WindowsInstaller.ps1` or the legacy `/client/script/WindowsInstaller.bat`.

For other installs it's best to read the documentation.
- [Windows](https://osquery.readthedocs.io/en/stable/installation/install-windows/#installing-with-chocolatey)
- [Linux](https://osquery.readthedocs.io/en/stable/installation/install-linux/)
- [MacOs](https://osquery.readthedocs.io/en/stable/installation/install-osx/)

# Configuration

See https://osquery.readthedocs.io/en/stable/deployment/configuration/ for the full explanation. 
- Windows: C:\ProgramData\osquery\osquery.conf
- Linux: /etc/osquery/osquery.conf and /etc/osquery/osquery.conf.d/
- MacOS: /var/osquery/osquery.conf and /var/osquery/osquery.conf.d/

Edit the osquery.conf and osquery.flags files to change what it monitors. The config file can be different for every client (Windows / Linux / Macos). For the honeypots we used [honeypot.osquery.conf](./honeypot.osquery.conf)

# Remarks
We started the project with 5 honeypots. Managing multiple manually could become cumbersome. It might be worth to use an Osquery fleet manager for remote osquery management.  

Examples: 
- [doorman](https://github.com/mwielgoszewski/doorman)
- [kolide/fleet](https://github.com/kolide/fleet)
- Your own solution.

# Using Osquery
## Osqueryi
Osqueryi is the standalone interactive query console. It can run withoud administrator rights and doesn't make use of a service or daemon. osqueryi can be run by typing `osqueryi` in your shell.

Following is an example-query that can be run on all operating systems:  
`Select * from cpuid;`

To retrieve a list of all possible tables on your operating system, run `.table` inside osqueryi.
See the [schema documentation](https://osquery.io/schema/) for more help.

## Osqueryd
Osqueryd is the host monitoring daemon (service on Windows) that allows you to schedule queries and record OS state changes.
The deamon should **always** be running.   
Restart it if you change your config. 

# Troubleshoot 

### General guide

Troubleshoot with this guide: https://medium.com/@clong/osquery-for-security-b66fffdf2daf

### Problem: Config file

(Requires unix machine) Troubleshoot the config file: `sudo osqueryctl config-check ~/Programmeren/GitHub/ai-project/osquery/honeypot.osquery.conf`

### Problem: Access Denied

Access denied to C:\ProgramData\osquery\osqueryd  
--> Give SYSTEM full permissions to the osqueryd folder

### osqueryd has unsafe permissions

(We added the following flag by default to prevent this) Add the --allow_unsafe flag to the osquery.flags



