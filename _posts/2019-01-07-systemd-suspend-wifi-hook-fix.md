---
layout: post
title:  "Systemd Suspend Hook to Fix WiFi"
date:   2017-06-28 22:14:15 -0400
categories: hacks linux systemd suspend wifi archlinux
comments: true
crosspost_to_medium: false
---

My macbook running Arch Linux is currently having problems with the WiFi after
resume from suspend.

Systemd provides a mechanism to run executable files before and after suspend or hibernation.
`/usr/lib/systemd/system-sleep`

This mechanism relies on the system service `systemd-suspend.service`, this
service will run all executable files in `/usr/lib/systemd/system-sleep/`.

Two arguments are going to be passed to the script, before suspend the execution
will look to something like:

```sh
/usr/lib/systemd/system-sleep/wifi-hook.sh "pre" "suspend"
```

After suspend, the execution will be:

```sh
/usr/lib/systemd/system-sleep/wifi-hook.sh "post" "suspend"
```

Is up to you the implementation details, I just wrote a quick hackish bash
script:


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

This scripts are intented for local use and hacks, if you want to react to
system suspend/hibernation and resume from applications you should use
[Inhibitor
interface](https://www.freedesktop.org/wiki/Software/systemd/inhibit/).

Please drop a portion of love in form of comments if this post has been helpful :)
