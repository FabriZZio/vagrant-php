# capistrano
execute "capistrano-add-sources" do
    command "gem sources -a http://gems.github.com/"
    command "gem install capistrano"
    command "gem install capistrano-ext"
end

execute "install-capistrano" do
    command "gem install capistrano"
end

execute "install-capistrano-ext" do
    command "gem install capistrano-ext"
end