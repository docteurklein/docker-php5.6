rm -rf files
docker rm php-build
docker create --name php-build php-build ls
docker cp php-build:/opt/php/5.6/bin files/php
docker cp php-build:/opt/php/5.6/etc files/php
docker cp php-build:/opt/php/5.6/lib/php/extensions/no-debug-non-zts-20131226 files/php/lib/php/extensions

#ldd /opt/php/5.6/bin/php | awk 'NF == 4 {print $3}; NF == 2 {print $1}'

#linux-vdso.so.1
docker cp php-build:/usr/lib/libcrypt.so.1       files/usr/lib/libcrypt.so.1
docker cp php-build:/usr/lib/libz.so.1           files/usr/lib/libz.so.1
docker cp php-build:/usr/lib/libexslt.so.0       files/usr/lib/libexslt.so.0
docker cp php-build:/usr/lib/libtidy-0.99.so.0   files/usr/lib/libtidy-0.99.so.0
docker cp php-build:/usr/lib/libresolv.so.2      files/usr/lib/libresolv.so.2
docker cp php-build:/usr/lib/libreadline.so.6    files/usr/lib/libreadline.so.6
docker cp php-build:/usr/lib/libncursesw.so.5    files/usr/lib/libncursesw.so.5
docker cp php-build:/usr/lib/librt.so.1          files/usr/lib/librt.so.1
docker cp php-build:/usr/lib/libpq.so.5          files/usr/lib/libpq.so.5
docker cp php-build:/usr/lib/libmcrypt.so.4      files/usr/lib/libmcrypt.so.4
docker cp php-build:/usr/lib/libltdl.so.7        files/usr/lib/libltdl.so.7
docker cp php-build:/usr/lib/libpng16.so.16      files/usr/lib/libpng16.so.16
docker cp php-build:/usr/lib/libjpeg.so.8        files/usr/lib/libjpeg.so.8
docker cp php-build:/usr/lib/libcurl.so.4        files/usr/lib/libcurl.so.4
docker cp php-build:/usr/lib/libm.so.6           files/usr/lib/libm.so.6
docker cp php-build:/usr/lib/libdl.so.2          files/usr/lib/libdl.so.2
docker cp php-build:/usr/lib/libnsl.so.1         files/usr/lib/libnsl.so.1
docker cp php-build:/usr/lib/libxml2.so.2        files/usr/lib/libxml2.so.2
docker cp php-build:/usr/lib/libgssapi_krb5.so.2 files/usr/lib/libgssapi_krb5.so.2
docker cp php-build:/usr/lib/libkrb5.so.3        files/usr/lib/libkrb5.so.3
docker cp php-build:/usr/lib/libk5crypto.so.3    files/usr/lib/libk5crypto.so.3
docker cp php-build:/usr/lib/libcom_err.so.2     files/usr/lib/libcom_err.so.2
docker cp php-build:/usr/lib/libssl.so.1.0.0     files/usr/lib/libssl.so.1.0.0
docker cp php-build:/usr/lib/libcrypto.so.1.0.0  files/usr/lib/libcrypto.so.1.0.0
docker cp php-build:/usr/lib/libxslt.so.1        files/usr/lib/libxslt.so.1
docker cp php-build:/usr/lib/libc.so.6           files/usr/lib/libc.so.6
docker cp php-build:/usr/lib/libgcrypt.so.20     files/usr/lib/libgcrypt.so.20
docker cp php-build:/usr/lib/libgpg-error.so.0   files/usr/lib/libgpg-error.so.0
docker cp php-build:/usr/lib/libpthread.so.0     files/usr/lib/libpthread.so.0
docker cp php-build:/usr/lib/libssh2.so.1        files/usr/lib/libssh2.so.1
docker cp php-build:/usr/lib/liblzma.so.5        files/usr/lib/liblzma.so.5
docker cp php-build:/usr/lib/libkrb5support.so.0 files/usr/lib/libkrb5support.so.0
docker cp php-build:/usr/lib/libkeyutils.so.1    files/usr/lib/libkeyutils.so.1
docker cp php-build:/lib64/ld-linux-x86-64.so.2  files/lib64/ld-linux-x86-64.so.2

# docker cp sucks: it resolves symlinks and only creates dirs
for file in files/usr/lib/*/*; do
    dir=${file%/*}
    echo $dir
    mv $file files/usr/lib/${file##*/}.new
    rm -rf $dir
    mv files/usr/lib/${file##*/}.new $dir
done;

for file in files/lib64/*/*; do
    dir=${file%/*}
    echo $dir
    mv $file files/usr/lib/${file##*/}.new
    rm -rf $dir
    mv files/usr/lib/${file##*/}.new $dir
done;

rm files/php/bin/php-cgi
rm files/php/bin/phar
rm files/php/bin/phar.phar
rm files/php/bin/php-config
rm files/php/bin/phpize
rm files/php/bin/pyrus
rm files/php/bin/pyrus.phar

docker build -t docteurklein/php5.6 .
docker images docteurklein/php5.6
docker run --rm -it docteurklein/php5.6

