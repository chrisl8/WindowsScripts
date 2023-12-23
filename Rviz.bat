call c:\opt\ros\noetic\x64\setup.bat
set ROS_MASTER_URI=http://192.168.1.118:11311
REM The next two should be the IP of the Windows machine.
REM If setting 2D Nav Goals doesn't work, check the following IPs
set ROS_HOSTNAME=192.168.1.128
set ROS_IP=192.168.1.128
c:\opt\ros\noetic\x64\bin\rviz.exe -d "c:\Users\chris\OneDrive\Desktop\navigation.rviz"
