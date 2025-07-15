# MongoDB mgenerate data

This repository uses `mgeneratejs` to generate structured, semi-random JSON data according to a template object.

## Example

Given the file at [example_data/example.json](./example_data/example.json):
```
{
    "name": "$name",
    "age": "$age",
    "emails": {
        "$array": {
            "of": "$email",
            "number": 3
        }
    }
}
```

Run the following command to flatten the json and generate random json documents with this template:
```
mgeneratejs "$(jq -c . exmaple.json)" -n 5
```
In this example, `5` is the number of json documents to generate. The output will look similar to this:
```
{"name":"Sam Gutierrez","age":65,"emails":["zek@ozijojij.bf","detawin@ci.ke","baz@zenej.cd"]}
{"name":"Sally Hammond","age":61,"emails":["wun@boluwu.de","cecwu@ha.va","isirihole@ditacem.bo"]}
{"name":"Estelle Anderson","age":62,"emails":["urejec@sa.lu","odimobwa@lugnamaka.tz","ja@kaj.ps"]}
{"name":"Philip Hart","age":23,"emails":["uratu@ja.ly","ejaluomu@cu.gm","fiigo@tuklomace.pn"]}
{"name":"Sally Gregory","age":19,"emails":["zurfoz@ucdaaz.ps","etavid@mumve.td","cewtar@je.bg"]}
```

If you want to pipe the data directly to a file and use mongoimport to pass the data into your MongoDB database, run the following commands:
```
mgeneratejs "$(jq -c . exmaple.json)" -n 5 > data.json
```
```
mongoimport \
  --uri "mongodb+srv://<cluster-name>.xxxxxx.mongodb.net/<database_name>" \
  --username "<database_username>" \
  --password "<database_password>" \
  --collection <collection_name> \
  --file data.json \
  --type json
```