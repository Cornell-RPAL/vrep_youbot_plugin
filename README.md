vrep_youbot_plugin
==================

Installation
--

1) Install youBot ROS packages e.g.  
```
$ sudo apt-get install ros-indigo-youbot-driver-ros-interface
```
2) Install v-rep (http://www.v-rep.eu/) into i.e. ~/V-REP

3) Clone the repository into your catkin workspace

4) Compile

    $ catkin build

5) Copy the compiled library libv_repExtyouBot.so into your V-REP directory

    $ sudo cp ~/catkin_ws/devel/lib/libv_repExtyouBot.so ~/V-REP

Usage
--

1) Start ROS (optional; `roslaunch` will do this for you)

    $ roscore

2) Launch ROS components

    $ roslaunch vrep_youbot_plugin vrep_youbot.launch

3) Start v-rep

    $ ~/V-REP/v-rep.sh

4) Load the scene file in v-rep (.../vrep_youbot_plugin/scenes/...)

5) Start the simulation

Note: the simulation must be running before you can control the youBot!


Test ROS plugin
--
1) You can try running `rostopic pub /cmd_vel` with an appropriate `Twist` and checking if the
youBot moves to confirm that you can control the youBot through ROS.


Have fun!
