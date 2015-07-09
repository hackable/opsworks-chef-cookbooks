node[:deploy].each do |application, deploy|


  execute 'install bower' do
    command 'npm install -g bower'
    user 'root'
  end
end
