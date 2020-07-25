---
- hosts: localhost
  connection: local
  become: yes
  
  tasks:
    - name: Create group mandj
      group:
        name: mandj
        gid: 1002
        state: present
        
    - name: Create group gpio
      group:
        name: gpio
        state: present
        system: yes

    - name: Create a user account for Mike
      user:
        name: mike
        uid: 1969
        group: mandj
        password: '$6$ZbWanugns2E$6FeGCSWq97yivD1OZEMPPPWqEzhn.5GbvU4HEe.ohb7lXp3Dz5PcFWggdFh9.d/uvWr9Fbp4XiET2vahDALDY.'
        groups: adm, dialout, cdrom, sudo, audio, video, plugdev, games, users, input, netdev, gpio, i2c, spi
        append: yes
        state: present
        shell: /bin/bash
        system: no
        create_home: yes

    - name: Set Mike's authorized_key for X200
      authorized_key:
        user: mike
        state: present
        key: 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMmKwyb5Wg4lCZMulRAclBOJS6Ukxmv0MTmRIAR/OLIi mike@X200'
      
    - name: Set Mike's authorized_key for PineBookPro
      authorized_key:
        user: mike
        state: present
        key: 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILislSjlQPHgPlLimVZECJ/hTIVT81pIUPoBStOx8qjY rock@Debian-Desktop'
      
    - name: Set Mike's authorized_key for server
      authorized_key:
        user: mike
        state: present
        key: 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7tew3lbJkHS5LCC1Ad/sdfz1mWQXxCAbiYULZhazJ9 mike@apple'

    - name: Set Mike's authorized_key for rpi11
      authorized_key:
        user: mike
        state: present  
        key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtT6uZEnxcZaI5SoO1m6tip/22Q8Rr+46cPvnIHCokzVBPLwZQQtWSrYj6ethAvT9c86oRv+m3E5IW+EHRpJrBHhYq0ZtKdmRd1xip2+LXaIJeVccIkPImV8oRbxgq53m2zZxnD7Z5BCxGbUqmDgezd8XiUCqGX4Rnu7tngdVwRJGgUFJ1gnBNwd+C0kLkbVRINRY3GUBKeMHmGD6tNkxHy5JLZci66Fw/+lJwr8bPKGNusiNKUDoAjwvTlbFNnrALGp0hMQ3ivfYrUxvV8/v8fxOswV6yocgb7f5QzKpFi7Uy9M+QGBEjbRNfRj8p3XbUnIyq2oDgIMybhu892Rgd pi@rpi11.orchard'

    - name: Set Mike's authorized_key for mobile phone
      authorized_key:
        user: mike
        state: present  
        key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCu3N2XI9dUvWembGKEpMO5jay9m5i5OYc3YpZ+AHp5ae2+JrAvSbkKo7U2imyzBbcKUI85bJt5jsETuSmc/3K1cR/18VLAVa37mSbUw1KdsXXTSg9fsAUY9+422+QPRMoiMTj23rFARTDIbxG95hlCrHuNWsi9nnqhQ4KuZ87/rLNG91XtIJAODhdhAvWW7uLBHOb0G9I8eKG5kXBiPOvku57TtCxJsl4r1DWjwFZS6g3/DCzPenitvIpxEn3rxcEVtRoMOHcy96rhFdnDUI7zM9t5yXD7RapK8qwYEnUm2d2WAS7WR5iAQYswOiWaXGhiEfD42oONLT73WPmQ24stW30Hw+XxEJRxCBXWWfVU7GO1+BKxGL+U9L/CD0qbzGKKmsf6Jy4LEikc1jmBdv0jsrSSZlQXyQgePGxwoo4Qv/Dv0VPuZ3Bx6SyPzdYj1DIjqz7CZKTlDAGpnfOqaYz/1MLjn2wTw3CijUiXgTH8N7MN7mPM9/5hnyTyw1U3EDc= u0_a78@localhost'

    - name: Set hostname
      hostname:
        name: alarm.orchard
    - name: Ensure hosts file has correct hostname too
      lineinfile:
        path: /etc/hosts
        regexp: '^127\.0\.1\.1'
        line: 127.0.1.1       alarm.orchard
     
    - name: "Change SSH port number"
      lineinfile:
        dest: "/etc/ssh/sshd_config"
        regexp: "^Port"
        line: "Port 7056"
      notify: Restart ssh
      
    - name: Disallow password authentication
      lineinfile:
        dest: "/etc/ssh/sshd_config"
        regexp: "^PasswordAuthentication"
        line: "PasswordAuthentication no"
        state: present
      notify: Restart ssh

    - name: Disallow root SSH access
      lineinfile:
        dest: "/etc/ssh/sshd_config"
        regexp: "^PermitRootLogin"
        line: "PermitRootLogin no"
        state: present
      notify: Restart ssh
  
    - name: Set timezone
      timezone:
        name: Europe/London
        
    - name: Set GB locale
      locale_gen:
        name: en_GB.UTF-8
        state: present

    - name: Only run "update_cache=yes" if the last one is more than 3600 seconds (1 hr) ago
      apt:
        update_cache: yes
        cache_valid_time: 3600
        
    - name: Install packages
      apt:
        pkg:
        - python3
        - python3-pip
        - python3-gpiozero
        - python3-matplotlib
        - python3-smbus
        - python3-picamera
        - tmux
        - vim
        - mariadb-server
        - mariadb-client
        - python3-mysqldb
        - nmap
        - arp-scan
        - mtr
        - whois
        - mc
        - htop
        - ncdu
        - mutt
        - i2c-tools
        - magic-wormhole
        - wavemon
  
    - name: RPi - enable UART
      lineinfile:
        path: /boot/config.txt
        regexp: 'enable_uart *='
        line: enable_uart=1

    - name: RPi - enable One-wire interface
      lineinfile:
        path: /boot/config.txt
        regexp: 'dtoverlay *= *w1-gpio'
        line: dtoverlay=w1-gpio

    - name: RPi - enable SPI
      lineinfile:
        path: /boot/config.txt
        regexp: 'dtparam *= *spi *='
        line: dtparam=spi=on

    - name: RPi - enable I2C
      lineinfile:
        path: /boot/config.txt
        regexp: 'dtparam *= *i2c_arm *='
        line: dtparam=i2c_arm=on

    - name: RPi - disable ACT LED (RPi Zero)
      lineinfile:
        path: /boot/config.txt
        regexp: 'dtparam *= *act_led_trigger *='
        line: dtparam=act_led_trigger=none

    - name: RPi - make ACT LED active low (RPi Zero)
      lineinfile:
        path: /boot/config.txt
        regexp: 'dtparam *= *act_led_activelow *='
        line: dtparam=act_led_activelow=on

    - name: Delete user account 'pi'
      user:
        name: pi
        state: absent
        remove: yes
        force: yes

#    - name: Reboot the machine
#      reboot:

  handlers:
    - name: Restart ssh
      service:
        name: ssh
        state: restarted
