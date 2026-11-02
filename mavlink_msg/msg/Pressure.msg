std_msgs/Header header
uint32 time_boot_ms # Timestamp (time since system boot). ms
float32 press_abs # Absolute pressure (hPa for scaled msg)
float32 press_diff # Differential pressure
int16 temperature # Absolute pressure temperature (cdegC for scaled msg)
int16 temperature_press_diff # Differential pressure temperature (0, if not available) (cdegC for scaled msg)