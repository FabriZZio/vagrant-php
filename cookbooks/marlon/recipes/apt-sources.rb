apt_repository "launchpad" do
  #uri "http://ppa.launchpad.net/nathan-renniewaldock/ppa/ubuntu"
  uri "http://ppa.launchpad.net/nginx/php5.3/ubuntu"
  # http://ppa.launchpad.net/txwikinger/php5.2/ubuntu
  components ["lucid","main"]
  deb_src 1
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
end