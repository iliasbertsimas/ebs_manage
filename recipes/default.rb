#
# Cookbook Name:: ebs_manage
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


apt_package 'ruby'

gem_package 'aws-sdk'

apt_package 'xfsprogs'

apt_package 'lvm2'

include_recipe 'ebs_manage::attach'

if node['ebs_manage']['format'] || node['ebs_manage']['force_format']
  include_recipe 'ebs_manage::format'
end

if node['ebs_manage']['mount_point'] != 'default'
  include_recipe 'ebs_manage::mount'
end
