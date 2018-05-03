# Instalacja do wysyłania
# Lub na bazach danych z https://linode.com/docs/email/postfix/email-with-postfix-dovecot-and-mysql/
apt-get install postfix mailutils

# Uruchomić
dpkg-reconfigure postfix

# Lub konfiguracja w pliku nano /etc/main.cf jak poniżej:

#myorigin = /etc/mailname
smtpd_banner = $myhostname ESMTP $mail_name (SMTP SERWER)
biff = no
# appending .domain is the MUA's job.
append_dot_mydomain = no
# Uncomment the next line to generate "delayed mail" warnings
#delay_warning_time = 4h
readme_directory = no
# See http://www.postfix.org/COMPATIBILITY_README.html -- default to 2 on
# fresh installs.
compatibility_level = 2

# TLS parameters
smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
smtpd_use_tls=yes
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache
smtp_sasl_security_options = noanonymous

# Relay ban
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated reject_unauth_destination reject
myhostname = zix.kupfure.pl
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
myorigin = kupfure.pl
# myorigin = /etc/mailname
mydestination = kupfure.pl, localhost
relayhost = 
mynetworks = 127.0.0.0/8
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = ipv4

# SSL force
smtpd_tls_security_level=encrypt
smtpd_use_tls=yes
smtpd_enforce_tls=yes

# Restrictions
smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination reject
smtpd_sender_restrictions = reject_unknown_sender_domain
smtpd_helo_restrictions = reject_unknown_helo_hostname
smtpd_data_restrictions = reject_unauth_pipelining

