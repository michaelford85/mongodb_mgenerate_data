#!/bin/bash
# Step 1: Wrap raw ISO date lines into admissionDate structure
jq '{ admissionDate: . }' stays_raw.json > stays_admit.json

# Step 2: Add dischargeDate based on admissionDate + 1-90 day offset
jq 'map(
  .dischargeDate = (
    (
      (.admissionDate["$date"]
       | sub("\\.[0-9]+Z$"; "Z")
       | strptime("%Y-%m-%dT%H:%M:%SZ")
       | mktime)
      + (86400 * (1 + (now % 90 | floor)))
    )
    | todateiso8601
  )
)' stays_admit.json > stays_90days.json

# Step 3: Reshape into final stays format
jq 'map({
  patientId: .patientId,
  admissionDate: { "$date": .admissionDate["$date"] },
  dischargeDate: { "$date": .dischargeDate },
  unit: .unit,
  entryPoint: .entryPoint,
  diagnosis: .diagnosis,
  procedures: .procedures,
  attendingPhysician: .attendingPhysician
})' stays_90days.json > stays.json
