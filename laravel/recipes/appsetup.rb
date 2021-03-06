node[:deploy].each do |app_name, deploy|

  if deploy[:application] == "platform"
   script "set_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/app"
    code <<-EOH
    chmod -R 777 storage
    EOH
  end
  if deploy[:application] == "platform"
   script "set_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/public"
    code <<-EOH
    chmod -R 777 uploads
    EOH
  end    
  end
end
