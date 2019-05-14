# Logstash Ipinfo Filter 
This is a filter plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Documentation

The Ipinfo filter adds geolocation information for IP addresses from logstash events via the Ipinfo API.



## Usage
### 1. Installation
You can use the built-in plugin tool of Logstash to install the filter:
```
$LS_HOME/bin/logstash-plugin install logstash-filter-ipinfo
```

Or you can build it yourself:
```
git clone https://github.com/nsherron90/logstash-filter-ipinfo.git
bundle install
gem build logstash-filter-ipinfo.gemspec
$LS_HOME/bin/logstash-plugin install logstash-filter-ipinfo-1.1.0.gem
```

### 2. Filter Configuration
Add the following inside the filter section of your logstash configuration:

```sh
filter {
  ipinfo {
    ip => "ip_value"                 # string (required, reference to ip address field)
    token => "your_ipinfo_token"      # string (optional, no default)
    target => "ipinfo"            # string (optional, default = ipinfo)
  }
}
```

Print plugin version:

``` bash
bin/logstash-plugin list --verbose | grep ipinfo
```

Example for running logstash from `cli`:

``` bash
bin/logstash --debug -e \
'input {
    stdin {}
}


filter {
  ipinfo {
    ip => "%{message}"
   }
}

output {
   stdout {
      codec => rubydebug {
          metadata => true
          }
      }
}'
```



## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and maintainers or community members  saying "send patches or die" - you will not see that here.

It is more important to the community that you are able to contribute.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elasticsearch/logstash/blob/master/CONTRIBUTING.md) file.
