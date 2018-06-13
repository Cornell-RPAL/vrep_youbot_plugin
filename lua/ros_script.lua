function sysCall_init()
   joint_pub = simROS.advertise("/joint_states", "sensor_msgs/JointState")
   clock_pub = simROS.advertise("/clock", "rosgraph_msgs/Clock")

   joint_names = {"arm_joint_1",
                  "arm_joint_2",
                  "arm_joint_3",
                  "arm_joint_4",
                  "arm_joint_5",
                  "gripper_finger_joint_l",
                  "gripper_finger_joint_r",
                  "wheel_joint_fl",
                  "wheel_joint_bl",
                  "wheel_joint_br",
                  "wheel_joint_fr"}
   arm_handles = { sim.getObjectHandle("arm_joint_1"),
               sim.getObjectHandle("arm_joint_2"),
               sim.getObjectHandle("arm_joint_3"),
               sim.getObjectHandle("arm_joint_4"),
               sim.getObjectHandle("arm_joint_5")}

   rosCreateJointControllerSubscriber("arm_controller", arm_handles)

   gripper_handles = { sim.getObjectHandle("gripper_finger_joint_l"),
                       sim.getObjectHandle("gripper_finger_joint_r")}

   rosCreateJointControllerSubscriber("gripper_controller", gripper_handles)

   wheel_handles = { sim.getObjectHandle("wheel_joint_fl"),
                     sim.getObjectHandle("wheel_joint_bl"),
                     sim.getObjectHandle("wheel_joint_br"),
                     sim.getObjectHandle("wheel_joint_fr") }

   rosCreateSwedishBaseController("/cmd_vel", wheel_handles, 8.15)

   youBot = sim.getObjectHandle("youBot_ref")

   kinectHandle = sim.getObjectHandle("kinect_visionSensor")
   rosCreatePointCloudPubslisher("/kinect", kinectHandle, "/kinect_depthSensor")

   rosCreateLaserScanPubslisher("/scan_front","Hokuyo_URG_04LX_UG01_HOKUYO","/base_laser_front_link");
   seq = 0
   handles = {}
   for i, v in ipairs(arm_handles) do
      handles[i] = v
   end

   for i, v in ipairs(gripper_handles) do
      handles[i + #arm_handles] = v
   end

   for i, v in ipairs(wheel_handles) do
      handles[i + #arm_handles + #gripper_handles] = v
   end
end

function sysCall_actuation()
   simROS.publish(clock_pub,{ clock = sim.getSimulationTime() })
   t = sim.getSystemTime()
   p = sim.getObjectPosition(youBot, -1)
   o = sim.getObjectQuaternion(youBot, -1)
   transform = {
      header = {
         stamp = t,
         frame_id = "world"
      },
      child_frame_id = "base_link",
      transform = {
         -- ROS has definition x=front y=side z=up
         translation = {x = p[1], y = p[2], z = p[3]},--V-rep
         rotation = {x = o[1], y = o[2], z = o[3], w = o[4]}--v-rep
      }
   }

   simROS.sendTransform(transform)

   header = { seq = seq, stamp = t, frame_id = "1" }
   seq = seq + 1
   velocities = {}
   positions = {}
   efforts = {}

   for i, n in ipairs(joint_names) do
      positions[i] = sim.getJointPosition(handles[i])
      -- Note: I'm not really at all sure if this is the correct method to use, but I don't know
      -- another, so...
      velocities[i] = sim.getJointTargetVelocity(handles[i])
      efforts[i] = sim.getJointForce(handles[i])
   end
   
   simROS.publish(joint_pub,
                  {header = header,
                   name = joint_names,
                   position = positions,
                   velocity = velocities,
                   effort = efforts})
end

function sysCall_sensing()
end

function sysCall_cleanup()
   -- do some clean-up here
   simROS.shutdownPublisher(joint_pub)
end
