


if node['ebs_manage']['run_format']

  execute 'force_format_device' do
    command  "mkfs.xfs -f #{node['ebs_manage']['device']}"
    action :run
  end

else

  execute 'format_device' do
    command  "mkfs.xfs #{node['ebs_manage']['device']}"
    not_if   "file -s #{node['ebs_manage']['device']} | grep filesystem"
  end

end
