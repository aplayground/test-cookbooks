script "config for tomcat" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    sudo ln -s /srv/www /usr/share/tomcat7/webapps
	sudo service tomcat7 restart
  EOH
end
