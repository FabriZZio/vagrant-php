# capistrano
execute "capistrano-add-sources" do
    command "gem sources -a http://gems.github.com/"
end

execute "install-capistrano" do
    command "gem install capistrano"
    not_if "gem list | grep capistrano"
end

execute "install-capistrano-ext" do
    command "gem install capistrano-ext"
    not_if "gem list | grep capistrano-ext"
end