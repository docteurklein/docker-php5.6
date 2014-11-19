from   base/archlinux

run    pacman -Syyu --noconfirm;  pacman -S --noconfirm base-devel git bzip2 curl libxml2 pcre bzip2 gmp icu libjpeg libldap libltdl libmcrypt libpng libvpx libxslt libzip net-snmp openssl postgresql-libs sqlite tidyhtml re2c; pacman -Scc --noconfirm
run    git clone git://github.com/CHH/php-build /opt/php-build --depth 1
run    /opt/php-build/install.sh
env    PHP_BUILD_CONFIGURE_OPTS --with-pdo-pgsql
run    php-build -i development 5.3.28 /opt/php/5.3; rm -rf /tmp/php-build/
run    php-build -i development 5.4.31 /opt/php/5.4; rm -rf /tmp/php-build/
run    php-build -i development 5.5.15 /opt/php/5.5; rm -rf /tmp/php-build/
run    php-build -i development 5.6snapshot /opt/php/5.6; rm -rf /tmp/php-build/
