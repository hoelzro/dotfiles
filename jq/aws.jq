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
