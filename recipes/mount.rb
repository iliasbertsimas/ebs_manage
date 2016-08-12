


execute 'wait_until_ready' do
  command "sleep 120"
  not_if  "file -s #{node['ebs_manage']['device']} | grep data"
end

execute 'create_mountpoint' do
  command "mkdir -p #{node['ebs_manage']['mount_point']}"
  not_if "test -d #{node['ebs_manage']['mount_point']}"
end

execute 'mount_device' do
    command "mount #{node['ebs_manage']['device']} #{node['ebs_manage']['mount_point']}"
    not_if  "mountpoint -q #{node['ebs_manage']['mount_point']}"
end
