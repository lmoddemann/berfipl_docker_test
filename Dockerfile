# Use the official Ubuntu image as the base
FROM ubuntu:22.04

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    build-essential \
    cmake \
    gfortran \
    python3 \
    python3-pip \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Add conda to PATH
ENV PATH="/opt/conda/bin:$PATH"

RUN git clone https://github.com/lmoddemann/berfipl_docker_test.git /workspace/berfipl_docker

# Set the working directory to your cloned repo
WORKDIR /workspace/berfipl_docker

# Create conda environment from the environment.yml file (assuming it is in the repo)
RUN conda env create -f environment.yml

# Activate the environment
RUN echo "source activate myenv" > ~/.bashrc
ENV PATH /opt/conda/envs/myenv/bin:$PATH

# Install OpenModelica (if needed)
RUN wget https://bintray.com/openmodelica/packaging/download_file?file_path=openmodelica/1.21.0/OpenModelica-1.21.0-Ubuntu-22.04-x86_64.tar.gz -O openmodelica.tar.gz \
    && tar -xzf openmodelica.tar.gz \
    && mv OpenModelica-1.21.0 /opt/openmodelica \
    && rm openmodelica.tar.gz

# Set environment variables for OpenModelica
ENV PATH="/opt/openmodelica/bin:$PATH"

# Define the entrypoint to run your Python script
ENTRYPOINT ["python3", "your_script.py"]