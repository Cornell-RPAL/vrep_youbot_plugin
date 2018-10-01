# vrep_youbot_plugin

## Installation

~1) Install youBot ROS packages e.g.~
~$ sudo apt-get install ros-indigo-youbot-driver-ros-interface~

I don't believe you actually need these packages, just base ROS Melodic. If I'm wrong, edit this.

2) Install v-rep (http://www.v-rep.eu/) into i.e. ~/V-REP

3) Clone the repository into your catkin workspace

4) Clone the following dependencies into your catkin workspace:
* https://github.com/mas-group/youbot_description/tree/kinetic-devel
* https://github.com/wnowak/brics_actuator

Note the particular branches used.

5) Build the workspace

```bash
    $ catkin build
```

6) Copy the compiled library `libv_repExtyouBot.so` into your V-REP directory

```bash
    $ cp ~/catkin_ws/devel/lib/libv_repExtyouBot.so ~/V-REP
```

## Usage


1) Start ROS (optional; `roslaunch` will do this for you)

```bash
    $ roscore
```

2) Launch ROS components

```bash
    $ roslaunch vrep_youbot_plugin vrep_youbot.launch
```

3) Start v-rep

```bash
    $ ~/V-REP/v-rep.sh
```

4) Load the scene file in v-rep (.../vrep_youbot_plugin/scenes/...)

5) Start the simulation

Note: the simulation must be running before you can control the youBot!


Test ROS plugin
--
1) You can try running `rostopic pub /cmd_vel` with an appropriate `Twist` and checking if the
youBot moves to confirm that you can control the youBot through ROS.


Have fun!
