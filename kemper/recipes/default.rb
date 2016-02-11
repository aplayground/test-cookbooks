file "Create a file" do
  content "<html><head></head><body><p>AWS Web Server TEST page - Opsworks</p><p>SBX-DistsysTestStack1-698206202.us-west-2.elb.amazonaws.com</p></body></html>"
  group "root"
  mode "0755"
  owner "ubuntu"
  path "/var/www/index.html"
end

cookbook_file "Copy a file" do  
  group "root"
  mode "0755"
  owner "ubuntu"
  path "/etc/apache2/sites-enabled/kemper.txt"
  source "kemper" 
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

if my_elb = node["opsworks"]["stack"]["elb-load-balancers"]["1"]["dns_name"]
  template “/etc/elb.conf” do
    source "elb.erb"
    variables :address => my_elb
  end
end
