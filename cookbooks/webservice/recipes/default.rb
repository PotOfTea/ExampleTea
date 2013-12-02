install_path = node["webservice"]["install_dir"]
webservice_jar = node["webservice"]["webservice_jar"]
ws_url = node["webservice"]["webservice_url_full"]

group node["webservice"]["group"]

user node["webservice"]["user"] do
	group node["webservice"]["group"]
	system true
	shell "/bin/bash"
end

directory node["webservice"]["install_dir"] do
	owner node["webservice"]["user"]
	group node["webservice"]["group"]
	mode 00755
	action :create
end

include_recipe "webservice::jmxetric"

cookbook_file node["webservice"]["webservice_jar"] do
	path "#{install_path}/#{webservice_jar}"
	owner node["webservice"]["user"]
	group node["webservice"]["group"]
	action :create_if_missing
end

template "/etc/init.d/webservice.sh" do
	source "webservice.sh.erb"
    owner "root"
    group "root"
    mode "754"
    notifies :run, "bash[run-webservice]", :immediately
    notifies :run, "execute[ws-starup]", :immediately
end

bash "run-webservice" do
  code <<-EOF
  /etc/init.d/webservice.sh
  EOF
  action :nothing
end

execute "ws-starup" do
  command "update-rc.d webservice.sh defaults"
  action :nothing
end

log "Ganglia started: http://127.0.0.1:8080/ganglia/"
log "Web service started: http://127.0.0.1:8181/ws/passgen?wsdl"
