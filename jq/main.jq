def get_tag(tag_name): tag_name as $tag_name | .Tags | arrays | map(select(.Key == $tag_name))[0].Value ;

def ddb_unpack(item):
    item |
    with_entries({
        key: .key,
        value: (.value | to_entries[0] | if .key == "NULL" then
            null
        elif .key == "L" then
            .value | map(ddb_unpack({key:.}).key) # XXX this sucks
        elif .key == "M" then
            ddb_unpack(.value)
        else
            .value
        end)
    }) ;

def ddb_unpack:
    ddb_unpack(.) ;

def parse_duration:
  [scan("(?:(\\d+)m)|(?:(\\d+[.]\\d+)s)|(?:(\\d+[.]\\d+)ms)") | (60000 * ((.[0] // "0") | tonumber)) + (1000 * ((.[1] // "0") | tonumber)) + ((.[2] // "0") | tonumber) ] | reduce .[] as $item (0; . + $item) ;

def parse_time:
  (if endswith("Z") then 0 else capture("(?<sign>[-+])(?<offset_hours>\\d+):(?<offset_minutes>\\d+)$") | (if .sign == "-" then -1 else 1 end) * (.offset_hours | tonumber) * 3600 + (.offset_minutes | tonumber) * 60 end) as $tz_offset | strptime("%Y-%m-%dT%H:%M:%S%Z") | mktime | . - $tz_offset ;

def format_time:
  localtime | mktime | todate | rtrimstr("Z") ;

def logfmt:
  [ scan("(\\w+)=(?:(?:\"([^\"]+)\")|(\\S+))\\s*") | {key: .[0], value: (.[1] // .[2])}] | from_entries ;
