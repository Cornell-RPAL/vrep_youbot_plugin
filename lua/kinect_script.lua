function sysCall_init()
  depthCam=sim.getObjectHandle('kinect_visionSensor')
  depthView=sim.floatingViewAdd(0.9,0.9,0.2,0.2,0)
  sim.adjustView(depthView,depthCam,64)

  colorCam=sim.getObjectHandle('kinect_camera')
  colorView=sim.floatingViewAdd(0.69,0.9,0.2,0.2,0)
  sim.adjustView(colorView,colorCam,64)


  name = sim.getScriptSimulationParameter(sim.handle_self,'rosname')


  simExtROS_enablePublisher(name.."/rgbimage/image_raw",1,simros_strmcmd_get_vision_sensor_image,colorCam,0,'')
  --simExtROS_enablePublisher("/kinect/depthimage/image_raw",1,simros_strmcmd_get_vision_sensor_image,depthCam,0,'')
  --simExtROS_enablePublisher(name.."/depthimage/vrep",1,simros_strmcmd_get_vision_sensor_depth_buffer,depthCam,0,'')


  simExtROS_enablePublisher(name.."/rgbimage/camera_info",1,simros_strmcmd_get_vision_sensor_info,colorCam,0,'')
  --simExtROS_enablePublisher("/kinect/depthimage/camera_info",1,simros_strmcmd_get_vision_sensor_info,depthCam,0,'')

  youBotHandle = sim.getObjectHandle("youBot_ref")
  simExtROS_enablePublisher("/tf",1,simros_strmcmd_get_transform,colorCam,youBotHandle,'/kinect_visionSensor%/base_link')
  simExtROS_enablePublisher("/tf",1,simros_strmcmd_get_transform,depthCam,youBotHandle,'/kinect_depthSensor%/base_link')

end

function sysCall_actuation()
end

function sysCall_sensing()
    -- put your sensing code here
end

function sysCall_cleanup()
    -- do some clean-up here
end
