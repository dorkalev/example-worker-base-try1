FROM python:latest

WORKDIR /tmp
COPY requirements*.txt /tmp/

# install pip and python

RUN apt-get update


RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade pillow
RUN apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 -y
# RUN pip3 install pygobject
RUN pip3 install --upgrade cython
RUN pip3 install wheel
RUN pip3 install Cmake
# Use the latest Python official image

# Copy the requirements file if you have one
COPY requirements.txt ./
RUN pip3 install boto3

# Install any dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements*.txt

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN apt autoremove -y
COPY step_py_runner /srv/scripter/step_py_runner
WORKDIR /srv/scripter
COPY . /srv/scripter

# Command to run your Python application
CMD ["python", "./your_script.py"]
