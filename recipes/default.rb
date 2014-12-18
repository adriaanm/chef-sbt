#
# Cookbook Name:: chef-sbt
# Recipe:: default
#
# Copyright 2013 Matt Farmer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

launcher_file_path = File.join(node[:sbt][:launcher_path], "sbt-launch.jar")
script_file_path = File.join(node[:sbt][:bin_path], node[:sbt][:script_name])

directory node[:sbt][:launcher_path] do
  recursive true
end

remote_file launcher_file_path do
  source "https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/#{node[:sbt][:version]}/sbt-launch.jar"
  action :create

  # not_if "java -jar #{launcher_file_path} \"sbt-version\" | tail -1 | awk '{print $2}' | grep '#{node[:sbt][:version]}'"
end

# execute "sudo chown root:root #{launcher_file_path}"
# execute "sudo chmod 0755 #{launcher_file_path}"

directory node[:sbt][:bin_path] do
  recursive true
end

template script_file_path do
  source "sbt.erb"
  variables({
    :java_options => node[:sbt][:java_options],
    :launcher_file => launcher_file_path
  })

  action :create

  # owner "root"
  # group "root"
  mode 0755
end

# if node['platform_family'] == "windows"
#   windows_path win_friendly_path(node[:sbt][:bin_path]) do
#     action :add
#   end
# else
#
# end
