#!/bin/bash

# Default increment type
increment_type="patch"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --major|-M)
      increment_type="major"
      shift
      ;;
    --minor|-m)
      increment_type="minor"
      shift
      ;;
    --patch|-p)
      increment_type="patch"
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--major|-M] [--minor|-m] [--patch|-p]"
      echo "  --major, -M: Increment major version (x.0.0)"
      echo "  --minor, -m: Increment minor version (x.y.0)"
      echo "  --patch, -p: Increment patch version (x.y.z) [default]"
      exit 0
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

# Get current tag
current_tag=$(git describe --tags --abbrev=0 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "No tags found. Creating initial tag v1.0.0"
  new_tag="v1.0.0"
else
  # Remove 'v' prefix and split into parts
  version=${current_tag#v}
  IFS='.' read -ra VERSION_PARTS <<< "$version"
  
  # Increment based on type
  case $increment_type in
    "major")
      ((VERSION_PARTS[0]++))
      VERSION_PARTS[1]=0
      VERSION_PARTS[2]=0
      ;;
    "minor")
      ((VERSION_PARTS[1]++))
      VERSION_PARTS[2]=0
      ;;
    "patch")
      ((VERSION_PARTS[2]++))
      ;;
  esac
  
  new_tag="v${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2]}"
fi

echo "Current tag: $current_tag"
echo "New tag: $new_tag"
echo "Increment type: $increment_type"

# Create and push the new tag
git tag -a $new_tag -m "Release $new_tag ($increment_type increment)"
git push origin $new_tag

echo "Created and pushed tag: $new_tag"
