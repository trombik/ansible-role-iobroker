# ansible-role-iobroker

A brief description of the role goes here.

# Requirements

None

# Role Variables

| variable | description | default |
|----------|-------------|---------|


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
    os_nodejs_package:
      FreeBSD: www/node10
      Debian: "{{ __nodejs_package }}"
      RedHat: "{{ __nodejs_package }}"
    nodejs_package: "{{ os_nodejs_package[ansible_os_family] }}"
    os_nodejs_npm_package:
      FreeBSD: www/npm-node10
      Debian: "{{ __nodejs_package }}"
      RedHat: "{{ __nodejs_package }}"
    nodejs_npm_package: "{{ os_nodejs_npm_package[ansible_os_family] }}"

    apt_repo_keys_to_add:
      - https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    apt_repo_to_add:
      - "deb https://deb.nodesource.com/node_10.x {{ ansible_distribution_release }} main"
    redhat_repo:
      nodesource:
        baseurl: https://rpm.nodesource.com/pub_10.x/el/$releasever/$basearch
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
