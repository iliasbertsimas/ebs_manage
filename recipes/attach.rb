



cookbook_file '/usr/bin/manage_ebs' do
  source 'manage_ebs.rb'
  owner 'root'
  group 'root'
  mode  '0700'
  action :create_if_missing
  notifies :run, "execute[attach_ebs_vol]", :immediately
end


execute 'attach_ebs_vol' do
  command "/usr/bin/manage_ebs #{node['ebs_manage']['region']} #{node['ec2']['instance_id']} #{node['ebs_manage']['tag_key']} #{node['ebs_manage']['tag_value']} #{node['ebs_manage']['device']}"
  not_if "ls -la #{node['ebs_manage']['device']}"
  action :run
  notifies :run, "ruby_block[set_force_format]", :immediately
end

ruby_block 'set_force_format' do
  block do
    if node['ebs_manage']['force_format']
      node.default['ebs_manage']['run_format'] = true
    end
  end
  action :nothing
end
