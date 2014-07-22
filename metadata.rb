name "mariadb"
maintainer       "Moshe Katz"
maintainer_email "moshe@ymkatz.net"
license          "MIT"
description      "Installs/Configures MariaDB"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends          "apt"
depends          "mysql", "< 5.0"
