local piss_off_filter = {}

function piss_off_filter:new(params)
  params = params or {}
  params.redirect = params.redirect or 'http://localhost'
  params.whitelist = params.whitelist or "localhost"
  setmetatable(params, self)
  self.__index = self
  return params
end

function string:split( search, out )
  if not out then
    out = { }
  end

  local start = 1
  local split_start, split_end = string.find( self, search, start )

  while split_start do
    table.insert( out, string.sub( self, start, split_start-1 ) )
    start = split_end + 1
    split_start, split_end = string.find( self, search, start )
  end

  table.insert( out, string.sub( self, start ) )
  return out
end


function piss_off_filter:run()
  local host = ngx.req.get_headers()["Host"]

  if not host then
    host = "*******MISSING_HOST******"
  end

  local allowed = false
  local wl_tbl = self.whitelist:split(" ")

  for i = 1, #wl_tbl do  
    wl_item = wl_tbl[i]
    if wl_item == host then
      allowed = true
      break
    end
  end

  if not allowed then
    ngx.log(ngx.ERR, "Unwanted proxy attempt to " .. host)
    ngx.redirect(self.redirect .. "/" .. host)
  end
end

return piss_off_filter