use t::APIOAK 'no_plan';


run_tests();


__DATA__

=== TEST 1: match get method routing success

--- config
location /t {
    content_by_lua_block {
        local routing = require('resty.oakrouting')
        local oak     = routing.new()


        oak:get("/test/get/{name}", function(params)
            ngx.say("TEST GET REQUEST OK, PARAM IS " .. params.name)
        end)


        local succeed = oak:dispatch("/test/get/APIOAK", "GET")
        if not succeed then
            ngx.say("TEST GET REQUEST FAIL")
        end
    }
}
--- request
GET /t
--- no_error_log
[error]
--- response_body
TEST GET REQUEST OK, PARAM IS APIOAK
