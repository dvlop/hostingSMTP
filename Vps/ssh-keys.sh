# Generuj klucze
ssh-keygen -b 2048 -t dsa

# Uprawniwnia
chmod -R 700 ~/.ssh

# Kopiowanie kluczy
ssh-copy-id -i ~/.ssh/id_dsa.pub user@host.vps

# Lub kopiujemy klucz publiczny na serwer vps do pliku
~/.ssh/authorized_keys

# Konfiguracja serwera ssh w pliku
nano /etc/ssh/sshd_config

# Autoryzacja keys
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

RSAAuthentication no
PasswordAuthentication no
UsePAM no
KerberosAuthentication no
GSSAPIAuthentication no

# Wyłącz logowanie na hasło:
PasswordAuthentication no
UsePam no

# Restart serwera ssh
service ssh restart
/etc/init.d/ssh restart


# Get serwer fingerprint
ssh-keygen -l -f /etc/ssh/ssh_host_dsa_key.pub

# Więcej do poczytania 
https://www.g-loaded.eu/2005/11/10/ssh-with-keys/
