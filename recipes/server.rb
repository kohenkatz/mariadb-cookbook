#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright 2012, Myplanet Digital, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "mariadb::mariadb_repo"
include_recipe "mysql::server"

if node['mariadb']['oqgraph']

cookbook_file node['mariadb']['oqgraph_install_file'] do
   case node["platform_family"]
when "debian"
source "install_oqgraph.sql"
when "windows"
source "install_oqgraph_win.sql"
end
  owner "root"
  group "root"
  mode "0600"
end

execute "mariadb-install-oqgraph" do
   
   command "mysql -u root -p#{node['mysql']['server_root_password']} < #{node['mariadb']['oqgraph_install_file']}"
   action :run
   only_if { `/usr/bin/mysql -u root -p#{node['mysql']['server_root_password']} -D mysql -r -B -N -e \"SELECT count(*) from information_schema.ENGINES e where e.ENGINE = 'OQGRAPH'"`.to_i == 0 }
end

end
