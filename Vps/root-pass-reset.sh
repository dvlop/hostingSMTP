# Na ekranie gruba (po restarcie niebieski ekran) naciskamy: 
e

# do linijki z ro dodajemy po ro (resztę linii usunąć):
rw init=/bin/bash

# naciskamy zapisz
CTR+X

# w consoli zmieniamy hasło:
passwd root

# reboot
exec /sbin/reboot -f

# I logujemy sie z nowym hasłem
