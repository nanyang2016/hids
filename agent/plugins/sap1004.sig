<?xml version="1.0" encoding="UTF-8"?>
<sap1004>
<log-col buf_max="10240">
	<log-path intval="300" name="messages" buf_max="1024" upload_min="1">/var/log/messages</log-path>
	<log-path intval="300" name="lastlog" buf_max="1024" upload_min="1">/var/log/lastlog</log-path>
	<log-path intval="300" name="utmp" buf_max="1024" upload_min="1">/var/run/utmp</log-path>
	<log-path intval="300" name="wtmp" buf_max="1024" upload_min="1">/var/log/wtmp</log-path>
	<log-path intval="300" name="faillog" buf_max="1024" upload_min="1">/var/log/faillog</log-path>
	<log-path intval="300" name="secure" buf_max="1024" upload_min="1">/var/log/secure</log-path>
</log-col>
<key-file maxfilesize="" >
	<file-path intval="600" md5="" >/etc/passwd</file-path>
	<file-path intval="600" md5="" >/bin/ls</file-path>
	<file-path intval="600" md5="" >/bin/ps</file-path>
	<file-path intval="600" md5="" >/bin/netstat</file-path>
	<file-path intval="600" md5="" >/bin/login</file-path>
	<file-path intval="600" md5="" >/usr/bin/find</file-path>
	<file-path intval="600" md5="" >/sbin/ifconfig</file-path>
	<file-path intval="600" md5="" >/usr/sbin/sshd</file-path>
	<file-path intval="600" md5="" >/usr/bin/ssh</file-path>
	<file-path intval="600" md5="" >/usr/local/sbin/sshd</file-path>
	<file-path intval="600" md5="" >/usr/local/bin/ssh</file-path>
	<file-path intval="600" md5="" >/lib/security/pam_unix.so</file-path>
	<file-path intval="600" md5="" >/lib64/security/pam_unix.so</file-path>
	<file-path intval="600" md5="" >/etc/init.d</file-path>
	<file-path intval="600" md5="" >/etc/init.d/rc3.d</file-path>
</key-file>
<log-parse>
        <log-path name="messages">/var/log/messages</log-path>
        <log-path name="secure">/var/log/secure</log-path>
        <log-path name="auth">/var/log/auth.log</log-path>
</log-parse>
</sap1004>
