SimpleCov.start do
  root File.dirname(__FILE__)

  add_filter '/features/'
  add_filter '/spec/'

  merge_timeout 300
end
