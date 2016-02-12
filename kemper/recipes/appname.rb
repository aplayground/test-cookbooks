if my_app = node["opsworks"]["stack"]["applications"][0]["slug_name"]
	template "/etc/apache2/sites-enabled/kemper.txt" do
	source "kemper.erb"
	variables :appname => my_app
  end
end
