node[:deploy].each do |application, deploy|


  execute 'update bower' do
    command 'npm update -g bower'
    user 'root'
  end

  execute 'bower install' do
    command 'bower install --allow-root'
    cwd deploy[:current_path]
  end
end

