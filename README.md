# DDSCore
This project contains the sample HelloWorld DDS publisher and Subscriber implementation

##Installation

###Eclipse IDE

#### Linux - Ubuntu 64x
1. Set java path
..*Right click on the project -> properties -> set java build path
2. set environment variable
..1Right click Java which contains main class -> Run As -> Run Configurations -> Environments (tab)
..2Click on New button
..3 Name: `LD_LIBRARY_PATH`  , VALUE: `${project_loc}/ThirdParty/ndds.5.1.0/lib/x64Linux2.6gcc4.4.5jdk`

#### Linux - Ubuntu 32x
1. Set java path
..*Right click on the project -> properties -> set java build path
2. set environment variable
..1Right click Java which contains main class -> Run As -> Run Configurations -> Environments (tab)
..2Click on New button
..3 Name: `LD_LIBRARY_PATH` , VALUE: `${project_loc}/ThirdParty/ndds.5.1.0/lib/i86Linux2.6gcc4.4.5jdk`

#### Windows 64x
1. Set java path
..*Right click on the project -> properties -> set java build path
2. set environment variable
..1Right click Java which contains main class -> Run As -> Run Configurations -> Environments (tab)
..2Click on New button
..3 Name: `PATH`  , VALUE: `${project_loc}\ThirdParty\ndds.5.1.0\lib\x64Win64jdk`

