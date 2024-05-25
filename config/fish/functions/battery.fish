function battery
acpi | awk -F "," '{print $2}'
end
