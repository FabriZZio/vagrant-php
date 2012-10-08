# webgrind
# vhost alias provided in apache recipe
execute "clone-webgrind" do
    command "git clone git://github.com/jokkedk/webgrind.git /usr/share/webgrind"
    creates "/usr/share/webgrind"
end