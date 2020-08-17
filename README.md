# ansible-role-iobroker

Manage `iobroker`, a home automation system.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `iobroker_user` | User name of `iobroker` | `{{ __iobroker_user }}` |
| `iobroker_group` | Group name of `iobroker` | `{{ __iobroker_group }}` |
| `iobroker_groups` | Extra groups of user `iobroker` | `{{ __iobroker_groups }}` |
| `iobroker_dir` | Path to root directory of `iobroker` | `{{ __iobroker_dir }}` |
| `iobroker_required_packages` | Required packages by `iobroker` | `{{ __iobroker_required_packages }}` |
| `iobroker_npm_package` | `npm` package name of `iobroker` | `iobroker` |
| `iobroker_npm_registry` | URL of `npm` package registry | `https://registry.npmjs.org` |
| `iobroker_service` | Service name of `iobroker` | `{{ __iobroker_service }}` |
| `iobroker_flags` | Not implemented yet | `""` |

## Debian

| Variable | Default |
|----------|---------|
| `__iobroker_user` | `iobroker` |
| `__iobroker_group` | `{{ __iobroker_user }}` |
| `__iobroker_groups` | `["audio", "dialout", "tty", "video"]` |
| `__iobroker_service` | `iobroker` |
| `__iobroker_required_packages` | `["acl", "sudo", "libcap2-bin", "build-essential", "gcc", "g++", "make", "libavahi-compat-libdnssd-dev", "libudev-dev", "libpam0g-dev", "pkg-config", "git", "curl", "unzip", "net-tools", "python3-dev"]` |
| `__iobroker_dir` | `/opt/iobroker` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__iobroker_user` | `iobroker` |
| `__iobroker_group` | `{{ __iobroker_user }}` |
| `__iobroker_groups` | `["dialer"]` |
| `__iobroker_service` | `iobroker` |
| `__iobroker_required_packages` | `["sudo", "git", "curl", "bash", "unzip", "avahi-libdns", "dbus", "nss_mdns", "gcc", "lang/python3"]` |
| `__iobroker_dir` | `/usr/local/iobroker` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__iobroker_user` | `_iobroker` |
| `__iobroker_group` | `{{ __iobroker_user }}` |
| `__iobroker_groups` | `["dialer"]` |
| `__iobroker_service` | `iobroker` |
| `__iobroker_required_packages` | `["sudo", "git", "curl", "bash", "unzip--", "avahi", "dbus", "gcc"]` |
| `__iobroker_dir` | `/usr/local/iobroker` |

## RedHat

| Variable | Default |
|----------|---------|
| `__iobroker_user` | `iobroker` |
| `__iobroker_group` | `{{ __iobroker_user }}` |
| `__iobroker_groups` | `["audio", "dialout", "tty", "video"]` |
| `__iobroker_service` | `iobroker` |
| `__iobroker_required_packages` | `["acl", "avahi", "avahi-compat-libdns_sd", "avahi-compat-libdns_sd-devel", "curl", "gcc", "gcc-c++", "git", "libcap", "pam-devel", "libudev-devel", "make", "net-tools", "pkgconfig", "python3-devel", "sudo", "unzip"]` |
| `__iobroker_dir` | `/opt/iobroker` |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - name: trombik.apt_repo
      when: ansible_os_family == 'Debian'
    - name: trombik.redhat_repo
      when: ansible_os_family == 'RedHat'
    - name: trombik.nodejs
    - name: ansible-role-iobroker
  vars:
    # see https://iobroker.net/install.sh
    os_nodejs_package:
      FreeBSD: www/node12
      Debian: "{{ __nodejs_package }}"
      RedHat: "{{ __nodejs_package }}"
    nodejs_package: "{{ os_nodejs_package[ansible_os_family] }}"
    os_nodejs_npm_package:
      FreeBSD: www/npm-node12
      Debian: "{{ __nodejs_package }}"
      RedHat: "{{ __nodejs_package }}"
    nodejs_npm_package: "{{ os_nodejs_npm_package[ansible_os_family] }}"

    apt_repo_keys_to_add:
      - https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    apt_repo_to_add:
      - "deb https://deb.nodesource.com/node_12.x {{ ansible_distribution_release }} main"
    redhat_repo:
      nodesource:
        baseurl: https://rpm.nodesource.com/pub_12.x/el/$releasever/$basearch
        gpgcheck: yes
        gpgkey: https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL
```

# License

```
Copyright (c) 2020 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
