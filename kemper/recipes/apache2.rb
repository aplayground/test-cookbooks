file "Create a file" do
  content "<html><head></head><body><p>AWS Web Server TEST page - Opsworks</p><p>SBX-DistsysTestStack1-698206202.us-west-2.elb.amazonaws.com</p></body></html>"
  group "root"
  mode "0755"
  owner "ubuntu"
  path "/var/www/index.html"
end

if my_elb = node["opsworks"]["stack"]["elb-load-balancers"][1]["dns_name"]
	template "/etc/apache2/sites-enabled/kemper.txt" do
	source "kemper.erb"
	variables :address => my_elb
  end
end

if my_app = node["opsworks"]["applications"][0]["name"]
	template "/etc/apache2/sites-enabled/kemper.txt" do
	source "kemper.erb"
	variables :appname => my_app
  end
end

script "config apache" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    sudo a2enmod proxy
    sudo a2enmod proxy_http
    sudo a2dissite default
	sudo service apache2 restart
  EOH
end

