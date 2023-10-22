#! /usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
mkdir -p catkin_ws2/src && cd catkin_ws2/src
sudo apt install python3-catkin-tools ros-noetic-ros-industrial-cmake-boilerplate ros-noetic-eigen-stl-containers ros-noetic-object-recognition-msgs ros-noetic-graph-msgs ros-noetic-octomap-msgs ros-noetic-random-numbers libbullet-dev ros-noetic-opw-kinematics ros-noetic-pybind11-catkin ros-noetic-warehouse-ros ros-noetic-ompl ros-noetic-ruckig ros-noetic-ifopt ros-noetic-eigenpy ros-noetic-rosparam-shortcuts libbullet-extras-dev -y

git clone https://github.com/ros-planning/geometric_shapes.git -b noetic-devel

git clone https://github.com/ros-planning/moveit.git -b 1.1.12
cd moveit/moveit_planners && rm -rf trajopt 
git clone https://github.com/QishuaiLiu/trajopt.git && cd ../..
git clone https://github.com/ros-planning/moveit_msgs.git
git clone https://github.com/ros-planning/moveit_resources.git -b master
git clone https://github.com/ros-planning/moveit_tutorials.git
git clone https://github.com/ros-planning/moveit_visual_tools.git -b noetic-devel
git clone https://github.com/ros-planning/panda_moveit_config.git -b noetic-devel
## modify the config file
sed -i 's/type: 3/type: 2/g' panda_moveit_config/config/trajopt_planning.yaml

git clone https://github.com/PickNikRobotics/rviz_visual_tools.git
git clone https://github.com/ros-planning/srdfdom.git -b noetic-devel
git clone https://github.com/tesseract-robotics/tesseract.git -b 0.17.0
cd tesseract && git submodule update --init --recursive && git clone https://github.com/flexible-collision-library/fcl.git -b 0.6.1
cd ..
git clone https://github.com/tesseract-robotics/trajopt.git
cd trajopt && git checkout 95daa86f5bf94369e1ffcffa304b16604bb42621 && cd ../..

source /opt/ros/noetic/setup.bash
catkin build
