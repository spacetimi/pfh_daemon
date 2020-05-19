# Split the raw data into tokens
cat raw.dat| grep -v "locked##" | awk '{split($0, a, "##"); print a[1], a[2], a[3]}'

# List of all applications used
cat raw.dat| grep -v "locked##" | awk '{split($0, a, "##"); print a[2]}' | sort | uniq

# Print period-counts of all applications used (each period is 15 seconds)
cat raw.dat| grep -v "locked##" | awk '{split($0, a, "##"); print a[2]}' | sort | uniq | xargs -t -I app_name grep -c app_name raw.dat

# Print hours-of-usage of all applications used (excluding some obviously unproductive ones)
cat raw.dat | grep -v "locked##" | grep -vi "facebook" | grep -vi "youtube" | awk '{split($0, a, "##"); print a[2]}' | sort | uniq | xargs -I app_name sh -c 'echo app_name; grep -c "app_name" raw.dat | xargs -I n echo n "* 15 / 3600" | bc -l; echo ""'

# Prints total hours of "Productive" use
cat raw.dat | grep -v "locked##" | grep -vi "facebook" | grep -vi "youtube" | wc -l | xargs -I n echo n "* 15 / 3600" | bc -l

