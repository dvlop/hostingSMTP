# Kolor prompt
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Dodaj do: 
nano /etc/apt/sources.list
# Na końcu:
main contrib non-free

# aktualizuj
apt-get update

# Instalacja serwera apache2 z php i mariadb serwer
apt-get install apache2 php php-mysql php-gd php-mbstring php-mcrypt mysql-server
# Zabezpiecz mysql serwer
mysql_secure_installation
# Włącz apache2 mods i strony i restart
a2enmod ssl rewrite
a2ensite default-ssl
service apache2 restart

# W pliku php.ini
nano /etc/php/7.0/apache2/php.ini
# Zmień i kilka innych, sockets, curl, imap ... (To co potrzebne)
extension=php_pdo_mysql.dll

# Włączyć rewrite w pliku <Directory /var/www/>
nano /etc/apache2/apache2.conf
# Zmień None na All
AllowOverride All

# Virtual hosts dodaj do 000-default.conf lub do pojedyńczych plików
nano /etc/apache2/sites-available/000-default.conf

# Wyłącz lub włącz stronę
a2dissite 000-default
a2ensite 000-default

# Po aktualizacji sites-available
service apache2 restart

# Chmody dla folderu stron www
chown -R www-data /var/www/html
chmod -R 755 /var/www/html

# Wyświetl info
ls -l /var/www

# Logi serwera apache 
cat /var/log/apache2/error.log
# Lub na online
tail -f /var/log/apache2/error.log

# Gdy pojawia sie błąd połączenia php (dodaj usera do mysql, nzawa usera i hasło dowolne)
mysql -u root -p
# I kwerenda
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'toor'; 
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'toor';
FLUSH PRIVILEGES;

# Kopia zapasowa wszystkich baz danych
mysqldump -u root -p --all-databases > all.sql
# Wybranych baz danych
mysqldump -u root -p --add-locks --add-drop-database --databases dbname1 dbname2 > db.sql

# desktop MATE
apt-get install mate-desktop-environment-extras mate-tweak
# RDP - zdalny pulpit
apt-get install xrdp
echo "mate-session" > ~/.Xclients
echo "mate-session" > ~/.xsession

# desktop xfce4
apt-get install xfce4
# Install XFCE4 terminal (way better than xterm)
apt-get install xfce4-terminal
# Install icon sets
apt-get install gnome-icon-theme-full tango-icon-theme
# And or reboot
startxfce4
# RDP - zdalny pulpit
apt-get install xrdp
echo "xfce4-session" > ~/.xsession

# Do łączenia sie z serwerem vps z RDP użyj na windows programu:
mstsc

# Odblokuj na firewallu odpowiednie porty, gdy uzywasz firewalla (iptables) :)
ssh: 22
http: 80
https: 443
rdp: 3389
smtp: 25,587
