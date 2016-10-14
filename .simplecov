SimpleCov.start do
  root File.dirname(__FILE__)

  add_filter '/testing/'

  merge_timeout 300
end
