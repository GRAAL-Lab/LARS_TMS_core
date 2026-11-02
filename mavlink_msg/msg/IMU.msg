std_msgs/Header header
uint64 time_usec # Timestamp us (ms for scaled msg)
int16 xacc # X acceleration (raw) (mG for scaled msg)
int16 yacc #  Y acceleration (raw) (mG for scaled msg)
int16 zacc # Z acceleration (raw) (mG for scaled msg)
int16 xgyro # Angular speed around X axis (raw) (mrad/s for scaled msg)
int16 ygyro # Angular speed around Y axis (raw) (mrad/s for scaled msg)
int16 zgyro # Angular speed around Z axis (raw) (mrad/s for scaled msg)
int16 xmag # X Magnetic field (raw) (mgauss for scaled msg)
int16 ymag # Y Magnetic field (raw) (mgauss for scaled msg)
int16 zmag # Z Magnetic field (raw) (mgauss for scaled msg)
uint8 id
int16 temperature # cdegC