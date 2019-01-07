---
layout: post
title:  "Hacks"
date:   2017-06-28 22:14:15 -0400
categories: hacks linux
comments: true
crosspost_to_medium: false
---

# Hacks

## Systemd Suspend Hook

My macbook running Arch Linux is currently having problems with the WiFi after
resume from suspend.

After doing a quick read over `man systemd-suspend.service` the following script brings to life.

### `systemd-sleep-wifi-on-off.sh`

#### Setup

 1. Copy or symlink the file into `/usr/lib/systemd/system-sleep`
 1. Set the corresponding permissions to execute the file `systemd-sleep-wifi-on-off`

#### Script

```sh
#!/bin/sh

_log () {
	echo "[$0] $1" | systemd-cat
}

_stop_wifi () {
	if nmcli networking off; then
      _log "Network stoped via nmcli"
  else
      _log "Error stopping network via nmcli"
  fi

	if modprobe -r wl; then
      _log "Kernel module [wl] removed"
  else
      _log "Error removing kernel module [wl]"
  fi
}

_start_wifi () {
	  if modprobe wl; then
        _log "Kernel module [wl] loaded"
    else
        _log "Error loading Kernel module [wl]"
    fi

	  if nmcli networking on; then
        _log "Network set to ON via nmcli"
    else
        _log "Error while setting Network to ON via nmcli"
    fi
}

_pre () {
	_stop_wifi
}

_post () {
	_start_wifi
}

main () {
    if [[ "$2" == "suspend" ]]; then
        case "$1" in
		        pre)
			          _pre
			          ;;
		        post)
			          _post
			          ;;
	      esac
    fi
}

main "$@"
```
