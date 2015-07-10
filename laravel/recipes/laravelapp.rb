node[:deploy].each do |app_name, deploy|

  script "set_permissions" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/app"
    code <<-EOH
    chmod -R 777 storage
    EOH
  end

  template "#{deploy[:deploy_to]}/current/.env.local.php" do
    source 'env.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(
      :env => deploy[:environment_variables]
    )
  end
  
  template "#{deploy[:deploy_to]}/current/app/config/local/database.php" do
    source "database.php.erb"
    mode 0660
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")   
      owner "apache"
    end
  

    variables(
      :host =>     (deploy[:database][:host] rescue nil),
      :user =>     (deploy[:database][:username] rescue nil),
      :password => (deploy[:database][:password] rescue nil),
      :db =>       (deploy[:database][:database] rescue nil)
    )

  only_if do
    File.directory?("#{deploy[:deploy_to]}/current")
  end
end
end
