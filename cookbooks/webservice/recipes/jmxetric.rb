require 'uri'

install_path = node["webservice"]["install_dir"]

jmx_url = node["webservice"]["jmxetric"]
jmx_uri = ::URI.parse(jmx_url)
jmx_filename = ::File.basename(jmx_uri.path)

gmet_url = node["webservice"]["gmetric4j"]
gmet_uri = ::URI.parse(gmet_url)
gmet_filename = ::File.basename(gmet_uri.path)

oncr_url = node["webservice"]["oncrpc"]
oncr_uri = ::URI.parse(oncr_url)
oncr_filename = ::File.basename(oncr_uri.path)

remote_file "#{install_path}/#{jmx_filename}" do
	source jmx_url
	mode 00644
	action :create_if_missing
end

remote_file "#{install_path}/#{gmet_filename}" do
	source gmet_url
	owner node["webservice"]["user"]
	group node["webservice"]["group"]
	mode 00644
	action :create_if_missing
end

remote_file "#{install_path}/#{oncr_filename}" do
	source oncr_url
	owner node["webservice"]["user"]
	group node["webservice"]["group"]
	mode 00644
	action :create_if_missing
end

template "#{install_path}/jmxetric.xml" do
	source "jmxetric.xml.erb"
	owner node["webservice"]["user"]
	group node["webservice"]["group"]
	mode 0644
end

template "#{install_path}/logging.properties" do
	source "logging.properties.erb"
	owner node["webservice"]["user"]
	group node["webservice"]["group"]
	mode 0644
end