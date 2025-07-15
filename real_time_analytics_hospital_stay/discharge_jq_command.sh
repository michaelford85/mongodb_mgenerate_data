# 1. Wrap raw date lines into admissionDate documents
jq '{ admissionDate: . }' stays_raw.json > stays_admit.json

# 2. Add dischargeDate based on admissionDate + random 1-90 days
jq '(
  .dischargeDate = (
    (
      (.admissionDate.admissionDate["$date"] 
       | sub("\\.[0-9]+Z$"; "Z")    # strips .xxx milliseconds
       | strptime("%Y-%m-%dT%H:%M:%SZ") 
       | mktime)
      + (86400 * (1 + ((now * 1000) % 90 | floor))) #
    )
    | todateiso8601
  )
)' stays_admit.json > stays.json