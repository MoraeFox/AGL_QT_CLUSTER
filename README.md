# Description
refgui is cluster reference GUI implementation in Automotive Grade Linux(AGL) Instrument Cluster Expert Group.  

# Requirement
These libraries are required.  
- Qt5.13 or later version
- cluster-service which is implemented in AGL

# Building
```sh
mkdir <build_dir>
cd <build_dir>
cmake ..
make
```

# Installing
```sh
sudo make install
```

Application is installed in /opt/apps. If you would like to change installation directory. You can change it by using APPS_INST_DIR option during building process:  
```sh
cmake .. -DAPPS_INST_DIR=<installation directory>
```

# Usage

```sh
cd <installation directory>
./cluster
```

# License(Software)
refgui is licensed under the [MIT](https://github.com/agl-ic-eg/refgui/blob/main/LICENSE) license.  

# License(Font)
Inter Font is included in this software and Inter Font is licensed under SIL Open Font License 1.1.  
[https://github.com/rsms/inter](https://github.com/rsms/inter)  

