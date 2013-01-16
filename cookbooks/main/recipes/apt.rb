# dotdeb repository
apt_repository "dotdeb" do
  uri "http://packages.dotdeb.org"
  distribution "stable"
  components ["all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
  deb_src true
end