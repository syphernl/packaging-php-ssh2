#!/bin/bash
source vars.sh

echo "Building package..."

echo "[Build] Current path: ${PWD}"
cd /src/ssh2*/
phpize && ./configure && make && make install

echo "[Build] Current path: ${PWD}"
# Copy module file
mkdir -p /dist/package/usr/lib/php/20151012/
cp /usr/lib/php/20151012/ssh2.so /dist/package/usr/lib/php/20151012/

# Enable the module
mkdir -p /dist/package/etc/php/7.0/mods-available
echo "extension=ssh2.so" >> /dist/package/etc/php/7.0/mods-available/ssh2.ini

echo "[Build] Current path: ${PWD}"

cd "/dist/package/"

echo "[Build] Current path: ${PWD}"

fpm --verbose -s dir -t deb \
--url "http://www.libssh2.org" \
--description "Bindings for the libssh2 library" \
--license "PHP License" \
--maintainer "$PKG_MAINTAINER" \
--vendor "$PKG_VENDOR" \
--version "${APP_VERSION:-1.0}" \
--iteration "${APP_ITERATION}" \
--after-install /build/scripts/post-install.sh \
--before-remove /build/scripts/pre-remove.sh \
-n php-ssh2 .


#printf "\n" | fpm --verbose -s pear -t deb \
#--url "http://www.libssh2.org" \
#--description "Bindings for the libssh2 library" \
#--license "PHP License" \
#--maintainer "$PKG_MAINTAINER" \
#--vendor "$PKG_VENDOR" \
#--version "${APP_VERSION:-1.0}" \
#--iteration "${APP_ITERATION}" \
#--pear-package-name-prefix "" \
#-n php-ssh2 https://pecl.php.net/get/ssh2

mv *.deb /build/packages
