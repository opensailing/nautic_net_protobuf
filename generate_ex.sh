#! /bin/bash
set -euo pipefail
#
# (Re-)generates protobuf Elixir modules from lib/racing_org/tracker/protobuf/*.proto definition files.
#
# Run this from the project root.
#

proto_dir="./lib/racing_org/tracker/protobuf"
tmp_dir="$(mktemp -d)"
generated_dir="$tmp_dir/racing_org/tracker/protobuf/lib/racing_org/tracker/protobuf"

trap 'rm -rf "$tmp_dir"' EXIT

echo 'Generating Elixir from Protobuf definitions...'
protoc --elixir_out="$tmp_dir" --elixir_opt=package_prefix=RacingOrg.Tracker.Protobuf "$proto_dir"/*.proto
cp "$generated_dir"/*.pb.ex "$proto_dir"/

echo 'Formatting...'
mix format "$proto_dir"/*.pb.ex

echo 'Done!'
