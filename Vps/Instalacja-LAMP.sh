# Dodaj do: 
nano /etc/apt/sources.list
# Na końcu:
main contrib non-free

# aktualizuj
apt-get update

# Instalacja serwera www, mysql
apt-get install apache2 php php-mysql php-gd php-mbstring php-mcrypt mysql-server
mysql_secure_installation
a2enmod ssl rewrite
a2ensite default-ssl
service apache2 restart

# w pliku php.ini
nano /etc/php/7.0/apache2/php.ini
# Zmień i kilka innych
extension=php_pdo_mysql.dll

# Włączyć rewrite w pliku <Directory /var/www/>
nano /etc/apache2/apache2.conf
# Zmień None na All
AllowOverride All

# Virtual hosts dodaj do 000-default.conf lub do pojedyńczych plików
nano /etc/apache2/sites-available/000-default.conf

# Gdy pojawia sie błąd połączenia php (dodaj usera do mysql)
mysql -u root -p
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'toor'; 
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'toor';

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
# RDP - zdalny pulpit
apt-get install xrdp
echo "xfce4-session" > ~/.xsession
# Install XFCE4 terminal (way better than xterm)
apt-get install xfce4-terminal
# Install icon sets
apt-get install gnome-icon-theme-full tango-icon-theme
# And or reboot
startxfce4
