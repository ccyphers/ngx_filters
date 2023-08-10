# Piss Off Filter
Tell all the evil bots/people trying to use your web server as a proxy, to PISS OFF! In the event that the `Host` header doesn not match the server name redirect the offender to some black hole of your choice.

If your ngx_lua or openresty enabled server has multiple server blocks for different domains ensure to populate the whitelist with a space separated list of all domain names.

# Example
`http {}`

```
   init_by_lua_block {
    -- in case you have multiple domains and server blocks
    local whitelist = "domain1.com domain2.com"
    local redirect = "https://blackhole.pissoff.cc"
    piss_off_filter = require("filters/piss_off"):new({whitelist = whitelist, redirect = redirect})
  }
```

In server blocks before any locations include:

```
access_by_lua_block {
  piss_off_filter:run()
}
```

This is just a small example of many filters I use in hosting sites. Additional filters might be added here at a later time.

