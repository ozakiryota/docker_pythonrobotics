FROM conda/miniconda3

########## basis ##########
RUN apt-get update && apt-get install -y \
	vim \
	wget \
	unzip \
	git
########## nvidia-docker1 hooks ##########
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
########## Requirements ##########
RUN pip install coverage && \
	pip install numpy && \
	pip install scipy && \
	pip install matplotlib && \
	pip install pandas
	# pip install cvxpy
########## Main ##########
RUN cd /home && \
	git clone https://github.com/AtsushiSakai/PythonRobotics && \
	cd PythonRobotics
	# /bin/bash runtests.sh
# keep latest
RUN echo "#!/bin/bash\n\git pull origin master" >> /home/PythonRobotics/git_pull.sh && \
	chmod 777 /home/PythonRobotics/git_pull.sh && \
	echo "/home/PythonRobotics/git_pull.sh" >> ~/.bashrc
######### initial position ##########
WORKDIR /home/PythonRobotics
